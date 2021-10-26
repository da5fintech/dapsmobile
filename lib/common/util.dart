import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:daps/common/widgets/error-dialog.dart';
import 'package:image/image.dart' as imglib;
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:daps/common/common-alert.dialog.dart';
import 'package:daps/common/widgets/error-dialog.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'dart:io';
import 'dart:core';
import 'package:google_ml_kit/google_ml_kit.dart';

import 'package:daps/models/notification-model.dart';

// typedef HandleDetection = Future<List<Face>> Function(
//     FirebaseVisionImage image);

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

  String removeCountryExtension(String mobileNumber) {
    return mobileNumber.substring(2);
  }

  int generateUid() {
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 8; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }
    return int.parse(rndnumber);
  }

  String formatUserPhoneNumber(String mobileNumber) {
    var splitNumber = mobileNumber.split("");
    var formattedNumber = "";
    var mobileLength = 8;

    for (int i = 8; i < mobileNumber.length; i++) {
      formattedNumber = formattedNumber + splitNumber[i];
    }

    return formattedNumber;
  }

  String removeCountryCodeNumber(String mobileNumber) {
    var splitNumber = mobileNumber.split("");
    splitNumber.removeAt(0);
    splitNumber.removeAt(0);
    var formmated = splitNumber.join("");
    return formmated;
  }

  int generateOtp() {
    var rndnumber = "";
    var rnd = new Random();
    rndnumber = (rnd.nextInt(900000) + 100000).toString();
    return int.parse(rndnumber);
  }

  int uid() {
    var rndnumber = "";
    var rnd = new Random();
    rndnumber = (rnd.nextInt(90000000) + 10000000).toString();
    return int.parse(rndnumber);
  }

  String splitQrData(String customQr, amount) {
    List qrData = customQr.split('/');
    qrData.add(amount);
    String a = qrData.join('/');
    return a;
  }

  String generateTransactionNumber() {
    var transactionNumber = "";
    var rnd = new Random();
    // for (var i = 0; i < 11; i++) {
    transactionNumber = transactionNumber + rnd.nextInt(999999).toString();
    // }
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
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }

  Future<BitmapDescriptor> getBitmapDescriptorFromAssetBytes(
      String path, int width) async {
    final Uint8List imageData = await getBytesFromAsset(path, width);
    return BitmapDescriptor.fromBytes(imageData);
  }

  Future<void> deleteImage(path) async {
    try {
      final file = await File(path);
      print('deleting file image');
      print(path);
      await file.delete();
      print('FILE DELETED');
    } catch (err) {
      rethrow;
    }
  }

  ///image convertion
  Future<List<int>> convertImagetoPng(CameraImage image) async {
    try {
      imglib.Image img;
      if (image.format.group == ImageFormatGroup.yuv420) {
        img = _convertYUV420(image);
      } else if (image.format.group == ImageFormatGroup.bgra8888) {
        img = _convertBGRA8888(image);
      }

      imglib.PngEncoder pngEncoder = new imglib.PngEncoder();

      // Convert to png
      List<int> png = pngEncoder.encodeImage(img);
      return png;
    } catch (e) {
      print(">>>>>>>>>>>> ERROR:" + e.toString());
    }
    return null;
  }

  imglib.Image _convertBGRA8888(CameraImage image) {
    return imglib.Image.fromBytes(
      image.width,
      image.height,
      image.planes[0].bytes,
      format: imglib.Format.bgra,
    );
  }

  imglib.Image _convertYUV420(CameraImage image) {
    var img = imglib.Image(image.width, image.height); // Create Image buffer

    Plane plane = image.planes[0];
    const int shift = (0xFF << 24);

    // Fill image buffer with plane[0] from YUV420_888
    for (int x = 0; x < image.width; x++) {
      for (int planeOffset = 0;
          planeOffset < image.height * image.width;
          planeOffset += image.width) {
        final pixelColor = plane.bytes[planeOffset + x];
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        // Calculate pixel color
        var newVal =
            shift | (pixelColor << 16) | (pixelColor << 8) | pixelColor;

        img.data[planeOffset + x] = newVal;
      }
    }

    return img;
  }

  Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
          (List<CameraDescription> cameras) => cameras.firstWhere(
            (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return InputImageRotation.Rotation_0deg;
      case 90:
        return InputImageRotation.Rotation_90deg;
      case 180:
        return InputImageRotation.Rotation_180deg;
      default:
        assert(rotation == 270);
        return InputImageRotation.Rotation_270deg;
    }
  }

  Future<List<Face>> detect(CameraImage image, handleDetection,
      InputImageRotation rotation) async {
    return handleDetection(
        InputImage.fromBytes(bytes: concatenatePlanes(image.planes), inputImageData: buildMetaData(image, rotation))
      // FirebaseVisionImage.fromBytes(
      //   concatenatePlanes(image.planes),
      //   buildMetaData(image, rotation),
      // ),
    );
  }

  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  InputImageData buildMetaData(
      CameraImage image,
      InputImageRotation rotation,
      ) {
    final InputImageFormat inputImageFormat =
        InputImageFormatMethods.fromRawValue(image.format.raw) ?? InputImageFormat.NV21;

    return InputImageData(
      size: Size(image.width.toDouble(), image.height.toDouble()),
      imageRotation: rotation,
      inputImageFormat: inputImageFormat,
      planeData: image.planes.map(
            (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  //amount mask formatter
  String formatNumber(String s) =>
      NumberFormat.decimalPattern('en').format(int.parse(s));

  String get currency =>
      NumberFormat.compactSimpleCurrency(locale: 'en').currencySymbol;

  double unFormatAmount(String amount) {
    var a = amount.replaceAll(",", "");
    return double.parse(a);
  }

  int countUnseenNotifications(List<NotificationModel> notifs) {
    int counter = 0;
    if (notifs.isEmpty) return 0;
    notifs.map((n) {
      if (!n.isSeen) {
        counter += 1;
      }
    }).toList();
    return counter;
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
    final day = <String>[
      'Saturday',
      'Sunday',
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday'
    ];

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
    final month = <String>[
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
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

  totalLengthOfDays(final int monthNum, final int dayNum, final int year) =>
      daysPastInYear(monthNum, dayNum, year) + yearLength(year);

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

class CurrencyInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      print(true);
      return newValue;
    }

    double value = double.parse(newValue.text);

    final formatter = NumberFormat.simpleCurrency(locale: "PHP_\u20b1");

    String newText = formatter.format(value / 100);

    return newValue.copyWith(
        text: newText,
        selection: new TextSelection.collapsed(offset: newText.length));
  }
}

void modalHudLoad(context,
    {String load = "Loading...",
    Color color = Colors.white,
    Color indicatorColor = Colors.white}) async {
  showDialog(
    barrierColor: Colors.black.withOpacity(0.4),
    barrierDismissible: false,
    context: context,
    builder: (_) => WillPopScope(
      onWillPop: () => Future.value(false),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: COLOR_DAPS),
          SizedBox(height: 10),
          Text(
            load,
            style: Theme.of(context).textTheme.subtitle1.copyWith(color: color),
          ),
        ],
      ),
    ),
  );
}

void errorModal(context,
    {String title = "Ooopps",
      Function back,
      String message = "Something went wrong\nPlease try again later."}) async {
  showDialog(
    context: context,
    builder: (_) => ErrorDialog(
      title: title,
      message: message,
      onOk: () {
        Navigator.pop(context);
      },
    ),
  );
}

void bpiLogin(context,
    {String title = "Ooopps",
      Function onOk,
      String message = "Something went wrong\nPlease try again later."}) async {
  showDialog(
    context: context,
    builder: (_) => ErrorDialog(
      title: title,
      message: message,
      onOk: () {
        onOk();
      },
    ),
  );
}



var appUtil = AppUtil();
