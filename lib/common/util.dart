import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/common/common-alert.dialog.dart';
import 'package:swipe/common/size.config.dart';
import 'dart:io';
import 'dart:core';

class AppUtil extends DateUtil {
  static AppUtil _instance = AppUtil._internal();
  AppUtil._internal();

  factory AppUtil() {
    return _instance;
  }
  double normalizeSize(double size) {
    return size * SizeConfig.screenDiagonal * .00085;
  }

  Future<bool> onWillExit(BuildContext context) async {
    return showCommonDialog(
      context,
      Text(
        'Do you want to exit the app?',
        style: GoogleFonts.montserrat(
          color: Colors.white,
          fontSize: normalizeSize(15),
        ),
        textAlign: TextAlign.left,
      ),
    );
  }

  Future<bool> showCommonDialog(
    BuildContext context,
    Widget message, {
    String title = '',
    List actions,
    bool barrierDismissible = true,
    Color backgroundColor,
    bool showCancelBtn = true,
    String okText = 'OK',
    String cancelText = 'Cancel',
    Function onCancel,
    bool onCancelThenPop,
    Function onOk,
    bool onOkThenPop,
  }) async {
    return (await showDialog(
            context: context,
            barrierDismissible: barrierDismissible,
            // barrierColor: Color(0x01000000),
            builder: (context) => CommonAlertDialog(
                  actions: actions,
                  backgroundColor: backgroundColor,
                  cancelText: cancelText,
                  message: message,
                  okText: okText,
                  showCancelBtn: showCancelBtn,
                  title: title,
                  onOk: onOk,
                  onCancel: onCancel,
                  onCancelThenPop: onCancelThenPop,
                  onOkThenPop: onOkThenPop,
                ))) ??
        false;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Please Enter a valid email address';
    else
      return null;
  }

  int generateOtp () {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    return int.parse(rndnumber);
  }

  String splitQrData (String customQr, amount) {

    List qrData = customQr.split('/');
    qrData.add(amount);
    String a = qrData.join('/');
    return a;
  }

  String generateTransactionNumber () {
    var transactionNumber = "";
    var rnd = new Random();
    for (var i = 0; i < 11; i++) {
      transactionNumber = transactionNumber + rnd.nextInt(9).toString();
    }
    return transactionNumber;

  }

  String generateBarcodeNumber() {
    var ref = "";
    var rnd = new Random();
    for (var i = 0; i < 19; i++) {
      ref = ref + rnd.nextInt(9).toString();
    }
    return ref;
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

}

class DateUtil {
  var dayOfWeek = 0;
  int yearLength(int year) {
    var yearLength = 0;
    for (int counter = 1; counter < year; counter++) {
      if (counter >= 4) {
        if (leapYear(counter) == true)
          yearLength += 366;
        else
          yearLength += 365;
      } else
        yearLength += 365;
    }
    return yearLength;
  }

  String day(int length) {
    final day = <String>['Saturday', 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

    var count = 0;
    String resultDay;

    for (var counter = 1; counter <= length; counter++) {
      final check = ((counter > 639798) && (counter < 639811));
      if (check == true) {
      } else {
        if (count >= 7) {
          if (count % 7 == 0) count = 0;
        }
        resultDay = day[count];
        count++;
      }
    }
    if (count == 1)
      dayOfWeek = 7;
    else
      dayOfWeek = (count - 1);
    return resultDay;
  }

  String month(final int monthNum) {
    final month = <String>['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return month[monthNum - 1];
  }

  int daysInMonth(int monthNum, int year) {

    List<int> monthLength = List(12);

    monthLength[0] = 31;
    monthLength[2] = 31;
    monthLength[4] = 31;
    monthLength[6] = 31;
    monthLength[7] = 31;
    monthLength[9] = 31;
    monthLength[11] = 31;
    monthLength[3] = 30;
    monthLength[8] = 30;
    monthLength[5] = 30;
    monthLength[10] = 30;

    if (leapYear(year) == true)
      monthLength[1] = 29;
    else
      monthLength[1] = 28;

    return monthLength[monthNum - 1];
  }

  int daysPastInYear(final int monthNum, final int dayNum, final int year) {
    var totalMonthLength = 0;

    for (var count = 1; count < monthNum; count++) {
      totalMonthLength += daysInMonth(count, year);
    }

    var monthLengthTotal = totalMonthLength + dayNum;

    return monthLengthTotal;
  }

  totalLengthOfDays(final int monthNum, final int dayNum, final int year) => daysPastInYear(monthNum, dayNum, year) + yearLength(year);

  void printMonthCalendar(final int monthNum, final int year) {
    int dayNum = 1;
    final str_Day = <String>['Sun', 'Mon', 'Tue', 'Wed', 'Thur', 'Fri', 'Sat'];
    day(daysPastInYear(monthNum, 1, year) + yearLength(year));
    int dayDays = 1;

    for (int i = 0; i < 7; i++) {
      stdout.write('${str_Day[i]}\t');
    }
    stdout.writeln();

    for (int i = 1; i <= 6; i++) {
      for (int j = 1; j <= 7; j++) {
        if (dayNum >= dayOfWeek) {
          if (dayDays <= daysInMonth(monthNum, year)) {
            stdout.write('${dayDays}\t');
          }
          ++dayDays;
        } else if (dayNum < dayOfWeek) stdout.write('\t');

        dayNum++;
      }
      stdout.writeln();
    }
  }

  int getWeek(int monthNum, int dayNum, int year) {
    double a = (daysPastInYear(monthNum, dayNum, year) / 7) + 1;
    return a.toInt();
  }

  bool leapYear(int year) {
    bool leapYear = false;

    bool leap = ((year % 100 == 0) && (year % 400 != 0));
    if (leap == true)
      leapYear = false;
    else if (year % 4 == 0) leapYear = true;

    return leapYear;
  }
}

var appUtil = AppUtil();
