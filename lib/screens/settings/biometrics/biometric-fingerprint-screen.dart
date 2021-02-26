import 'dart:io' show Platform;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/otp/otp-screen.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class BiometricFingerprintScreen extends StatefulWidget {
  @override
  _BiometricFingerprintScreenState createState() =>
      _BiometricFingerprintScreenState();
}

class _BiometricFingerprintScreenState
    extends State<BiometricFingerprintScreen> {
  AuthenticationService authenticationService = AuthenticationService();
  bool enableBio;

  @override
  void initState() {
    super.initState();
    getBio();
  }

  void getBio() async {
    bool isEnabled = await authenticationService.getBio() ?? false;
    store.setEnabledBiometrics(isEnabled);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'swipe-dialog-confirmation': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: SETTINGS_SCREEN_SWIPE_DIALOG_CONFIRMATION,
          contentMessage: Platform.isAndroid
              ? SETTINGS_SCREEN_SWIPE_BIOMETRIC_NOTE_TEXT
              : SETTINGS_SCREEN_SWIPE_FACEID_NOTE_TEXT,
          cancelBtn: true,
          onOk: () async {
            OverlayScreen().pop();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => OtpScreen(
                  mobileNumber: store.user.mobileNumber,
                  type: OtpServiceAction.ENABLE_FINGERPRINT,
                  btnText: SETTINGS_SCREEN_BIOMETRIC_OTP_ENROLL_NOW,
                  onOk: () async {
                    await setFingerprint();
                  },
                ),
              ),
            );
          },
        ),
      ),
      'swipe-dialog-disable': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: SETTINGS_SCREEN_SWIPE_DISABLE_TEXT,
          contentMessage: SETTINGS_SCREEN_SWIPE_DISABLE_CONFIRMATION_TEXT,
          cancelBtn: true,
          onOk: () async {
            await setFingerprint();
            OverlayScreen().pop();
          },
        ),
      ),
    });

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
                    Platform.isAndroid
                        ? Image.asset('assets/icons/biometrics/fingerprint.png')
                        : Image.asset('assets/icons/biometrics/faceid.png'),
                    Text(
                      SETTINGS_SCREEN_BIOMETRIC_BANNER_TEXT,
                      style: GoogleFonts.roboto(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 4,
                          color: Colors.black),
                    ),
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
            Observer(
              builder: (_) => SwitchListTile(
                title: Text(
                  SETTINGS_SCREEN_BIOMETRIC_ENABLE_TEXT,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 14),
                ),
                value: store.enabledBiometrics,
                onChanged: confirmationPopUp,
              ),
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

  void confirmationPopUp(val) {
    setState(() => enableBio = val);
    if (val) {
      OverlayScreen().show(
        context,
        identifier: 'swipe-dialog-confirmation',
      );
    } else {
      OverlayScreen().show(
        context,
        identifier: 'swipe-dialog-disable',
      );
    }
  }

  void setFingerprint() async {
    try {
      bool enableBiometrics = await authenticationService.authFingerprint();
      print('fingerprint $enableBiometrics');
      if (enableBio) {
        store.setEnabledBiometrics(enableBiometrics);
      } else {
        store.setEnabledBiometrics(false);
      }
      return null;
    } catch (err) {
      throw err;
    }
  }
}
