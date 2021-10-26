import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';

class RequestAccessPermissionDialog extends StatelessWidget {
  const RequestAccessPermissionDialog({Key key}) : super(key: key);

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
      title: Text(
        "Request Access Permission",
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Text(
        'To enjoy full features of the app, Swipe wants to access:\n\nContacts\nStorage\nDevices\' Location\nCamera',
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
                "OK",
                style:
                    GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: 14),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              }),
        ),
      ],
    );
  }
}
