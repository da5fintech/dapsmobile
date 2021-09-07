import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class ErrorDialog extends StatelessWidget {
  final Function onOk;
  String title;
  String message;

  ErrorDialog(
      {Key key,
        this.onOk,
        this.title = "Oooopps",
        this.message = "something went wrong!\nplease try again."})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(vertical: 15),
      // shape: RectangleBorder(
      //     // borderRadius: BorderRadius.circular(8.0),
      //     ),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.only(top: 30, left: 20, right: 30),
      title: Row(
        children: [
          Icon(Icons.warning_rounded, color: Colors.red),
          SizedBox(
            width: 5,
          ),
          Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: SizeConfig.blockSizeVertical * 2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        store.lastTransactionResponse?.message ??
            message,
        style: GoogleFonts.roboto(
          color: Colors.black,
          // fontSize: normalizeSize(15),
        ),
        textAlign: TextAlign.left,
      ),
      actions: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: FlatButton(
            child: Text(
              'OK',
              style: GoogleFonts.roboto(
                  color: COLOR_DARK_PURPLE,
                  fontSize: SizeConfig.blockSizeVertical * 1.7,
                  fontWeight: FontWeight.w500),
            ),
            onPressed: () {
              if (onOk != null) {
                onOk();
              }
            },
          ),
        ),
      ],
    );
  }
}
