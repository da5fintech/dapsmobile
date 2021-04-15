import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

class VerifiedDialog extends StatelessWidget {
  final Function onOk;

  VerifiedDialog({this.onOk});

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
            VERIFIED_DIALOG_SCREEN,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: SizeConfig.blockSizeVertical * 2.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        VERIFIED_DIALOG_SCREEN_UPDATE_TEXT,
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: SizeConfig.blockSizeVertical * 2

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
              style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: SizeConfig.blockSizeVertical * 2),
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
              VERIFIED_DIALOG_SCREEN_GO_TO_VERIFY,
              style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: SizeConfig.blockSizeVertical * 2),
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
