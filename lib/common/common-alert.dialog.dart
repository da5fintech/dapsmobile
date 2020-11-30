import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:swipe/common/widgets/secondary-button.widget.dart';

class CommonAlertDialog extends StatelessWidget {
  final backgroundColor;
  final title;
  final message;
  final actions;
  final showCancelBtn;
  final cancelText;
  final okText;
  final onOk;
  final onCancel;
  final onOkThenPop;
  final onCancelThenPop;
  const CommonAlertDialog({
    Key key,
    this.actions,
    this.backgroundColor,
    this.cancelText,
    this.message,
    this.okText,
    this.showCancelBtn,
    this.title = '',
    this.onOk,
    this.onOkThenPop = false,
    this.onCancel,
    this.onCancelThenPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      backgroundColor: backgroundColor ?? Colors.grey.shade900,
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.only(top: 30, left: 30, right: 30),
      title: title.isEmpty
          ? null
          : Text(
              title,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
      content: message,
      actions: actions ??
          <Widget>[
            if (showCancelBtn ?? true)
              Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: SecondaryButtonWidget(
                      text: cancelText ?? 'Cancel',
                      onPressed: () {
                        if (onCancel != null) {
                          onCancel();
                          if (onCancelThenPop) {
                            Navigator.of(context).pop(false);
                          }
                        } else {
                          Navigator.of(context).pop(false);
                        }
                      })),
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: PrimaryButtonWidget(
                  text: okText ?? 'OK',
                  onPressed: () {
                    if (onOk != null) {
                      onOk();
                      if (onOkThenPop) {
                        Navigator.of(context).pop(true);
                      }
                    } else {
                      Navigator.of(context).pop(true);
                    }
                  }),
            ),
          ],
    );
  }
}
