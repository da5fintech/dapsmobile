import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';

class SwipeDialog extends StatelessWidget {
  final Function onOk;
  final Function cancel;
  final String title;
  final String contentMessage;
  bool cancelBtn = false;

  SwipeDialog({
    @required this.onOk,
    @required this.title,
    @required this.contentMessage,
    this.cancelBtn,
    this.cancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: EdgeInsets.symmetric(vertical: 15),
      backgroundColor: Colors.white,
      titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
      contentPadding: EdgeInsets.only(top: 15, left: 20, right: 30),
      title: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
      content: Text(
        contentMessage,
        style: GoogleFonts.roboto(
          color: COLOR_DARK_GRAY,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          // fontSize: normalizeSize(15),
        ),
        textAlign: TextAlign.left,
      ),
      actions: <Widget>[
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: MediaQuery.of(context).size.width,
              child: ButtonTheme(
                buttonColor: COLOR_DARK_PURPLE,
                child: RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    onOk();
                  },
                  child: Text(
                    'OK',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            if(cancelBtn) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width,
                child: ButtonTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                    side: BorderSide(
                      color: COLOR_DARK_PURPLE,
                    ),
                  ),
                  child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                      OverlayScreen().pop();
                      cancel();
                    },
                    child: Text(
                      'CANCEL',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DARK_PURPLE,
                      ),
                    ),
                  ),
                ),
              ),
            ]
          ],
        )
      ],
    );
  }
}
