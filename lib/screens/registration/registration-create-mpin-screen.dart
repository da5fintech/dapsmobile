import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/screens/registration/registration-success-dialog.dart';
import 'package:daps/store/application-store.dart';
import 'package:flutter/gestures.dart';
import 'package:daps/screens/markdowns-views/terms-condition-screen.dart';
import '../../main.dart';

final store = getIt<ApplicationStore>();

class RegistrationCreateMpinScreen extends StatefulWidget {
  @override
  _RegistrationCreateMpinScreenState createState() =>
      _RegistrationCreateMpinScreenState();
}

class _RegistrationCreateMpinScreenState
    extends State<RegistrationCreateMpinScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> values = Map<String, dynamic>();
  TextEditingController mpin = TextEditingController();
  TextEditingController confirmMpin = TextEditingController();
  bool obscurePin = true;
  bool obscureVerifyPin = true;
  bool checkTerms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    SizeConfig().init(context);

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

    return Scaffold(
      backgroundColor: COLOR_DAPS,
      body: Form(
        key: _formKey,
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
                      Text(APP_NAME,
                          style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 3.5,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 15)),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  // alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            REGISTER_MPIN_SCREEN_SET_PIN_TEXT,
                            textAlign: TextAlign.left,
                            style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical * 3,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15),
                          child: Text(
                            REGISTER_MPIN_SCREEN_NOTE_TEXT,
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              height: 1.5,
                              color: Colors.white.withOpacity(.87),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          obscureText: obscurePin,
                          controller: mpin,
                          onSaved: (v) {
                            values["mpin"] = v;
                          },
                          validator: (text) {
                            Pattern pattern = r"\b(\d)\1+\b";
                            Pattern specialPatt = "/^[0-9]*/";
                            RegExp regex = new RegExp(pattern);
                            if (text == null || text.isEmpty) {
                              return '${REGISTER_MPIN_SCREEN_TEXT} is required';
                            } else if (text.length != 6) {
                              return '${REGISTER_MPIN_SCREEN_TEXT} must be 6 digits';
                            } else if (regex.hasMatch(text) ||
                                text == "123456" ||
                                text == "654321" ||
                                text == "123123" ||
                                text == "4564567") {
                              return "Weak MPIN!";
                            }
                            return null;
                          },
                          inputFormatters: [
                            new FilteringTextInputFormatter.deny(
                                new RegExp('[ -.,]'))
                          ],
                          decoration: InputDecoration(
                            errorStyle:
                                TextStyle(color: COLOR_GRAY, fontSize: 12),
                            hintText:
                                "Create your ${REGISTER_MPIN_SCREEN_TEXT}",
                            counterStyle:
                                GoogleFonts.roboto(color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  setState(() => obscurePin = !obscurePin),
                              icon: obscurePin
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white.withOpacity(0.6),
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                            ),
                          ),
                        ),
                        TextFormField(
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          obscureText: obscureVerifyPin,
                          controller: confirmMpin,
                          onFieldSubmitted: (val) {
                            FocusScope.of(context).unfocus();
                            _handleRegister();
                          },
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'Confirm ${REGISTER_MPIN_SCREEN_TEXT} is required';
                            }
                            if (mpin.text != confirmMpin.text) {
                              return "${REGISTER_MPIN_SCREEN_TEXT}s must match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            hintText: "Verify ${REGISTER_MPIN_SCREEN_TEXT}",
                            counterStyle:
                                GoogleFonts.roboto(color: Colors.white),
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                  () => obscureVerifyPin = !obscureVerifyPin),
                              icon: obscureVerifyPin
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: Colors.white.withOpacity(0.6),
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: Colors.white.withOpacity(0.6),
                                    ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Checkbox(
                              checkColor: COLOR_DARK_PURPLE,
                              value: checkTerms,
                              onChanged: (val) {
                                checkTerms = val;
                                setState(() {});
                              },
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "I agree to Daps ",
                                      style: GoogleFonts.roboto(
                                        color: Colors.white,
                                        fontSize: SizeConfig.blockSizeVertical * 1.7,
                                        height: 1.5,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                          recognizer: new TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        TermsAndCondtionScreen(
                                                            type: 'terms')),
                                              );
                                            },
                                          text: 'Terms of Service ',
                                          style: GoogleFonts.roboto(
                                            color: COLOR_ORANGE,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        TextSpan(text: 'and '),
                                        TextSpan(
                                            recognizer: new TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          TermsAndCondtionScreen(
                                                              type: 'privacy')),
                                                );
                                              },
                                            text: 'Privacy Policy',
                                            style: GoogleFonts.roboto(
                                              color: COLOR_ORANGE,
                                              fontWeight: FontWeight.w500,
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: SizeConfig.blockSizeVertical * 5,
                        child: RaisedButton(
                          color: checkTerms
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                          onPressed: () {
                            if (!checkTerms) return;
                            _handleRegister();
                          },
                          child: Text('Next', style: TextStyle(color: COLOR_DAPS)),
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.toNamed('/help');
                            },
                            child: Text(
                              APP_HELP_CENTER,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    SizeConfig.blockSizeVertical * 2,
                              ),
                            ),
                          ),
                          Text(
                            store.versionNumber,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize:
                                  SizeConfig.blockSizeVertical * 2,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleRegister() async {
    bool status = _formKey.currentState.validate();
    if (status && checkTerms) {
      try {
        _formKey.currentState.save();
        store.registrant.mpin = values["mpin"];
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );
        await Future.delayed(Duration(seconds: 5));
        OverlayScreen().pop();
        Get.toNamed('/registration/registration-otp-screen');
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleOk() {
    OverlayScreen().pop();
    Get.toNamed("/login/login-mpin-screen");
  }
}
