import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';

class CloseDialog extends StatelessWidget {
  final Function onOk;

  CloseDialog({this.onOk});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(vertical: 15),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.only(top: 30, left: 20, right: 30),
      title: Row(
        children: [
          Icon(Icons.error, color: COLOR_DANGER),
          SizedBox(
            width: 5,
          ),
          Text(
            'Exit Application',
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        'Are you sure you want to Exit the app?',
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
              VERIFIED_DIALOG_SCREEN_CANCEL,
              style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: 14),
            ),
            onPressed: () {
              OverlayScreen().pop();
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(right: 15),
          child: FlatButton(
            child: Text(
              'EXIT',
              style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: 14),
            ),
            onPressed: () {
              onOk();
            },
          ),
        ),
      ],
    );
  }
}
