library constants;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

const APP_NAME = "SWIPE";
const APP_NAME_FONT_SIZE = 20.0;
const APP_HELP_CENTER = "Help Center";
const APP_VERSION = "v1.1.1";

const LOGIN_SCREEN_LOGIN_TEXT = "LOG IN";
const LOGIN_SCREEN_REGISTER_TEXT = "REGISTER";
const LOGIN_SCREEN_SIGN_UP_TEXT = "OR SIGN-UP USING";
const LOGIN_SCREEN_APP_NAME = "SWIPE";
const LOGIN_SCREEN_APP_NAME_LETTER_SPACING = 15.0;
const LOGIN_SCREEN_APP_NAME_FONT_SIZE = 20.0;

const LOGIN_EMAIL_SCREEN_EMAIL_TEXT = "Email";
const LOGIN_EMAIL_SCREEN_PASSWORD_TEXT = "Password";
const LOGIN_EMAIL_SCREEN_LOGIN_TEXT = "Log in";
const LOGIN_EMAIL_SCREEN_ALTERNATE_LOGIN_TEXT = "OR LOGIN USING";
const LOGIN_EMAIL_SCREEN_FAILED_ATTEMPT_TEXT = "Login Error";

const PAYQR_SCREEN_TITLE_TEXT = "Pay QR/Barcode";
const PAYQR_SCREEN_UPLOAD_TEXT = "Upload QR";
const PAYQR_SCREEN_GENERATE_QR_TEXT = "Generate QR / Bar code";
const PAYQR_SCREEN_SCAN_TEXT = "Scan QR";
const PAYQR_UPLOAD_SCREEN_TITLE = "Photos";
const PAYQR_UPLOAD_TAB_1 = "All Photos";
const PAYQR_UPLOAD_TAB_2 = "Albums";
const PAYQR_GENERATE_TITLE = "Generate Code";
const PAYQR_GENERATE_SCREEN_NOTE_TEXT =
    "Show one of this code to the cashier of any participating\n "
    "merchant to pay your purchase.";

const LOGIN_MPIN_SCREEN_LOGIN_TEXT = 'Login';

const REGISTRATION_SCREEN_SUCCESS_TEXT = "Congratulations";
const REGISTRATION_SCREEN_USER_CREATION_TEXT =
    'We\'ve successfully created your account!';
const REGISTRATION_SCREEN_USER_LOGIN_TEXT = "PROCEED TO LOGIN";

const SETTINGS_SCREEN_TITLE = "Settings";
const SETTINGS_SCREEN_CHANGE_MPIN_TEXT = "Change swipe MPIN";
const SETTINGS_SCREEN_ACCOUNT_AUTH_TEXT = "Account Authentication";
const SETTINGS_SCREEN_BIOMETRIC_LOGIN_TEXT = "Biometric Login";
const SETTINGS_SCREEN_BIOMETRIC_BANNER_TEXT = "Biometrics Log in";
const SETTINGS_SCREEN_BIOMETRIC_BANNER_NOTE_TEXT =
    "Log in faster to swipe using biometrics";
const SETTINGS_SCREEN_BIOMETRIC_ENABLE_TEXT = "Enable Biometrics";
const SETTINGS_SCREEN_BIOMETRIC_NOT_AVAILABLE = "Biometrics is not available on your device.";
const SETTINGS_SCREEN_BIOMETRIC_DISCLAIMER_TEXT =
    'By enabling biometrics login, you allow Swipe to access your saved\nbiometrics'
    'data on your device to create and save data in Swipe that\n'
    'shall be used for securing your login. The data will not be used for\n'
    'any other purposes.';
const SETTINGS_SCREEN_BIOMETRIC_OTP_GREET = "Fantastic!";
const SETTINGS_SCREEN_BIOMETRIC_OTP_LIMIT = "Please enter your 6-digit OTP!";
const SETTINGS_SCREEN_BIOMETRIC_OTP_SEND = "We've sent a 6-digit Authentication code on your registered mobile number.";
const SETTINGS_SCREEN_BIOMETRIC_OTP_NEW_CODE = "Need new Code?";
const SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE = "Resend Code";
const SETTINGS_SCREEN_BIOMETRIC_OTP_ENROLL_NOW = "ENROLL NOW";
const SETTINGS_SCREEN_SWIPE_DIALOG_CONFIRMATION = "Confirmation";
const SETTINGS_SCREEN_SWIPE_BIOMETRIC_NOTE_TEXT = "Swipe would like to use your Biometrics for the additional Security.";
const SETTINGS_SCREEN_SWIPE_FACEID_NOTE_TEXT = "Swipe would like to use your face ID for the additional Security.";
const SETTINGS_SCREEN_SWIPE_DISABLE_TEXT = "Disable Biometrics Log in";
const SETTINGS_SCREEN_SWIPE_DISABLE_CONFIRMATION_TEXT = "Are you sure you want to disable biometrics log in?";


const SERVICES_SCREEN_VERIFIED_TEXT = "VERIFIED";
const SERVICES_SCREEN_BALANCE_TEXT = "Available balance";
const SERVICES_SCREEN_CASH_IN_TEXT = "Cash in";
const SERVICES_SCREEN_REMITTANCE_TEXT = "Remittance";
const SERVICES_SCREEN_BANK_TRANSFER_TEXT = "Back Transfer";
const SERVICES_SCREEN_BUY_LOAD_TEXT = "Buy Load";
const SERVICES_SCREEN_PAY_BILLS_TEXT = "Pay Bills";
const SERVICES_SCREEN_REQUEST_MONEY_TEXT = "Request Money";
const SERVICES_SCREEN_PAY_QR_TEXT = "Pay QR";
const SERVICES_SCREEN_INSURANCE_TEXT = "Insurance";
const SERVICES_SCREEN_MORE_TEXT = "More";
const SERVICES_SCREEN_TRANSACTION_TEXT = "Transaction History";
const SERVICES_SCREEN_ADVANTAGE_SWIPE_TEXT =
    "More Advantages to know about Swipe";
const SERVICES_SCREEN_REASON_SWIPE_TEXT =
    "Because you deserve bettwer from us.";

const BILLS_PAYMENT_TITLE_TEXT = "Pay Bills";
const BILLS_PAYMENT_NEXT_TEXT = "Next";
const BILLS_PAYMENT_SCREEN_IMMEDIATE_POST_TEXT =
    "Payment will be posted immediately";
const BILLS_PAYMENT_BILLER_SCREEN_ALL_BILLERS_TEXT = "All Billers";
const BILLS_PAYMENT_CATEGORIES_SCREEN_SAVED_BILLERS_TEXT = "Saved Biller(s)";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ADD_BILLER_TEXT = "Add Biller";
const BILLS_PAYMENT_CATEGORIES_SCREEN_DELETE_BILLER_TEXT = "Are you sure you want to Delete";
const BILLS_PAYMENT_CATEGORIES_SCREEN_AIRLINES_TEXT = "Airlines";
const BILLS_PAYMENT_CATEGORIES_SCREEN_CABLE_INTERNET_TEXT = "Cable / Internet";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ELECTRICITY_TEXT = "Electricity";
const BILLS_PAYMENT_CATEGORIES_SCREEN_INSURANCE_TEXT = "Insurance";
const BILLS_PAYMENT_CATEGORIES_SCREEN_TRANSPORTATION_TEXT = "Transportation";
const BILLS_PAYMENT_CATEGORIES_SCREEN_ONLINE_SHOPPING_TEXT = "Online Shopping";
const BILLS_PAYMENT_CATEGORIES_SCREEN_UTILITIES_TEXT = "Utilities";
const BILLS_PAYMENT_CATEGORIES_SCREEN_WATER_TEXT = "Water";
const BILLS_PAYMENT_CATEGORIES_SCREEN_OTHERS_TEXT = "OTHERS";
const BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TITLE =
    "All Billers (Transportation)";
const BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TEXT = "Autosweep";
const BILLS_PAYMENT_TRANSPORTATION_POSTED_IMMEDIATELY =
    "Payment will be posted immediately";
const BILLS_PAYMENT_TRANSPORTATION_PLATE_NUMBER_TEXT = "Plate Number";
const BILLS_PAYMENT_TRANSPORTATION_AMOUNT_TEXT = "Plate Number";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_1 = "Autosweep";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_2 = "Easytrip";
const BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_3 = "Beep";

const BILLS_PAYMENT_BILLER_LIST_TITLE_TEXT = "Add Biller";
const BILLS_PAYMENT_BILLER_ELECTRIC_UTILITIES_TEXT = "Electric";
const BILLS_PAYMENT_BILLER_WATER_UTILITIES_TEXT = "Water";
const BILLS_PAYMENT_BILLER_LOANS_TEXT = "Loans";
const BILLS_PAYMENT_BILLER_CREDIT_CARD_TEXT = "Credit Card";
const BILLS_PAYMENT_BILLER_TELECOM_TEXT = "Telecom";
const BILLS_PAYMENT_BILLER_GOVERMENT_TEXT = "Government";
const BILLS_PAYMENT_BILLER_INSURANCE_TEXT = "Insurance";
const BILLS_PAYMENT_BILLER_SCHOOLS_TEXT = "SCHOOLS";
const BILLS_PAYMENT_BILLER_HEALTH_CARE_TEXT = "Health Care";
const BILLS_PAYMENT_BILLER_REAL_ESTATE_TEXT = "Real Estate";
const BILLS_PAYMENT_BILLER_FOOD_TEXT = "Food";
const BILLS_PAYMENT_BILLER_FAVORITES_TEXT = "Favorites";

const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_SEND_TEXT = "Send Money";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_PAYMENT_POSTED_TEXT =
    "Payment will be posted immediately";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT = "Amount";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT = "Account";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT = "Recipient";
const REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_NEXT_TEXT = "Next";
const REMITTANCE_INSTAPAY_BANK_SCREEN_SELECT_BANK_TEXT = "Select Bank";

const AUTH_MERCHANT_ID = "0910";
const AUTH_NETWORK_ID = "0625";
const AUTH_USERNAME = "kabootekph";
const AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const API_ENDPOINT = "https://directagent5.com.ph/daps/index.php";
const ELOADING_SCOPE = 'eloading';
const BILLS_PAYMENT_SCOPE = 'billspayment';
const BILLS_PAYMENT_CHANNEL = 'X2B2';
const INSTAPAY_SCOPE = 'instapay';

const REMITTANCE_SCREEN_CATEGORIES_BANK_TEXT = "Banks";
const REMITTANCE_SCREEN_CATEGORIES_WALLET_TEXT = "Wallets";
const REMITTANCE_SCREEN_CATEGORIES_CENTERS_TEXT = "Remittance Centers";
const REMITTANCE_SCREEN_PANEL_SEND_MONEY_TEXT = "Send money via:";
const REMITTANCE_SCREEN_PANEL_SEND_INSTANCE_FREE_TEXT =
    "Send Instantly for free";
const REMITTANCE_SCREEN_PANEL_SEND_OTHER_BANKS_TEXT =
    "Send to other banks and Wallets, Received instantly";
const REMITTANCE_SCREEN_PANEL_CUT_OFF_TEXT = "No Cutoff";
const REMITTANCE_SCREEN_PANEL_TRANSACTION_LIMIT = "50,000.00 transaction Limit";
const REMITTANCE_SCREEN_PANEL_SEND_FOR_FREE = "Send for free";
const REMITTANCE_SCREEN_PANEL_SEND_TO_OTHER_BANKS_INSTANCE_TEXT =
    "Send to other banks and Wallets, Receive by end of the day";
const REMITTANCE_SCREEN_PANEL_TRANSACTION_NOTE =
    "Transactions before 3:00 PM cut-off are processed same banking day. Transactions after cut-off, weekends of holidays are processed the next banking day";
const REMITTANCE_SCREEN_TITLE_TEXT = "Send/Request Money";
const REMITTANCE_SCREEN_TAB_SEND_TEXT = "Send";
const REMITTANCE_SCREEN_TAB_REQUEST_TEXT = "Request";

const TRANSACTION_HISTORY_SCREEN_TITLE_TEXT = "Transaction History";
const TRANSACTION_HISTORY_SCREEN_BUTTON_ALL_TEXT = "ALL";
const TRANSACTION_HISTORY_SCREEN_BUTTON_RECEIVED_TEXT = "RECEIVED";
const TRANSACTION_HISTORY_SCREEN_BUTTON_SENT_TEXT = "SENT";
const TRANSACTION_HISTORY_SCREEN_DETAILS_TEXT = "Details";

const REGISTER_MPIN_SCREEN_SET_PIN_TEXT = "Set your Mobile Pin";
const REGISTER_MPIN_SCREEN_NOTE_TEXT =
    "MPIN is a 6 digit security codes used to authenticate"
    "\nlogin request and transactions."
    "\n\nNote: Please avoid using weak MPINs like your"
    "\nBirthdate, 123456, 888888.";
const REGISTER_MPIN_SCREEN_TEXT = "MPIN";
const REGISTER_SCREEN_FIRSTNAME_TEXT = "First Name";
const REGISTER_SCREEN_LASTNAME_TEXT = "Last Name";
const REGISTER_SCREEN_ADDRESS_TEXT = "Address";
const REGISTER_SCREEN_BIRTHDAY_TEXT = "Birth Date";
const REGISTER_SCREEN_BIRTHDAY_FORMAT = "MM/DD/YY";
const REGISTER_SCREEN_MOBIILE_TEXT = "Mobile Number";
const REGISTER_SCREEN_EMAIL_TEXT = "Email";
const REGISTER_SCREEN_PASSWORD_TEXT = "Password";

const PAYMENT_CONFIRMATION_SCREEN_TITLE_TEXT = "Receipt";
const PAYMENT_CONFIRMATION_SCREEN_RECEIVED_TEXT = "Payment Received";
const PAYMENT_CONFIRMATION_SCREEN_TRANSACTION_TEXT = "Transaction";
const PAYMENT_CONFIRMATION_SCREEN_SENT_TEXT = "Sent to";
const PAYMENT_CONFIRMATION_SCREEN_AMOUNT_TEXT = "Amount";
const PAYMENT_CONFIRMATION_SCREEN_FEE_TEXT = "Fee";
const PAYMENT_CONFIRMATION_SCREEN_DUE_TEXT = "Amount due";
const PAYMENT_CONFIRMATION_SCREEN_DATE_TEXT = "Date";
const PAYMENT_CONFIRMATION_SCREEN_REF_TEXT = "Reference No";
const PAYMENT_CONFIRMATION_SCREEN_PROCESSED_TEXT =
    "Your payment is being processed. \n You will receive a text message regarding this transaction.";
const PAYMENT_CONFIRMATION_SCREEN_DONE_TEXT = "DONE";
const PAYMENT_MPIN_SCREEN_TITLE = "Payment";
const PAYMENT_MPIN_SCREEN_GREET = "Fantastic";
const PAYMENT_MPIN_SCREEN_DIGIT_LIMIT =
    "Please enter your 6-digit MPIN to proceed.";
const PAYMENT_MPIN_SCREEN_PROCEED_TEXT = "PROCEED";
const PAYMENT_VERIFICATION_SCREEN_LOAD_FOR_TEXT = "Buy Load for";
const PAYMENT_VERIFICATION_SCREEN_MY_NUMBER_TEXT = "MY Number";
const PAYMENT_VERIFICATION_SCREEN_PAY_BILLS_TEXT = "Pay Bills for";
const PAYMENT_VERIFICATION_SCREEN_FEE_TEXT = "Fee";
const PAYMENT_VERIFICATION_SCREEN_SEND_MONEY_TEXT = "Send Money For";
const PAYMENT_VERIFICATION_SCREEN_SEND_VIA_TEXT = "Send Via";
const PAYMENT_VERIFICATION_SCREEN_ACCOUNT_NUMBER_TEXT = "Account Number";
const PAYMENT_VERIFICATION_SCREEN_RECIPIENT_TEXT = "Account Number";
const PAYMENT_VERIFICATION_SCREEN_PAY_WALLET_TEXT = "Pay with wallet";
const PAYMENT_VERIFICATION_SCREEN_BALANCE_TEXT = "Available Balance";
const PAYMENT_VERIFICATION_SCREEN_ABOUT_TO_PAY_TEXT = "You are about to pay";
const PAYMENT_VERIFICATION_SCREEN_DUE_TEXT = "Amount Due";
const PAYMENT_VERIFICATION_SCREEN_DISCOUNT_TEXT = "Discount";
const PAYMENT_VERIFICATION_SCREEN_VOUCHER_TEXT = "No available voucher";
const PAYMENT_VERIFICATION_SCREEN_TOTAL_AMOUNT_TEXT = "Total Amount";
const PAYMENT_VERIFICATION_SCREEN_PAY_TEXT = "Pay";
const PAYMENT_PROCESSING_INVALID_TEXT = "Ooops";
const PAYMENT_PROCESSING_INVALID_INPUT_TEXT =
    "You have entered an incorrect\nMPIN. Please try again,";
const PAYMENT_PROCESSING_CONFIRM_TEXT = "OK";

const DRAWER_MENU_SCREEN_VIEW_BENEFITS_TEXT = "View Benefits";
const DRAWER_MENU_SCREEN_BASIC_LEVEL = "Basic Level";
const DRAWER_MENU_SCREEN_SEMI_VERIFIED = "Semi Verified";
const DRAWER_MENU_SCREEN_FULLY_VERIFIED = "Fully Verified";
const DRAWER_MENU_SCREEN_LINK_ACCOUNTS = "My Links Account";
const DRAWER_MENU_SCREEN_PARTNER_MERCHANTS = "Partner Merchants";
const DRAWER_MENU_SCREEN_PROMOS = "Promos";
const DRAWER_MENU_SCREEN_VOUCHER = "Voucher Pocket";
const DRAWER_MENU_SCREEN_SETTINGS = "Settings";
const DRAWER_MENU_SCREEN_HELP = "Help";
const DRAWER_MENU_SCREEN_LOGOUT = "Log out";

const BUY_LOAD_TITLE_TEXT = "Buy Load";
const BUY_LOAD_MOBILE_TEXT = "Mobile";
const BUY_LOAD_PHP_TEXT = "PHP";
const BUY_LOAD_NEXT_TEXT = "Next";
const BUY_LOAD_RECIPIENT_SCREEN_LOAD_FOR_TEXT = "Buy Load For";

const BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_1 = "Regular Load";
const BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_2 = "Load Promos";
const BUY_LOAD_AMOUNT_SCREEN_AMOUNT_TEXT = "Amount";
const BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION = "Enter amount between 10-1000";
const BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION_OR = "or choose denomination below:";

const SOON_RELEASED_SCREEN_FEATURED_TEXT = "Feature not yet released";
const SOON_RELEASED_SCREEN_NOTE_TEXT = "Soon to be released!\nPlease Wait for the updates.";
const SOON_RELEASED_SCREEN_OK_TEXT = "OK";

const BLUR_RADIUS = 10;
const COLOR_LIGHT_PURPLE = Color(0xffF9F8FC);
const COLOR_DARK_PURPLE = Color(0xff7A3CDF);
const COLOR_ORANGE = Color(0xffF2A819);
const COLOR_GREEN = Color(0xff25BA96);
const COLOR_GRAY = Color(0xffC4C4C4);
const COLOR_BLUE = Color(0xff46C4F2);
const COLOR_DARK_GRAY = Color(0xff545454);
const COLOR_GLOBE_BLUE = Color(0xff46C4F2);
const COLOR_SMART_GREEN = Color(0xff25BA96);
const COLOR_DANGER = Color(0xffeb4034);

const INSTAPAY_SENDER_NAME = 'SWIPE INSTAPAY';
const INSTAPAY_ADDRESS1 = 'Torino';
const INSTAPAY_ADDRESS2 = 'Buenavista 1';
const INSTAPAY_CITY = 'General Trias';
const INSTAPAY_PROVINCE = 'Cavite';
const INSTAPAY_ZIP = '4107';
const INSTAPAY_COUNTRY = 'Philippines';
const INSTAPAY_CURRENCY = 'PHP';
const INSTAPAY_FEE = 25.00;

const AUTOSWEEP_TRANSACTION_TYPE = "AUTOSWEEP";
const AUTOSWEEP_SCOPE = "autosweep";
const AUTOSWEEP_PRODUCT_NAME = "Autosweep RFID";
const AUTOSWEEP_FEE = 10.00;
const AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_COLOR = Color(0xff7A3CDF);
const AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_OPACITY = .05;
const AUTOSWEEP_VERIFICATION_TEXT = "Buy Load For";
const AUTOSWEEP_VERIFICATION_TEXT_COLOR = Color(0xff7A3CDF);
const AUTOSWEEP_VERIFICATION_TEXT_COLOR_OPACITY = .87;
const AUTOSWEEP_VERIFICATION_TEXT_FONT_WEIGHT = FontWeight.w500;
const AUTOSWEEP_VERIFICATION_TEXT_PAY_FOR = "Plate Number";
const AUTOSWEEP_VERIFICATION_TEXT_FEE = "Fee";

const kUpdateDialogKeyName = 'kUpdateDialogKeyName';

const MaterialColor themeColor = MaterialColor(
  _themeColorPrimaryValue,
  <int, Color>{
    50: Color(0xFFe6f7ff),
    100: Color(0xFFccefff),
    200: Color(0xFF99dfff),
    300: Color(0xFF66cfff),
    400: Color(0xFF33beff),
    500: Color(_themeColorPrimaryValue),
    600: Color(0xFF008bcc),
    700: Color(0xFF006999),
    800: Color(0xFF004666),
    900: Color(0xFF002333),
  },
);
const int _themeColorPrimaryValue = 0xFF00aeff;

Widget appbarBackground = Container(
  decoration: appbarBgDecor,
);

List<Shadow> shadowLight = <Shadow>[
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 3.0,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 8.0,
    color: Color.fromARGB(125, 0, 0, 50),
  ),
];

List<Shadow> shadowHard = <Shadow>[
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 1.0,
    color: Color.fromARGB(255, 0, 0, 0),
  ),
  Shadow(
    offset: Offset(0.0, 0.0),
    blurRadius: 3.0,
    color: Color.fromARGB(125, 0, 0, 50),
  ),
];

BoxDecoration appbarBgDecor = BoxDecoration(
  color: Colors.black,
);

TextStyle pageTitleWhite = GoogleFonts.roboto(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);

TextStyle secondaryButtonText = GoogleFonts.roboto(color: Colors.white);
TextStyle primaryButtonText = GoogleFonts.roboto(color: COLOR_DARK_PURPLE);

final appBarTheme = AppBarTheme(
    textTheme: TextTheme(headline6: pageTitleWhite),
    color: COLOR_DARK_PURPLE,
    elevation: 2,
    shadowColor: Colors.grey,
    centerTitle: false,
    actionsIconTheme: IconThemeData(color: Colors.white));

ThemeData createTheme(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: COLOR_DARK_PURPLE,
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.white,
      textTheme: TextTheme(
        headline5: GoogleFonts.roboto(),
        headline6: GoogleFonts.roboto(),
        bodyText2: GoogleFonts.roboto(
          color: Colors.white,
        ),
        bodyText1: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
        headline4: GoogleFonts.roboto(
            fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.roboto(),
        headline2: GoogleFonts.roboto(),
        headline1: GoogleFonts.roboto(),
        subtitle2: GoogleFonts.roboto(),

        // used in text fields
        subtitle1: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
        caption: GoogleFonts.roboto(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.6))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white.withOpacity(.6))),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelStyle: GoogleFonts.roboto(
            fontSize: 16, color: Colors.white.withOpacity(0.6)),
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.white.withOpacity(0.6),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.accent,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.white,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: COLOR_DARK_PURPLE)));
}

ThemeData createThemePurpleOnWhite(BuildContext context) {
  return ThemeData(
      appBarTheme: appBarTheme,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.deepPurple,
      accentColor: Colors.white,
      textTheme: TextTheme(
        headline5: GoogleFonts.roboto(),
        headline6: GoogleFonts.roboto(),
        bodyText2: GoogleFonts.roboto(
          fontSize: 14,
          fontStyle: FontStyle.normal,
          color: Colors.black.withOpacity(.6),
        ),
        bodyText1: GoogleFonts.roboto(fontSize: 16, color: Colors.red),
        headline4: GoogleFonts.roboto(
            fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
        headline3: GoogleFonts.roboto(),
        headline2: GoogleFonts.roboto(),
        headline1: GoogleFonts.roboto(),
        subtitle2: GoogleFonts.roboto(),

        // used in text fields
        subtitle1: GoogleFonts.roboto(
            color: Colors.black.withOpacity(.6), fontSize: 16),
        button: GoogleFonts.roboto(
            fontSize: 14, fontWeight: FontWeight.w500, color: Colors.red),
        caption: GoogleFonts.roboto(),
      ),
      toggleableActiveColor: COLOR_DARK_PURPLE,
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR_DARK_PURPLE)),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black.withOpacity(.6))),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: COLOR_DARK_PURPLE)),
        labelStyle: GoogleFonts.roboto(fontSize: 14, color: COLOR_DARK_PURPLE),
        hintStyle: GoogleFonts.roboto(
          fontSize: 16,
          color: Colors.black.withOpacity(.6),
        ),
      ),
      buttonTheme: ButtonThemeData(
          buttonColor: COLOR_DARK_PURPLE,
          textTheme: ButtonTextTheme.primary,
          colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: COLOR_DARK_PURPLE,
              // secondary will be the textColor, when the textTheme is set to accent
              secondary: Colors.white)));
}

enum SwipeServiceOffering {
  BUY_LOAD,
  CASH_IN,
  PAY_QR,
  REMITTANCE,
  REMITTANCE_INSTAPAY,
  BILLS_PAYMENT,
  INSURANCE,
  BANK_TRANSFER,
  REQUEST_MONEY,
  AUTOSWEEP,
  MORE
}

Map<SwipeServiceOffering, String> SwipeServiceRoutes = {
  SwipeServiceOffering.BUY_LOAD: '..'
};

NumberFormat formatter = NumberFormat.currency(name: 'PHP ', decimalDigits: 2);
NumberFormat formatterWithoutPHP =
    NumberFormat.currency(name: " ", decimalDigits: 2);
NumberFormat formatterInt =
    NumberFormat.currency(name: " ", decimalDigits: 0, customPattern: "###");

DateFormat dateformatter = DateFormat("M/d/y");
