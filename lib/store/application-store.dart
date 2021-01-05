import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/account-service.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/services/bills-payment-service.dart';
import 'package:swipe/services/eloading-service.dart';
import 'package:swipe/services/instapay-service.dart';
import 'package:swipe/services/transaction-service.dart';
part 'application-store.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  @observable
  UserModel user;
  @observable
  double balance = 0;

  AuthenticationService authService;
  AccountService accountService;
  EloadingService eloadingService;
  BillsPaymentService billsPaymentService;
  InstapayService instapayService;
  TransactionService transactionService;

  bool permissionsGranted;
  SharedPreferences prefs;

  TransactionModel transaction;
  TransactionProcessingResponse lastTransactionResponse;

  String selectedBillerCategory;
  List<BillerProduct> billers;
  BillerProduct selectedBiller;

  List<InstapayBankProduct> instapayBanks;
  InstapayBankProduct selectedInstapayBank;

  _ApplicationStore({this.prefs}) {
    permissionsGranted = prefs.getBool('permissionGranted') ?? false;

    authService = AuthenticationService();
    accountService = AccountService();
    eloadingService = EloadingService();
    billsPaymentService = BillsPaymentService();
    transactionService = TransactionService();
    instapayService = InstapayService();

    getIt.registerSingleton(accountService);
    getIt.registerSingleton(eloadingService);
    getIt.registerSingleton(billsPaymentService);
    getIt.registerSingleton(transactionService);
    getIt.registerSingleton(instapayService);

    // user = UserModel(id: "", mpin: "888888");
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
  setTransactionProduct(ProductModel product, double amount) {
    print("setting transaction amount to ${amount}");
    transaction.product = product;
    transaction.amount = amount;
  }

  @action
  setNewBalance(double amount) {
    balance = amount;
  }

  @action
  setUser(UserModel user) {
    this.user = user;
  }
}
