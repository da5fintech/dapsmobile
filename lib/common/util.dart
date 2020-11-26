import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/common-alert.dialog.dart';
import 'package:swipe/common/size.config.dart';

class AppUtil {
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
}

var appUtil = AppUtil();
