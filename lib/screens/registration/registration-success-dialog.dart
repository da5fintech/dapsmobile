import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class RegistrationSuccessDialog extends StatelessWidget {
  final Function onOk;
  const RegistrationSuccessDialog({Key key, this.onOk}) : super(key: key);

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
          Icon(Icons.check_circle, color: COLOR_GREEN),
          SizedBox(
            width: 5,
          ),
          Text(
            "Congratulations",
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      content: Text(
        'We\'ve successfully created your account!',
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
                "PROCEED TO LOGIN",
                style: GoogleFonts.roboto(
                    color: COLOR_DARK_PURPLE,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              onPressed: () {
                if (onOk != null) {
                  onOk();
                }
              }),
        ),
      ],
    );
  }
}