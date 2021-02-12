import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/registration/registration-success-dialog.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class RegistrationOptScreen extends StatefulWidget {
  @override
  _RegistrationOptScreenState createState() => _RegistrationOptScreenState();
}

class _RegistrationOptScreenState extends State<RegistrationOptScreen> {
  int expectedOtp;
  bool incorrectOtp = false;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'registration-success': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: RegistrationSuccessDialog(
          onOk: () {
            _handleOk();
          },
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: REGISTRATION_SCREEN_OTP_TITLE_TEXT,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: height,
                  child: SingleChildScrollView(
                    child: Container(
                      height: height * 0.75,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Icon(
                              Icons.mobile_friendly,
                              size: 60,
                              color: COLOR_DARK_PURPLE,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 25.0),
                            child: Text(SETTINGS_SCREEN_BIOMETRIC_OTP_GREET,
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              SETTINGS_SCREEN_BIOMETRIC_OTP_SEND,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 50),
                            child: Text(
                              SETTINGS_SCREEN_BIOMETRIC_OTP_LIMIT,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                            ),
                          ),
                          Container(
                            width: width * 0.60,
                            child: PinCodeTextField(
                              controller: controller,
                              obscureText: true,
                              keyboardType: TextInputType.number,
                              onChanged: (str) {
                                print("change ${str}");
                              },
                              appContext: context,
                              length: 6,
                              pinTheme: PinTheme(
                                activeColor: COLOR_DARK_PURPLE,
                                inactiveColor: Colors.black.withOpacity(.30),
                                fieldWidth: 20,
                              ),
                            ),
                          ),
                          if (incorrectOtp) ...[
                            Text(
                              REGISTRATION_SCREEN_INCORRECT_OTP_TEXT,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: COLOR_DANGER,
                              ),
                            ),
                          ],
                          Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                SETTINGS_SCREEN_BIOMETRIC_OTP_NEW_CODE,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(width: 5),
                              FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: _handleOtpSms,
                                child: Text(
                                  SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE,
                                  style: GoogleFonts.roboto(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: COLOR_GREEN),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 0,
                  color: controller.text.length != 6 ? Colors.grey[500] : null,
                  // shape: ,
                  onPressed: () {
                    _handleRegister();
                  },
                  child: Text('REGISTER'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Row(
                  children: [
                    Text(
                      APP_HELP_CENTER,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    Spacer(),
                    Text(
                      APP_VERSION,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _handleOtpSms() async {
    OverlayScreen().show(
      context,
      identifier: 'progress',
    );

    //Generate OTP
    await Future.delayed(Duration(seconds: 2));
    OverlayScreen().pop();
    var rndnumber = "";
    var rnd = new Random();
    for (var i = 0; i < 6; i++) {
      rndnumber = rndnumber + rnd.nextInt(9).toString();
    }

    expectedOtp = int.parse(rndnumber); //save otp
    setState(() {});
    await store.otpService.sendOtp(
        mobileNumber: "63${store.registrant.mobileNumber}", otp: expectedOtp);
  }

  _handleRegister() async {
    if (controller.text.length == 6) {
      if (int.parse(controller.text) == expectedOtp) {
        incorrectOtp = false;
        setState(() {});
        try {
          OverlayScreen().show(
            context,
            identifier: 'progress',
          );
          await Future.delayed(Duration(seconds: 5));
          OverlayScreen().pop();

          if (store.registrant.isNew) {
            User creds = await store.authService.createAuth(
                email: store.registrant.email,
                password: store.registrant.password);
            store.registrant.id = creds.uid;
          }

          await store.accountService.create(store.registrant);
          store.setUser(store.registrant);
          OverlayScreen().show(
            context,
            identifier: 'registration-success',
          );
        } catch (e) {}
      } else {
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );
        await Future.delayed(Duration(seconds: 3));
        OverlayScreen().pop();
        incorrectOtp = true;
        setState(() {});
      }
    }
    return null;
  }

  void _handleOk() {
    OverlayScreen().pop();
    Get.toNamed("/login/login-mpin-screen");
  }
}
