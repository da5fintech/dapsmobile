import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class BiometricFingerprintScreen extends StatefulWidget {
  @override
  _BiometricFingerprintScreenState createState() =>
      _BiometricFingerprintScreenState();
}

class _BiometricFingerprintScreenState
    extends State<BiometricFingerprintScreen> {
  bool isEnabled = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_BIOMETRIC_LOGIN_TEXT,
        ),
        body: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/biometrics/fingerprint.png',
                    ),
                    Text(SETTINGS_SCREEN_BIOMETRIC_BANNER_TEXT,
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 4,
                          color: Colors.black,
                        )),
                    Text(
                      SETTINGS_SCREEN_BIOMETRIC_BANNER_NOTE_TEXT,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          height: 2,
                          color: COLOR_DARK_GRAY),
                    )
                  ],
                ),
              ),
            ),
            SwitchListTile(
              title: Text(
                SETTINGS_SCREEN_BIOMETRIC_ENABLE_TEXT,
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14),
              ),
              value: isEnabled,
              onChanged: (value) {
                setState(() {
                  isEnabled = value;
                });
              },
            ),
            Divider(thickness: 1),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      SETTINGS_SCREEN_BIOMETRIC_DISCLAIMER_TEXT,
                      style: GoogleFonts.roboto(
                          color: COLOR_DARK_GRAY,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
