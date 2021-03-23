import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/greet-dialog.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class OtpScreen extends StatefulWidget {
  String mobileNumber;
  OtpServiceAction type;
  final Function onOk;
  String btnText;

  OtpScreen({this.onOk, @required this.mobileNumber, @required this.type, @required this.btnText});

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  Function onOk;
  TextEditingController controller = TextEditingController();
  int expectedOtp;
  bool incorrectOtp = false;
  AppUtil _appUtil = AppUtil();

  @override
  void initState() {
    super.initState();
    expectedOtp = _appUtil.generateOtp();
    controller.text = expectedOtp.toString();
    _handleOtpSms();
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
      'code-sent': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: GreetDialog(
          title: "New Code Sent",
          contentMessage: "We’ve successfully sent a new OTP code to your mobile number.",
          cancelBtn: false,
          btnText: "OK",
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return Theme(
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
                              FlatButton(
                                padding: EdgeInsets.zero,
                                onPressed: () async {
                                  var generatedOtp = _appUtil.generateOtp();
                                  expectedOtp = generatedOtp;
                                  setState(() {});
                                  OverlayScreen().show(
                                    context,
                                    identifier: 'progress',
                                  );
                                  await _handleOtpSms();
                                  OverlayScreen().pop();
                                  OverlayScreen().show(
                                    context,
                                    identifier: 'code-sent',
                                  );
                                },
                                child: Text(
                                  SETTINGS_SCREEN_BIOMETRIC_OTP_RESEND_CODE,
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: COLOR_GREEN,
                                  ),
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
                  onPressed: _handleSubmit,
                  child: Text(widget.btnText),
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
                        color: Colors.black,
                      ),
                    ),
                    Spacer(),
                    Text(
                      APP_VERSION,
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

  Future _handleOtpSms() async {
    await store.otpService
        .sendOtp(mobileNumber: widget.mobileNumber, otp: expectedOtp);
  }

  Future _forgotMPIN () async {
    await store.otpService.forgotMpin(widget.mobileNumber, store.user);
  }

  void _handleSubmit() async {
    if(controller.text.length == 6) {
      if(expectedOtp == int.parse(controller.text)) {
        incorrectOtp = false;
        setState(() { });
        switch(widget.type){
          case OtpServiceAction.FORGOT_MPIN:
            // await _forgotMPIN();
            widget.onOk();
            return;
          default:
            widget.onOk();
        }
        Navigator.pop(context);
      } else {
        incorrectOtp = true;
        setState(() {});
      }
    }
    return null;
  }
}
