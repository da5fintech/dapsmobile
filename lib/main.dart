import 'dart:async';
import 'package:feature_discovery/feature_discovery.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flavor/flavor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/bills_payment/bills-payment-biller-form-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-billers-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-categories-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-select-biller-screen.dart';
import 'package:swipe/screens/bills_payment/bills_payment-biller-list-screen.dart';
import 'package:swipe/screens/bills_payment/transportation/autosweep-biller-form-screen.dart';
import 'package:swipe/screens/buy_load/buy-load-recipient-screen.dart';
import 'package:swipe/screens/buy_load/buy-load-amount-screen.dart';
import 'package:swipe/screens/direct-send/direct-send-form-screen.dart';
import 'package:swipe/screens/direct-send/direct-send-screen.dart';
import 'package:swipe/screens/help/help-screen.dart';
import 'package:swipe/screens/links-account/links-account-screen.dart';
import 'package:swipe/screens/login-screen.dart';
import 'package:swipe/screens/login/login-email-screen.dart';
import 'package:swipe/screens/login/login-mpin-screen.dart';
import 'package:swipe/screens/partner-merchants/partner-merchants-screen.dart';
import 'package:swipe/screens/pay_qr/pay-qr-generate-screen.dart';
import 'package:swipe/screens/pay_qr/pay-qr-screen.dart';
import 'package:swipe/screens/pay_qr/pay-qr-upload-screen.dart';
import 'package:swipe/screens/payment/payment-confirmation-screen.dart';
import 'package:swipe/screens/payment/payment-mpin-screen.dart';
import 'package:swipe/screens/payment/payment-verification-screen.dart';
import 'package:swipe/screens/promos/promos-screen.dart';
import 'package:swipe/screens/registration/registration-create-mpin-screen.dart';
import 'package:swipe/screens/registration/registration-details-screen.dart';
import 'package:swipe/screens/registration/registration-opt-screen.dart';
import 'package:swipe/screens/remittance/instapay/remittance-instapay-bank-form-screen.dart';
import 'package:swipe/screens/remittance/pesonet/remittance-pesonet-bank-form-screen.dart';
import 'package:swipe/screens/remittance/pesonet/remittance-pesonet-bank-screen.dart';
import 'package:swipe/screens/remittance/remittance-categories-screen.dart';
import 'package:swipe/screens/remittance/instapay/remittance-instapay-banks-screen.dart';
import 'package:swipe/screens/services-screen.dart';
import 'package:swipe/screens/settings/biometrics/biometric-fingerprint-screen.dart';
import 'package:swipe/screens/settings/change-swipe-mpin/swipe-mpin-screen.dart';
import 'package:swipe/screens/settings/settings-screen.dart';
import 'package:swipe/screens/splash-screen.dart';
import 'package:swipe/screens/transactions/transaction-history-screen.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-main-screen.dart';
import 'package:swipe/screens/user-profile/user-profile-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-main-screen.dart';
import 'package:swipe/screens/voucher-pockets/voucher-pockets-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/screens/bills_payment/transportation/transportation-categories-screen.dart';

import 'common/constants.dart';

const String namespaceKey = 'namespace';
const String packageIdKey = 'packageId';

GetIt getIt = GetIt.instance;

void setupApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  await Firebase.initializeApp();
  var cache = await SharedPreferences.getInstance();
  var dir = await getApplicationDocumentsDirectory();
  await Hive.init(dir.path);
  Hive.registerAdapter(AutoSweepSuggestAdapter());
  Hive.registerAdapter(AccountRecipientAdapter());
  Hive.registerAdapter(BuyLoadSuggestAdapter());
  Hive.registerAdapter(AutoSuggestAdapter());
  Hive.registerAdapter(SwipeServiceOfferingAdapter());
  Hive.registerAdapter(BillerProductAdapter());
  Hive.registerAdapter(BillerFieldAdapter());
  Hive.registerAdapter(BillerFieldTypeAdapter());
  Hive.registerAdapter(KeyValuePairAdapter());
  Hive.registerAdapter(ProductModelAdapter());
  getIt.registerSingleton(cache);

  runZoned(() {
    runApp(MyApp());
  }, onError: (error, stack) {
    print(error);
    print(stack);
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    ApplicationStore store =
        ApplicationStore(prefs: getIt.get<SharedPreferences>());
    getIt.registerSingleton<ApplicationStore>(store);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FlavorBanner(
      child: FeatureDiscovery(
        child: MaterialApp(
          navigatorKey: Get.key,
          debugShowCheckedModeBanner: false,
          title: 'Curiociti',
          theme: createTheme(context),
          // darkTheme: ThemeData.dark(),
          // builder: (context, widget) => Navigator(
          //   onGenerateRoute: (settings) => MaterialPageRoute(
          //     builder: (context) => UpdateApp(child: widget),
          //   ),
          // ),
          home: SplashScreen(),
          onGenerateRoute: (settings) {
            // final Map<String, Object> arguments = settings.arguments;
            switch (settings.name) {
              case '/login':
                return MaterialPageRoute(builder: (_) => LoginScreen());
              case '/login/login-email-screen':
                return MaterialPageRoute(builder: (_) => LoginEmailScreen());
              case '/login/login-mpin-screen':
                return MaterialPageRoute(builder: (_) => LoginMpinScreen());
              case '/registration/registration-details-screen':
                return MaterialPageRoute(
                    builder: (_) => RegistrationDetailsScreen());
              case '/registration/registration-otp-screen':
                return MaterialPageRoute(
                    builder: (_) => RegistrationOptScreen());
              case '/registration/registration-create-mpin-screen':
                return MaterialPageRoute(
                    builder: (_) => RegistrationCreateMpinScreen());
              case '/transactions/transaction-history-screen':
                return MaterialPageRoute(
                    builder: (_) => TransactionHistoryScreen());
              case '/user-profile':
                return MaterialPageRoute(builder: (_) => UserProfileScreen());
              case '/user-profile/kyc':
                return MaterialPageRoute(builder: (_) => KycMainScreen());
              case '/user-profile/user-verification':
                return MaterialPageRoute(builder: (_) => VerificationMainScreen());
              case '/links-account':
                return MaterialPageRoute(builder: (_) => LinksAccountScreen());
              case '/partner-merchants':
                return MaterialPageRoute(
                    builder: (_) => PartnerMerchantsScreen());
              case '/promos':
                return MaterialPageRoute(builder: (_) => PromosScreen());
              case '/voucher-pockets':
                return MaterialPageRoute(
                    builder: (_) => VoucherPocketsScreen());
              case '/settings':
                return MaterialPageRoute(builder: (_) => SettingsScreen());
              case '/settings/change-swipe-mpin/swipe-mpin-screen':
                return MaterialPageRoute(builder: (_) => SwipeMpinScreen());
              case '/settings/biometric/biometric-fingerprint-screen':
                return MaterialPageRoute(
                    builder: (_) => BiometricFingerprintScreen());
              case '/help':
                return MaterialPageRoute(builder: (_) => HelpScreen());
              case '/services':
                return MaterialPageRoute(builder: (_) => ServicesScreen());
              case '/services/direct-send':
                return MaterialPageRoute(builder: (_) => DirectSendScreen());
              case '/services/direct-send/direct-send-form-screen':
                return MaterialPageRoute(
                    builder: (_) => DirectSendFormScreen());
              case '/services/buy-load/buy-load-recipient-screen':
                return MaterialPageRoute(
                    builder: (_) => BuyLoadRecipientScreen());
              case '/services/buy-load/buy-load-amount-screen':
                return MaterialPageRoute(builder: (_) => BuyLoadAmountScreen());
              case '/services/payment/payment-verification-screen':
                return MaterialPageRoute(
                    builder: (_) => PaymentVerificationScreen());
              case '/services/payment/payment-mpin-screen':
                return MaterialPageRoute(builder: (_) => PaymentMpinScreen());
              case '/services/payment/payment-confirmation-screen':
                return MaterialPageRoute(
                    builder: (_) => PaymentConfirmationScreen());
              case '/services/bills-payment/bills-payment-categories-screen':
                return MaterialPageRoute(
                    builder: (_) => BillsPaymentCategoriesScreen());
              case '/services/bills-payment/bills-payment-billers-screen':
                return MaterialPageRoute(
                    builder: (_) => BillsPaymentBillersScreen());
              case '/services/bills-payment/bills-payment-biller-form-screen':
                return MaterialPageRoute(
                    builder: (_) => BillsPaymentBillerFormScreen());
              case '/services/bills-payment/bills-payment-biller-list-screen':
                return MaterialPageRoute(
                    builder: (_) => BillPaymentBillerListScreen());
              case '/services/bills-payment/bills-payment-select-biller-screen':
                return MaterialPageRoute(
                    builder: (_) => BillsPaymentSelectBillerScreen());
              case '/services/remittance/remittance-categories-screen':
                return MaterialPageRoute(
                    builder: (_) => RemittanceCategoriesScreen());
              case '/services/remittance/instapay/remittance-instapay-banks-screen':
                return MaterialPageRoute(
                    builder: (_) => RemittanceInstapayBanksScreen());
              case '/services/remittance/instapay/remittance-instapay-bank-form-screen':
                return MaterialPageRoute(
                    builder: (_) => RemittanceInstapayBankFormScreen());
              case '/services/remittance/pesonet/remittance-pesonet-banks-screen':
                return MaterialPageRoute(
                    builder: (_) => RemittancePesonetBankScreen());
              case '/services/remittance/pesonet/remittance-pesonet-bank-form-screen':
                return MaterialPageRoute(
                    builder: (_) => RemittancePesonetBankFormScreen());
              case '/services/bills-payment/transportation/transportation-categories-screen':
                return MaterialPageRoute(
                    builder: (_) => TransportationCategoriesScreen());
              case '/services/bills-payment/transportation/autosweep-biller-form-screen':
                return MaterialPageRoute(
                    builder: (_) => AutosweepBillerFormScreen());
              case '/services/pay-qr/pay-qr-screen':
                return MaterialPageRoute(builder: (_) => PayQRScreen());
              case '/services/pay-qr/pay-qr-upload-screen':
                return MaterialPageRoute(builder: (_) => PayQrUploadScreen());
              case '/services/pay-qr/pay-qr-generate-screen':
                return MaterialPageRoute(builder: (_) => PayQrGenerateScreen());
              default:
                return null;
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
