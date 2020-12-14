import 'package:swipe/common/constants.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/bills-payment-service.dart';
import 'package:swipe/services/eloading-service.dart';

import '../main.dart';

class TransactionService {
  Future<TransactionProcessingResponse> process(
      TransactionModel transaction) async {
    TransactionProcessingResponse response;
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      var service = getIt.get<EloadingService>();
      response =
          await service.process(transaction.recipient, transaction.product);
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      var service = getIt.get<BillsPaymentService>();
      response = await service.process(transaction.product);
    }

    return response;
  }

  double getAmount(TransactionModel transaction) {
    double amount = 0.00;
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      amount = transaction.product.amount;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      BillerProduct product = transaction.product;
      amount = double.parse(product.getFieldValue('amount'));
    }
    return amount;
  }

  String getRecipient(TransactionModel transaction) {
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      return transaction.recipient;
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      return transaction.product.name;
    }
  }

  String getTransactionType(TransactionModel transaction) {
    if (transaction.offering == SwipeServiceOffering.BUY_LOAD) {
      return "Buy a Load";
    } else if (transaction.offering == SwipeServiceOffering.BILLS_PAYMENT) {
      return "Pay Bills";
    }
  }
}
