import 'dart:async';
import 'dart:io';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/main.dart';
import 'package:daps/models/UserVerificationModel.dart';
import 'package:daps/models/notification-model.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/models/bpi-account-model.dart';
import 'package:daps/services/account-service.dart';
import 'package:daps/services/add-biller-service.dart';
import 'package:daps/services/authentication-service.dart';
import 'package:daps/services/autosweep-service.dart';
import 'package:daps/services/bills-payment-service.dart';
import 'package:daps/services/cashin-service.dart';
import 'package:daps/services/request-money-service.dart';
import 'package:daps/services/direct-pay-service.dart';
import 'package:daps/services/eloading-service.dart';
import 'package:daps/services/instapay-service.dart';
import 'package:daps/services/opt-service.dart';
import 'package:daps/services/pesonet-service.dart';
import 'package:daps/services/ph-regions-service.dart';
import 'package:daps/services/save-suggestions-services.dart';
import 'package:daps/services/transaction-service.dart';
import 'package:daps/services/verify-service.dart';
import 'package:daps/services/gcash-service.dart';
import 'package:daps/services/bpi-service.dart';
import 'package:daps/services/daps-authentication-service.dart';


part 'application-store.g.dart';

class ApplicationStore = _ApplicationStore with _$ApplicationStore;

abstract class _ApplicationStore with Store {
  @observable
  String versionNumber;
  @observable
  UserModel user;
  @observable
  double balance = 0;
  @observable
  double swipePoints = 0;
  @observable
  List<BillerProduct> savedBillers = [];
  @observable
  List<NotificationModel> notifications = [];
  @observable
  bool enabledBiometrics;
  @observable
  bool freshInstall;
  @observable
  File idImage;
  @observable
  File faceImage;

  String bpiAccessToken;

  //used to track user registration
  UserModel registrant;

  UserVerificationModel verification;

  AuthenticationService authService;
  AccountService accountService;
  VerifyService verifyService;
  EloadingService eloadingService;
  BillsPaymentService billsPaymentService;
  InstapayService instapayService;
  RequestMoneyService requestMoneyService;
  PesonetService pesonetService;
  TransactionService transactionService;
  AutosweepService autosweepService;
  AddBillerService addBillerService;
  DirectPayService directPayService;
  CashInService cashInService;
  GcashService gcashService;
  OtpService otpService;
  BpiService bpiService;
  SaveSuggestionsServices saveSuggestionsServices;
  PhRegionsService phRegionsService;
  DapsAuthenticationService dapsAuthenticationService;

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
  List<BpiAccountModel> bpiAccountModel;

  _ApplicationStore({this.prefs}) {
    permissionsGranted = prefs.getBool('permissionGranted') ?? false;
    enabledBiometrics = prefs.getBool('biometrics') ?? false;
    freshInstall = prefs.getBool('freshInstall') ?? true;

    authService = AuthenticationService();
    verifyService = VerifyService();
    accountService = AccountService();
    eloadingService = EloadingService();
    billsPaymentService = BillsPaymentService();
    instapayService = InstapayService();
    pesonetService = PesonetService();
    requestMoneyService = RequestMoneyService();
    autosweepService = AutosweepService();
    directPayService = DirectPayService();
    cashInService = CashInService();
    gcashService = GcashService();
    addBillerService = AddBillerService();
    otpService = OtpService();
    saveSuggestionsServices = SaveSuggestionsServices();
    phRegionsService = PhRegionsService();
    bpiService = BpiService();
    dapsAuthenticationService = DapsAuthenticationService(prefs: this.prefs);
    transactionService = TransactionService(
        accountService: accountService,
        dapsAuthenticationService: dapsAuthenticationService
    );

    getIt.registerSingleton(accountService);
    getIt.registerSingleton(VerifyService());
    getIt.registerSingleton(eloadingService);
    getIt.registerSingleton(billsPaymentService);
    getIt.registerSingleton(transactionService);
    getIt.registerSingleton(instapayService);
    getIt.registerSingleton(bpiService);
    getIt.registerSingleton(pesonetService);
    getIt.registerSingleton(requestMoneyService);
    getIt.registerSingleton(autosweepService);
    getIt.registerSingleton(directPayService);
    getIt.registerSingleton(cashInService);
    getIt.registerSingleton(addBillerService);
    getIt.registerSingleton(otpService);
    getIt.registerSingleton(saveSuggestionsServices);
    getIt.registerSingleton(PhRegionsService());
    getIt.registerSingleton(gcashService);
    getIt.registerSingleton(dapsAuthenticationService);

    // user = UserModel(id: "", mpin: "888888");
  }

  setIfFreshInstall (bool val) {
    freshInstall = val;
    prefs.setBool('freshInstall', freshInstall);
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
  setVersionNumber (String version) {
    this.versionNumber = version;
  }

  @action
  setNotitications (List<NotificationModel> a) {
    this.notifications = a;
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

  @action
  setId(File image) {
    this.idImage = image;
  }

  @action
  setFace(File image) {
    this.faceImage = image;
  }
}
