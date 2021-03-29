import 'package:swipe/screens/bills_payment/bills-payment-biller-form-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-billers-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-categories-screen.dart';
import 'package:swipe/screens/bills_payment/bills-payment-select-biller-screen.dart';
import 'package:swipe/screens/bills_payment/bills_payment-biller-list-screen.dart';
import 'package:swipe/screens/bills_payment/transportation/autosweep-biller-form-screen.dart';
import 'package:swipe/screens/buy_load/buy-load-recipient-screen.dart';
import 'package:swipe/screens/buy_load/buy-load-amount-screen.dart';
import 'package:swipe/screens/cash-in/cash-in-main-screen.dart';
import 'package:swipe/screens/cash-out/cash-out.main-screen.dart';
import 'package:swipe/screens/direct-send/direct-send-form-screen.dart';
import 'package:swipe/screens/direct-send/direct-send-screen.dart';
import 'package:swipe/screens/help/help-screen.dart';
import 'package:swipe/screens/links-account/links-account-screen.dart';
import 'package:swipe/screens/links-account/union-bank/union-bank-login-screen.dart';
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
import 'package:swipe/screens/transactions/transaction-history-screen.dart';
import 'package:swipe/screens/user-profile/kyc/kyc-main-screen.dart';
import 'package:swipe/screens/user-profile/user-profile-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-id-list-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-review-information-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-scan-face-boarding-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-user-information-screen.dart';
import 'package:swipe/screens/voucher-pockets/voucher-pockets-screen.dart';
import 'package:swipe/screens/bills_payment/transportation/transportation-categories-screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRouting(RouteSettings settings) {
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
      case '/user-profile/user-verification/verification':
        return MaterialPageRoute(builder: (_) => VerificationScreen());
      case '/user-profile/user-verification/verification-id-list':
        return MaterialPageRoute(builder: (_) => VerificationIdListScreen());
      case '/user-profile/user-verification/verification-scan-face-boarding':
        return MaterialPageRoute(builder: (_) => VerificationScanFaceBoardingScreen());
      case '/user-profile/user-verification/verification-user-information-screen':
        return MaterialPageRoute(builder: (_) => VerificationUserInformationScreen());
      case '/user-profile/user-verification/verification-review-information-screen':
        return MaterialPageRoute(builder: (_) => VerificationReviewInfromationScreen());
      case '/user-profile/kyc':
        return MaterialPageRoute(builder: (_) => KycMainScreen());
      case '/links-account':
        return MaterialPageRoute(builder: (_) => LinksAccountScreen());
      case '/links-account/union-bank':
        return MaterialPageRoute(builder: (_) => UnionBankLoginScreen());
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
      case '/services/cash-in':
        return MaterialPageRoute(builder: (_) => CashInMainScreen());
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
  }
}