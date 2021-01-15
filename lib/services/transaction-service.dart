import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/account-service.dart';
import 'package:swipe/services/bills-payment-service.dart';
import 'package:swipe/services/eloading-service.dart';
import 'package:swipe/services/firestore-service.dart';
import 'package:swipe/services/instapay-service.dart';

import '../main.dart';

class TransactionService extends FireStoreService {
  AccountService accountService;

  TransactionService({this.accountService}) : super(collectionName: "accounts");

  Future<TransactionProcessingResponse> process(
      UserModel user, TransactionModel transaction) async {
    TransactionProcessingResponse response;

    try {
      await tryChargeAccount(user, transaction);
      if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
        var service = getIt.get<EloadingService>();
        response =
            await service.process(transaction.recipient, transaction.product);
      } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
        var service = getIt.get<BillsPaymentService>();
        response = await service.process(transaction.product);
      } else if (transaction.offering ==
          SwipeServiceOffering.REMITTANCE_INSTAPAY) {
        var service = getIt.get<InstapayService>();
        response =
            await service.process(transaction.product, transaction.amount);
      }
      await recordTransaction(user, transaction, response);
      return response;
    } on NotEnoughFundsError catch (e) {
      response = GenericProcessingResponse(
          status: false, reference: "", message: e.message, result: e.message);

      await recordTransaction(user, transaction, response);
      return response;
    } catch (e) {
      return response;
    }
  }

  Future<bool> tryChargeAccount(
      UserModel user, TransactionModel transaction) async {
    double balance = await accountService.getWalletAmount(user);
    double totalAmount = getTotalAmount(transaction);

    if (balance < totalAmount) {
      await Future.delayed(Duration(seconds: 1));
      throw NotEnoughFundsError(message: "Not enough funds");
    }

    await collection
        .doc(user.id)
        .update({"balance": FieldValue.increment(totalAmount * -1)});

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
    }
    return amount;
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
    }
  }
}