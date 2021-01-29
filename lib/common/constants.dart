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

const AUTH_MERCHANT_ID = "0910";
const AUTH_NETWORK_ID = "0625";
const AUTH_USERNAME = "kabootekph";
const AUTH_SIGNATURE = "ce9e72f2e2b3f12c386b68f3acc0748d5a355dbf";
const API_ENDPOINT = "https://directagent5.com.ph/daps/index.php";
const ELOADING_SCOPE = 'eloading';
const BILLS_PAYMENT_SCOPE = 'billspayment';
const BILLS_PAYMENT_CHANNEL = 'X2B2';
const INSTAPAY_SCOPE = 'instapay';

const REGISTER_MPIN_SCREEN_SET_PIN_TEXT = "Set your Mobile Pin";
const REGISTER_MPIN_SCREEN_NOTE_TEXT =
    "MPIN is a 6 digit security codes used to authenticate"
    "\nlogin request and transactions."
    "\n\nNote: Please avoid using weak MPINs like your"
    "\nBirthdate, 123456, 888888.";
const REGISTER_MPIN_SCREEN_TEXT = "MPIN";

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
