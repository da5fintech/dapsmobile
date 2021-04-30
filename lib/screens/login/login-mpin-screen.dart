import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/screens/otp/otp-screen.dart';
import 'package:swipe/screens/payment/wrong-mpin-dialog.dart';
import 'package:swipe/screens/settings/change-swipe-mpin/change-swipe-mpin-screen.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:swipe/common/constants.dart' as Constants;

import '../../main.dart';

final store = getIt<ApplicationStore>();

class LoginMpinScreen extends StatefulWidget {
  @override
  _LoginMpinScreenState createState() => _LoginMpinScreenState();
}

class _LoginMpinScreenState extends State<LoginMpinScreen> {
  AuthenticationService authenticationService = AuthenticationService();
  TextEditingController mpin = TextEditingController();
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
    fingerprintAuth();
  }

  Future<void> fingerprintAuth () async {
    //check if biometrics is enable in the settings
    try {
      await authenticationService.getBio().then((isEnabled) async {
        if(isEnabled) {
          bool success = await authenticationService.authFingerprint();
          if(success) {
            setState(() {
              mpin.text = store.user.mpin;
            });
            _handleLogin();
          } else {
            print('Unauthorized Login');
          }
        }
      });

    } catch (err) {}

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'wrong-mpin': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: WrongMpinDialog(
          onOk: () {
            _handleOk();
          },
        ),
      ),
      'mpin-recovery': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: MPIN_RECOVERY_TITLE,
          contentMessage: MPIN_RECOVERY_CONTENT_MESSAGE,
          cancelBtn: true,
          onOk: () async {
            OverlayScreen().pop();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => OtpScreen(
                    mobileNumber: store.user.mobileNumber,
                    type: OtpServiceAction.FORGOT_MPIN,
                    btnText: MPIN_RECOVERY_PROCEED,
                    onOk: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ChangeSwipeMpinScreen()),
                      );
                    }
                  ),
                )
            );
          },
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: <Widget>[
                  Container(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              Constants.APP_NAME,
                              style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 3.5,
                                  color: COLOR_DARK_PURPLE,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 15),
                            ),
                            Image.asset(
                              'assets/icons/swipe-logo.png',
                              height: height * 0.25,
                              width: width,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Constants.LOGIN_MPIN_SCREEN_LOGIN_TEXT),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: SizeConfig.blockSizeVertical * 3,
                              backgroundColor: COLOR_ORANGE,
                              child: store.user.photoURL == null
                                  ? Text(
                                      store.user.getInitials(),
                                      style: GoogleFonts.roboto(color: Colors.white),
                                    )
                                  : ClipOval(
                                      child: Image.network(store.user.photoURL),
                                    ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                store.user.displayName,
                                style: GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 2),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            TextFormField(
                              maxLength: 6,
                              controller: mpin,
                              keyboardType: TextInputType.number,
                              obscureText: obscureText,
                              onSaved: (v) {},
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'mpin is required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: "Enter your 6-digit MPIN",
                                counterStyle:
                                    GoogleFonts.roboto(color: Colors.white),
                                suffixIcon: IconButton(
                                  onPressed: () =>
                                      setState(() => obscureText = !obscureText),
                                  icon: obscureText
                                      ? Icon(Icons.visibility_off,
                                          color: COLOR_DARK_GRAY.withOpacity(.6))
                                      : Icon(
                                          Icons.visibility,
                                          color: COLOR_DARK_GRAY.withOpacity(.6),
                                        ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButtonWidget(
                                color: Colors.white,
                                onPressed: () {
                                  _handleLogin();
                                },
                                text: Constants.LOGIN_SCREEN_LOGIN_TEXT,
                              ),
                            ),
                          ],
                        ),

                        // OutlineButton(
                        //   child: Text("REGISTER",
                        //       style: Constants.primaryButtonText),
                        // ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FlatButton(
                            onPressed: (){
                              OverlayScreen().show(
                                context,
                                identifier: 'mpin-recovery',
                              );
                            },
                            child: Text(
                                'Forgot MPIN?',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 1.7,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                          ),
                          FlatButton(
                            onPressed: (){
                              Get.toNamed('/login/login-email-screen');
                            },
                            child: Text(
                                'Login using Password',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 1.7,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                          ),
                        ],
                      )
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10, left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/help');
                          },
                          child: Text(Constants.APP_HELP_CENTER, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                        ),
                        Text(store.versionNumber, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _handleLogin() {
    if (mpin.text != store.user.mpin) {
      OverlayScreen().show(
        context,
        identifier: 'wrong-mpin',
      );
    } else {
      Get.offAllNamed("/services");
    }
  }

  void _handleOk() {
    OverlayScreen().pop();
  }
}
