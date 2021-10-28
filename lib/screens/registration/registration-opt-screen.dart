import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/main.dart';
import 'package:daps/screens/registration/registration-success-dialog.dart';
import 'package:daps/screens/registration/registration-failed-dialog.dart';
import 'package:daps/store/application-store.dart';

final store = getIt<ApplicationStore>();

class RegistrationOptScreen extends StatefulWidget {
  @override
  _RegistrationOptScreenState createState() => _RegistrationOptScreenState();
}

class _RegistrationOptScreenState extends State<RegistrationOptScreen> {
  int expectedOtp;
  bool incorrectOtp = false;
  TextEditingController controller = TextEditingController();
  AppUtil _appUtil = AppUtil();

  @override
  void initState() {
    super.initState();
    expectedOtp = _appUtil.generateOtp();
    _handleOtpSms();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    MediaQueryData queryData = MediaQuery.of(context);

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
            Text("Loading...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'failed-registration': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: RegistrationFailedDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        )
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

    return Scaffold(
      backgroundColor: COLOR_DAPS,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      APP_NAME,
                      style: GoogleFonts.roboto(
                          fontSize: SizeConfig.blockSizeVertical * 4,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 15),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: height,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (OverscrollIndicatorNotification overscroll) {
                      overscroll.disallowGlow();
                      return;
                    },
                    child: SingleChildScrollView(
                      child: Container(
                        height: height * 0.70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 6),
                              child: Icon(
                                Icons.mobile_friendly,
                                size: SizeConfig.blockSizeVertical * 6,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: SizeConfig.blockSizeVertical * 3),
                              child: Text(
                                SETTINGS_SCREEN_BIOMETRIC_OTP_GREET,
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 50),
                              child: Text(
                                SETTINGS_SCREEN_BIOMETRIC_OTP_SEND,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  color: Colors.white,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: queryData.devicePixelRatio * 25),
                              child: Text(
                                SETTINGS_SCREEN_BIOMETRIC_OTP_LIMIT,
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.w400,
                                  height: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              width: width * 0.60,
                              child: PinCodeTextField(
                                textStyle: TextStyle(color: Colors.white, fontSize: 18),
                                backgroundColor: COLOR_DAPS,
                                controller: controller,
                                obscureText: true,
                                keyboardType: TextInputType.number,
                                onChanged: (str) {
                                  print("change ${str}");
                                },
                                appContext: context,
                                length: 6,
                                pinTheme: PinTheme(
                                  activeColor: Colors.white,
                                  inactiveColor: Colors.white,
                                  fieldWidth: 20,
                                ),
                              ),
                            ),
                            if (incorrectOtp) ...[
                              Text(
                                REGISTRATION_SCREEN_INCORRECT_OTP_TEXT,
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
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
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 5),
                                FlatButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () async {
                                    var a = _appUtil.generateOtp();
                                    expectedOtp = a;
                                    setState(() {});
                                    OverlayScreen().show(context, identifier: 'progress');
                                    await _handleOtpSms();
                                    OverlayScreen().pop();
                                  },
                                  child: Text(
                                    SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE,
                                    style: GoogleFonts.roboto(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: COLOR_ORANGE),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.blockSizeVertical * 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  elevation: 0,
                  color: controller.text.length != 6
                      ? Colors.white.withOpacity(0.32)
                      : Colors.white,
                  // shape: ,
                  onPressed: () {
                    _handleRegister();
                  },
                  child: Text('REGISTER', style: TextStyle(color: COLOR_DAPS)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('/help');
                      },
                      child: Text(
                        APP_HELP_CENTER,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
                    ),
                    Spacer(),
                    Text(
                      store.versionNumber,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
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

  Future _handleOtpSms() async {
    //Generate OTP
    await store.otpService.sendOtp(
        mobileNumber: store.registrant.mobileNumber, otp: expectedOtp);
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
          Map<String, dynamic> creds = await store.authService.createAuth(
            email: store.registrant.emailAddress,
            password: store.registrant.password,
          );
          if(creds['success'] == false) {
            print('No User is created');
            OverlayScreen().pop();
            OverlayScreen().show(
              context,
              identifier: 'failed-registration',
            );
          } else {
            OverlayScreen().pop();
            print('User creation');
            store.registrant.balance = await store.dapsAuthenticationService.balanceSyncing(store.registrant.credentials);
            await store.accountService.create(store.registrant);
            await store.dapsAuthenticationService.saveCredentials(store.registrant.credentials);
            await store.otpService.smsGreeting('${store.registrant.mobileNumber}');
            store.setUser(store.registrant);
            OverlayScreen().show(
              context,
              identifier: 'registration-success',
            );
          }
        } catch (e) {
          print(e);
        }
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
