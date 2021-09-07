import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class BpiOtpScreen extends StatefulWidget {
  const BpiOtpScreen({Key key}) : super(key: key);

  @override
  _BpiOtpScreenState createState() => _BpiOtpScreenState();
}

class _BpiOtpScreenState extends State<BpiOtpScreen> {
  TextEditingController controller = TextEditingController();
  bool incorrectOtp = false;

  @override
  Widget build(BuildContext context) {
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "OTP Verification",
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
                            child: Text(
                              SETTINGS_SCREEN_BIOMETRIC_OTP_GREET,
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
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
                                color: Colors.black,
                              ),
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
                          if(incorrectOtp) ...[
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
                              // FlatButton(
                              //   padding: EdgeInsets.zero,
                              //   onPressed: () async {
                              //     var generatedOtp = _appUtil.generateOtp();
                              //     expectedOtp = generatedOtp;
                              //     setState(() {});
                              //     OverlayScreen().show(
                              //       context,
                              //       identifier: 'progress',
                              //     );
                              //     await _handleOtpSms();
                              //     OverlayScreen().pop();
                              //     OverlayScreen().show(
                              //       context,
                              //       identifier: 'code-sent',
                              //     );
                              //   },
                              //   child: Text(
                              //     SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE,
                              //     style: GoogleFonts.roboto(
                              //       fontSize: 14,
                              //       fontWeight: FontWeight.w400,
                              //       color: COLOR_GREEN,
                              //     ),
                              //   ),
                              // ),
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
                  // onPressed: _handleSubmit,
                  child: Text('PROCESS'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 30),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // Get.toNamed('/help');
                      },
                      child: Text(
                        APP_HELP_CENTER,
                        style: GoogleFonts.roboto(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                    ),
                    Spacer(),
                    Text(
                      store.versionNumber,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
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
