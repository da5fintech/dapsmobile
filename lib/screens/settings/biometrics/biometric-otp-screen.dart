import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class BiometricOtpScreen extends StatefulWidget {
  final Function onOk;

  BiometricOtpScreen({this.onOk});

  @override
  _BiometricOtpScreen createState() => _BiometricOtpScreen();
}

class _BiometricOtpScreen extends State<BiometricOtpScreen> {
  Function onOk;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_BIOMETRIC_LOGIN_TEXT,
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
                                onPressed: () {},
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
                  // shape: ,
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onOk();
                  },
                  child: Text(SETTINGS_SCREEN_BIOMETRIC_OTP_ENROLL_NOW),
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
}
