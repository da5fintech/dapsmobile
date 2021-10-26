import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';

class SoonReleaseDialog extends StatelessWidget {
  final Function onOk;

  SoonReleaseDialog({this.onOk});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(vertical: 15),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.only(top: 30, left: 20, right: 30),
      title: Row(
        children: [
          Icon(Icons.error, color: COLOR_ORANGE),
          SizedBox(
            width: 5,
          ),
          Text(
            SOON_RELEASED_SCREEN_FEATURED_TEXT,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        SOON_RELEASED_SCREEN_NOTE_TEXT,
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
              SOON_RELEASED_SCREEN_OK_TEXT,
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