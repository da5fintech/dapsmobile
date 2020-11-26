library constants;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/util.dart';

const BLUR_RADIUS = 10;

const backgroundColor1 = Color(0xFFE5E5E5);
const backgroundColor2 = Color(0xFFEEF2F4);

const black181818 = Color(0xFF181818);
const black282828 = Color(0xFF282828);

const COLOR_000407 = Color(0xFF000407);
const COLOR_000D14 = Color(0xFF000D14);

const charcoalColor = Color(0xFF454545);
const themeRed = Color(0xFFED1F24);
// const lightBlue = Color(0xFF93FBAA);
const themeBlue = Color(0xFF003F5C);
const themeBlue2 = Color(0xFF2A3952);
const themeRed2 = Color(0xFF4F3449);
// const green3 = Color(0xFF4EAE97);
// const green4 = Color(0xFF83E799);

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

TextStyle poppinsNormalWhite12 =
    GoogleFonts.montserrat(fontSize: 12, color: Colors.white);
TextStyle poppinsNormalWhite13 =
    GoogleFonts.montserrat(fontSize: 13, color: Colors.white);
TextStyle poppinsNormalWhite14 =
    GoogleFonts.montserrat(fontSize: 14, color: Colors.white);
TextStyle poppinsNormalWhite11 =
    GoogleFonts.montserrat(fontSize: 11, color: Colors.white);
TextStyle poppinsNormalGray11 =
    GoogleFonts.montserrat(fontSize: 11, color: Colors.grey.shade500);
TextStyle poppinsNormalGray12 =
    GoogleFonts.montserrat(fontSize: 12, color: Colors.grey.shade500);
TextStyle poppinsNormalGray13 =
    GoogleFonts.montserrat(fontSize: 13, color: Colors.grey.shade500);
TextStyle poppinsNormalGrayS60013 =
    GoogleFonts.montserrat(fontSize: 13, color: Colors.grey.shade600);
TextStyle poppinsNormalBlack11 =
    GoogleFonts.montserrat(fontSize: 11, color: Color(0xFF2F2F2F));
TextStyle poppinsNormalBlack13 =
    GoogleFonts.montserrat(fontSize: 13, color: Color(0xFF2F2F2F));
TextStyle poppinsW500Black11 = GoogleFonts.montserrat(
    fontSize: 11, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w500);
TextStyle poppinsW500Black13 = GoogleFonts.montserrat(
    fontSize: 13, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w500);
TextStyle poppinsW500White13 = GoogleFonts.montserrat(
    fontSize: 13, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500White9 = GoogleFonts.montserrat(
    fontSize: 9, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500White11 = GoogleFonts.montserrat(
    fontSize: 11, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500White12 = GoogleFonts.montserrat(
    fontSize: 12, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsNormalBlack14 =
    GoogleFonts.montserrat(fontSize: 14, color: Color(0xFF2F2F2F));
TextStyle poppinsNormalBlack12 =
    GoogleFonts.montserrat(fontSize: 12, color: Color(0xFF5F5F5F));
TextStyle poppinsW500Black14 = GoogleFonts.montserrat(
    fontSize: 14, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w500);
TextStyle poppinsW500White14 = GoogleFonts.montserrat(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW200White11 = GoogleFonts.montserrat(
    fontSize: 11, color: Colors.white, fontWeight: FontWeight.w200);
TextStyle poppinsW200Black11 = GoogleFonts.montserrat(
    fontSize: 11, color: Colors.black, fontWeight: FontWeight.w200);
TextStyle poppinsW500WhiteShadow14 = GoogleFonts.montserrat(
    fontSize: 14,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    shadows: shadowLight);
TextStyle poppinsW500WhiteShadow11 = GoogleFonts.montserrat(
    fontSize: 11,
    color: Colors.white,
    fontWeight: FontWeight.normal,
    shadows: shadowLight);
TextStyle poppinsW500WhiteShadow9 = GoogleFonts.montserrat(
    fontSize: 9,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    shadows: shadowHard);
TextStyle poppinsW500WhiteShadow7 = GoogleFonts.montserrat(
    fontSize: 7,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    shadows: shadowHard);
TextStyle poppinsW500WhiteShadow16 = GoogleFonts.montserrat(
    fontSize: 16,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    shadows: shadowLight);
TextStyle poppinsW500WhiteShadow32 = GoogleFonts.montserrat(
    fontSize: 32,
    color: Colors.white,
    fontWeight: FontWeight.w500,
    shadows: shadowLight);
TextStyle poppinsW500Black18 = GoogleFonts.montserrat(
    fontSize: 18, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w500);
TextStyle poppinsW500Black24 = GoogleFonts.montserrat(
    fontSize: 24, color: Color(0xFF2F2F2F), fontWeight: FontWeight.w500);

TextStyle poppinsW500White16 = GoogleFonts.montserrat(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500Black16 = GoogleFonts.montserrat(
    fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w500);
TextStyle poppinsNormalBlack16 = GoogleFonts.montserrat(
  fontSize: 16,
  color: Colors.black87,
);
TextStyle poppinsW500White18 = GoogleFonts.montserrat(
  fontSize: 18,
  color: Colors.white,
  fontWeight: FontWeight.w500,
  // shadows: shadowLight
);
TextStyle poppinsW500White24 = GoogleFonts.montserrat(
    fontSize: 24, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500White32 = GoogleFonts.montserrat(
    fontSize: 32, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500White48 = GoogleFonts.montserrat(
    fontSize: 48, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle poppinsW500Black48 = GoogleFonts.montserrat(
    fontSize: 48,
    color: Colors.black.withOpacity(0.8),
    fontWeight: FontWeight.w500);
TextStyle poppinsBoldBlack18 = GoogleFonts.montserrat(
    fontSize: 18, color: Color(0xFF2F2F2F), fontWeight: FontWeight.bold);
TextStyle poppinsBoldBlack16 = GoogleFonts.montserrat(
    fontSize: 16, color: Color(0xFF2F2F2F), fontWeight: FontWeight.bold);
TextStyle poppinsNormalGray14 =
    GoogleFonts.montserrat(fontSize: 14, color: Color.fromRGBO(69, 69, 69, .5));
TextStyle poppinsBoldBlack13 = GoogleFonts.montserrat(
    fontSize: 13, color: Color(0xFF2F2F2F), fontWeight: FontWeight.bold);
TextStyle poppinsBoldWhite13 = GoogleFonts.montserrat(
    fontSize: 13, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle poppinsBoldWhite12 = GoogleFonts.montserrat(
    fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle poppinsBoldBlack14 = GoogleFonts.montserrat(
    fontSize: 14, color: Color(0xFF2F2F2F), fontWeight: FontWeight.bold);
TextStyle poppinsBoldWhite14 = GoogleFonts.montserrat(
    fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle textStyleTitleCharcoal = GoogleFonts.montserrat(
    fontSize: 24, color: charcoalColor, fontWeight: FontWeight.bold);
TextStyle poppinsBoldTheme24 = GoogleFonts.montserrat(
    fontSize: 24, color: themeBlue, fontWeight: FontWeight.bold);
TextStyle poppinsBoldCharcoal24 = GoogleFonts.montserrat(
    fontSize: 24, color: charcoalColor, fontWeight: FontWeight.bold);
TextStyle poppinsBoldCharcoal16 = GoogleFonts.montserrat(
    fontSize: 16, color: charcoalColor, fontWeight: FontWeight.bold);
TextStyle poppinsBoldCharcoal30 = GoogleFonts.montserrat(
    fontSize: 30, color: charcoalColor, fontWeight: FontWeight.bold);
TextStyle pageTitleWhite = GoogleFonts.montserrat(
    fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500);
TextStyle pageTitleGreen = GoogleFonts.montserrat(
    fontSize: 20, color: themeBlue, fontWeight: FontWeight.w500);
TextStyle poppinsBoldWhite20 = GoogleFonts.montserrat(
    fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle poppinsBoldWhite18 = GoogleFonts.montserrat(
    fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle poppinsBoldWhite30 = GoogleFonts.montserrat(
    fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold);
TextStyle poppinsNormalWhite15 = GoogleFonts.montserrat(
  color: Colors.white,
  fontSize: 15,
);
TextStyle poppinsNormalWhite9 = GoogleFonts.montserrat(
  color: Colors.white,
  fontSize: appUtil.normalizeSize(9),
);
