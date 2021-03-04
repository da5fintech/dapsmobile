import 'dart:async';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/services/account-service.dart';
import 'package:swipe/services/add-biller-service.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/services/autosweep-service.dart';
import 'package:swipe/services/bills-payment-service.dart';
import 'package:swipe/services/cashin-service.dart';
import 'package:swipe/services/direct-pay-service.dart';
import 'package:swipe/services/eloading-service.dart';
import 'package:swipe/services/instapay-service.dart';
import 'package:swipe/services/opt-service.dart';
import 'package:swipe/services/pesonet-service.dart';
import 'package:swipe/services/save-suggestions-services.dart';
import 'package:swipe/services/transaction-service.dart';

part 'application-store.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  @observable
  UserModel user;
  @observable
  double balance = 0;
  @observable
  double swipePoints = 0;
  @observable
  List<BillerProduct> savedBillers = [];
  @observable
  bool enabledBiometrics;

  //used to track user registration
  UserModel registrant;

  AuthenticationService authService;
  AccountService accountService;
  EloadingService eloadingService;
  BillsPaymentService billsPaymentService;
  InstapayService instapayService;
  PesonetService pesonetService;
  TransactionService transactionService;
  AutosweepService autosweepService;
  AddBillerService addBillerService;
  DirectPayService directPayService;
  CashInService cashInService;
  OtpService otpService;
  SaveSuggestionsServices saveSuggestionsServices;

  bool permissionsGranted;
  SharedPreferences prefs;

  TransactionModel transaction;
  TransactionProcessingResponse lastTransactionResponse;

  String selectedBillerCategory;
  List<BillerProduct> billers;
  BillerProduct selectedBiller;

  List<InstapayBankProduct> instapayBanks;
  InstapayBankProduct selectedInstapayBank;
  List<PesonetBankProduct> pesonetBanks;
  PesonetBankProduct selectedPesonetBank;

  _ApplicationStore({this.prefs}) {
    permissionsGranted = prefs.getBool('permissionGranted') ?? false;
    enabledBiometrics = prefs.getBool('biometrics') ?? false;

    authService = AuthenticationService();
    accountService = AccountService();
    eloadingService = EloadingService();
    billsPaymentService = BillsPaymentService();
    transactionService = TransactionService(accountService: accountService);
    instapayService = InstapayService();
    pesonetService = PesonetService();
    autosweepService = AutosweepService();
    directPayService = DirectPayService();
    cashInService = CashInService();
    addBillerService = AddBillerService();
    otpService = OtpService();
    saveSuggestionsServices = SaveSuggestionsServices();

    getIt.registerSingleton(accountService);
    getIt.registerSingleton(eloadingService);
    getIt.registerSingleton(billsPaymentService);
    getIt.registerSingleton(transactionService);
    getIt.registerSingleton(instapayService);
    getIt.registerSingleton(pesonetService);
    getIt.registerSingleton(autosweepService);
    getIt.registerSingleton(directPayService);
    getIt.registerSingleton(cashInService);
    getIt.registerSingleton(addBillerService);
    getIt.registerSingleton(otpService);
    getIt.registerSingleton(saveSuggestionsServices);

    // user = UserModel(id: "", mpin: "888888");
  }

  setPermissionsGranted() {
    permissionsGranted = true;
    prefs.setBool('permissionGranted', true);
  }

  setEnabledBiometrics (bool isEnabled) {
    this.enabledBiometrics = isEnabled;
    prefs.setBool('biometrics', isEnabled);
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

  @action setNewSwipeBalance(double currentSwipePoints) {
    this.swipePoints = currentSwipePoints;
  }

  @action
  setUser(UserModel user) {
    this.user = user;
    print('setting user balance ${user.balance}');
    print('setting swipe balance ${user.swipePoints}');
    setNewBalance(user.balance);
    setNewSwipeBalance(user.swipePoints);
  }

  @action
  setNewBiller(List<BillerProduct> billerProduct) {
    this.savedBillers = billerProduct;
  }
}
