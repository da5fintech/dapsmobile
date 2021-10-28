import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/errors.dart';
import 'package:daps/models/notification-model.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/services/account-service.dart';
import 'package:daps/services/autosweep-service.dart';
import 'package:daps/services/bills-payment-service.dart';
import 'package:daps/services/daps-authentication-service.dart';
import 'package:daps/services/direct-pay-service.dart';
import 'package:daps/services/eloading-service.dart';
import 'package:daps/services/firestore-service.dart';
import 'package:daps/services/instapay-service.dart';
import 'package:daps/services/opt-service.dart';
import 'package:daps/services/pesonet-service.dart';
import 'package:daps/services/request-money-service.dart';
import 'package:daps/services/save-suggestions-services.dart';

import '../main.dart';

class TransactionService extends FireStoreService {
  AccountService accountService;
  DapsAuthenticationService dapsAuthenticationService;

  TransactionService({this.accountService, this.dapsAuthenticationService}) : super(collectionName: "accounts");

  Future<TransactionProcessingResponse> process(
      UserModel user, TransactionModel transaction) async {
    TransactionProcessingResponse response;

    if(await checkBalance(user, transaction)) {
      try {
        if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
          var service = getIt.get<EloadingService>();
          var saveSuggestion = getIt.get<SaveSuggestionsServices>();
          response =
          await service.process(transaction.recipient, transaction.product);
          await saveSuggestion.saveNumber(
              transaction.recipient, transaction.offering);
        } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
          var service = getIt.get<BillsPaymentService>();
          response = await service.process(transaction.product);
        } else if (transaction.offering ==
            SwipeServiceOffering.REMITTANCE_INSTAPAY) {
          var saveSuggestion = getIt.get<SaveSuggestionsServices>();
          var service = getIt.get<InstapayService>();
          response =
          await service.process(transaction.product, transaction.amount);
          await saveSuggestion.saveAccountNumbers(
              transaction.product, transaction.offering);
        } else if (transaction.offering ==
            SwipeServiceOffering.REMITTANCE_PESONET) {
          var saveSuggestion = getIt.get<SaveSuggestionsServices>();
          var service = getIt.get<PesonetService>();
          response =
          await service.process(transaction.product, transaction.amount);
          await saveSuggestion.saveAccountNumbers(
              transaction.product, transaction.offering);
        } else if (transaction.offering == SwipeServiceOffering.AUTOSWEEP) {
          var saveSuggestion = getIt.get<SaveSuggestionsServices>();
          var service = getIt.get<AutosweepService>();
          response =
          await service.process(transaction.product, transaction.amount);
          await saveSuggestion.savePlateNumbers(transaction.product);
        } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
          var updateRequest = getIt.get<RequestMoneyService>();
          var saveSuggestion = getIt.get<SaveSuggestionsServices>();
          var service = getIt.get<DirectPayService>();
          DirectPayProduct product = transaction.product;
          response = await service.process(
              transaction.product, transaction.amount, user);
          await saveSuggestion.saveNumber(
              product.mobileNumber, transaction.offering);
          if(product.notification != null) {
            await updateRequest.updateRequestStatus(user, product.notification);
          }
        }

        ///Deduct user balance if any services
        ///return true;
        if (response.status) {
          var otpService = getIt.get<OtpService>();
          await tryChargeAccount(user, transaction);
          await recordTransaction(user, transaction, response);
          if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
            DirectPayProduct product = transaction.product;
            await otpService.sendReferenceNumber(
              senderName: user.displayName,
              senderMobileNumber: user.mobileNumber,
              senderMessage: product.message,
              amount: product.amount.toString(),
              receiverMobileNumber: product.mobileNumber,
              referenceNumber: response.reference,
            );
          }
          return response;
        }
        return response;
      } on NotEnoughFundsError catch (e) {
        response = GenericProcessingResponse(
            status: false, reference: "", message: e.message, result: e.message);

        await recordTransaction(user, transaction, response);
        return response;
      } catch (e) {
        return response;
      }
    } else {
      return GenericProcessingResponse(
          status: false, reference: "", message: "Insufficient funds", result: "Insufficient funds");
    }

  }

  Future<bool> checkBalance(
      UserModel user, TransactionModel transaction) async {
    double fee = 30;
    double balance = await dapsAuthenticationService.balanceSyncing(user.credentials);
    double transactionAmount = getTotalAmount(transaction);

    return transactionAmount + fee > balance ? false : true;
  }

  Future<bool> tryChargeAccount(
      UserModel user, TransactionModel transaction) async {
    double balance = await dapsAuthenticationService.balanceSyncing(user.credentials);
    double totalAmount = getTotalAmount(transaction);
    double swipeBalance = await accountService.getSwipePoints(user);
    double totalSwipePoints =
        (totalAmount * 0.01) + swipeBalance; //calculation of swipe points 1%

    if (balance < totalAmount) {
      await Future.delayed(Duration(seconds: 1));
      throw NotEnoughFundsError(message: "Insufficient funds");
    }

    await collection.doc(user.id).update({
      "balance": FieldValue.increment(totalAmount * -1),
      "swipePoints": totalSwipePoints,
    });

    return true;
  }

  recordTransaction(UserModel user, TransactionModel transaction,
      TransactionProcessingResponse response) async {
    try {
      print("trying to record transaction");

      var therecord = TransactionRecordModel(
          reference: response.reference,
          product: transaction.product.name,
          transactionType: transaction.offering.toString(),
          transactionTypePretty: getTransactionType(transaction),
          amount: getAmount(transaction),
          totalAmount: getTotalAmount(transaction),
          recipient: getRecipient(transaction),
          status: response.status,
          reason: !response.status ? response.message : "",
          creationDate: DateTime.now());
      await collection
          .doc(user.id)
          .collection('transactions')
          .add(therecord.toMap());
    } catch (e) {
      print(e);
      print('failed recording transaction');
      throw e;
    }
  }

  double getAmount(TransactionModel transaction) {
    double amount = 0.00;
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      amount = transaction.product.amount;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      BillerProduct product = transaction.product;
      amount = double.parse(product.getFieldValue('amount'));
    } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
      DirectPayProduct product = transaction.product;
      amount = product.amount;
    } else {
      return transaction.amount;
    }
    return amount;
  }

  double getTotalAmount(TransactionModel transaction) {
    double amount = 0.00;
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      amount = transaction.product.amount;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      BillerProduct product = transaction.product;
      amount = double.parse(product.getFieldValue('amount')) + product.fee;
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_INSTAPAY) {
      amount = transaction.amount + INSTAPAY_FEE;
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_PESONET) {
      amount = transaction.amount + PESONET_PAY_FEE;
    } else if (transaction.offering == SwipeServiceOffering.AUTOSWEEP) {
      amount = transaction.amount + AUTOSWEEP_FEE;
    } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
      DirectPayProduct product = transaction.product;
      amount = transaction.amount + product.fee;
    }
    return amount;
  }

  double getFee(TransactionModel transaction) {
    double fee = 0.00;

    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      fee = fee;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      BillerProduct product = transaction.product;
      fee = product.fee;
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_INSTAPAY) {
      fee = INSTAPAY_FEE;
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_PESONET) {
      fee = PESONET_PAY_FEE;
    } else if (transaction.offering == SwipeServiceOffering.AUTOSWEEP) {
      fee = AUTOSWEEP_FEE;
    } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
      DirectPayProduct product = transaction.product;
      fee = 15;
    }
    return fee;
  }

  String getRecipient(TransactionModel transaction) {
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      return transaction.recipient;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      return transaction.product.name;
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_INSTAPAY) {
      InstapayBankProduct product = transaction.product;
      return "${product.name}\n${product.accountNumber}";
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_PESONET) {
      PesonetBankProduct product = transaction.product;
      return "${product.name}\n${product.accountNumber}";
    } else if (transaction.offering == SwipeServiceOffering.AUTOSWEEP) {
      return transaction.recipient;
    } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
      DirectPayProduct product = transaction.product;
      return product.mobileNumber;
    }
  }

  String getTransactionType(TransactionModel transaction) {
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      return "Buy a Load";
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      return "Pay Bills";
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_INSTAPAY) {
      return "Instapay";
    } else if (transaction.offering ==
        SwipeServiceOffering.REMITTANCE_PESONET) {
      return "Pesonet";
    } else if (transaction.offering == SwipeServiceOffering.AUTOSWEEP) {
      return AUTOSWEEP_TRANSACTION_TYPE;
    } else if (transaction.offering == SwipeServiceOffering.DIRECT_SEND) {
      return 'Direct Send';
    }
  }
}
