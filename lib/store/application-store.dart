import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/bills-payment-service.dart';
import 'package:swipe/services/eloading-service.dart';
import 'package:swipe/services/transaction-service.dart';
part 'application-store.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  @observable
  UserModel user;

  EloadingService eloadingService;
  BillsPaymentService billsPaymentService;
  TransactionService transactionService;

  bool permissionsGranted;
  SharedPreferences prefs;

  TransactionModel transaction;
  TransactionProcessingResponse lastTransactionResponse;
  double balance;

  String selectedBillerCategory;
  List<BillerProduct> billers;
  BillerProduct selectedBiller;

  _ApplicationStore({this.prefs}) {
    permissionsGranted = prefs.getBool('permissionGranted') ?? false;
    balance = 28000;
    eloadingService = EloadingService();
    billsPaymentService = BillsPaymentService();
    transactionService = TransactionService();

    getIt.registerSingleton(eloadingService);
    getIt.registerSingleton(billsPaymentService);
    getIt.registerSingleton(transactionService);

    user = UserModel(id: "", mpin: "888888");
  }

  setPermissionsGranted() {
    permissionsGranted = true;
    prefs.setBool('permissionGranted', true);
  }

  @action
  createTransaction(SwipeServiceOffering offering, recipient) {
    transaction =
        new TransactionModel(offering: offering, recipient: recipient);
  }

  @action
  setTransactionProduct(ProductModel product) {
    transaction.product = product;
  }
}
