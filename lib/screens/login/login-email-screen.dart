import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/screens/login/failed-login-dialog.dart';
import 'package:swipe/screens/payment/wrong-mpin-dialog.dart';
import 'package:swipe/screens/registration/registration-failed-dialog.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:swipe/common/constants.dart' as Constants;

import '../../main.dart';

final store = getIt<ApplicationStore>();

class LoginEmailScreen extends StatefulWidget {
  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  AppUtil _appUtil = AppUtil();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loginError = false;
  bool obscureText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = Constants.createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Constants.COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text(
              "Loading...",
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
      'wrong-mpin': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: WrongMpinDialog(
          onOk: () {
            _handleOk();
          },
        ),
      ),
      'failed-login': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: FailedLoginDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        body: Container(
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
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Constants.COLOR_DARK_PURPLE,
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: email,
                                autofocus: true,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (v) {},
                                validator: _appUtil.validateEmail,
                                decoration: InputDecoration(
                                  hintText: Constants.LOGIN_EMAIL_SCREEN_EMAIL_TEXT,
                                ),
                              ),
                              TextFormField(
                                autofocus: true,
                                controller: password,
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).unfocus();
                                  _handleLogin();
                                },
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: obscureText,
                                onSaved: (v) {},
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '${Constants.LOGIN_EMAIL_SCREEN_PASSWORD_TEXT} is required';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText:
                                      Constants.LOGIN_EMAIL_SCREEN_PASSWORD_TEXT,
                                  suffixIcon: IconButton(
                                    onPressed: () =>
                                        setState(() => obscureText = !obscureText),
                                    icon: obscureText
                                        ? Icon(Icons.visibility_off,
                                            color: Constants.COLOR_DARK_GRAY.withOpacity(.6))
                                        : Icon(
                                            Icons.visibility,
                                            color: Constants.COLOR_DARK_GRAY.withOpacity(.6),
                                          ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              // loginError
                              //     ? Text(Constants
                              //         .LOGIN_EMAIL_SCREEN_FAILED_ATTEMPT_TEXT)
                              //     : Container(),
                              SizedBox(
                                width: double.infinity,
                                child: PrimaryButtonWidget(
                                  onPressed: () {
                                    _handleLogin();
                                  },
                                  text: Constants.LOGIN_EMAIL_SCREEN_LOGIN_TEXT,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Divider(
                                      thickness: 1.5,
                                      color: Constants.COLOR_DARK_PURPLE,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 5, right: 5),
                                    child: Text(Constants
                                        .LOGIN_EMAIL_SCREEN_ALTERNATE_LOGIN_TEXT,
                                        style: GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 2, fontWeight: FontWeight.w500, color: Constants.COLOR_DARK_PURPLE)),
                                  ),
                                  Expanded(
                                    child: Divider(
                                      thickness: 1.5,
                                      color: Constants.COLOR_DARK_PURPLE,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      radius: SizeConfig.blockSizeVertical * 3.5,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundColor: Constants.COLOR_DARK_PURPLE,
                                        radius: SizeConfig.blockSizeVertical * 3.5,
                                        child: IconButton(
                                          iconSize: SizeConfig.blockSizeVertical * 3,
                                          icon: FaIcon(
                                            FontAwesomeIcons.facebookF,
                                            color: Colors.white.withOpacity(.87),
                                          ),
                                          onPressed: () {
                                            _handleSSOLogin(LoginProvider.FACEBOOK);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 8),
                                    child: CircleAvatar(
                                      radius: SizeConfig.blockSizeVertical * 3.5,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        backgroundColor: Constants.COLOR_DARK_PURPLE,
                                        radius: SizeConfig.blockSizeVertical * 3.5,
                                        child: IconButton(
                                          iconSize: SizeConfig.blockSizeVertical * 3,
                                          icon: FaIcon(
                                            FontAwesomeIcons.google,
                                            color: Colors.white.withOpacity(.87),
                                          ),
                                          onPressed: () {
                                            _handleSSOLogin(LoginProvider.GOOGLE);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  // CircleAvatar(
                                  //   radius: SizeConfig.blockSizeVertical * 3.5,
                                  //   backgroundColor: Colors.white,
                                  //   child: CircleAvatar(
                                  //     backgroundColor: Constants.COLOR_DARK_PURPLE,
                                  //     radius: SizeConfig.blockSizeVertical * 3.5,
                                  //     child: IconButton(
                                  //       iconSize: SizeConfig.blockSizeVertical * 3,
                                  //       icon: FaIcon(
                                  //         FontAwesomeIcons.linkedinIn,
                                  //         color: Colors.white.withOpacity(.87),
                                  //       ),
                                  //       onPressed: () {},
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        // OutlineButton(
                        //   child: Text("REGISTER",
                        //       style: Constants.primaryButtonText),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
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
    );
  }

  _handleLogin() async {
    bool status = _formKey.currentState.validate();
    if (!status) return null;
    try {
      loginError = false;
      setState(() {});
      OverlayScreen().show(
        context,
        identifier: 'progress',
      );
      var user = await store.authService
          .emailLogin(email: email.text, password: password.text);
      print("user logged in");
      var account = await store.accountService.getAccount(user.uid);
      if (account == null) {
        throw AuthenticationError(message: "Account not found");
      }
      OverlayScreen().pop();
      store.setUser(account);
      Get.toNamed("/services");
    } catch (e) {
      loginError = true;
      OverlayScreen().pop();
      OverlayScreen().show(
        context,
        identifier: 'failed-login',
      );
      setState(() {});
    }
  }

  void _handleOk() {
    OverlayScreen().pop();
  }

  void _handleSSOLogin(provider) async {
    try {
      print(provider);
      setState(() {});
      var user = await store.authService.login(provider);
      var account = await store.accountService.getAccount(user.id);
      if (account == null) {
        throw AuthenticationError(message: "Account not found");
      }
      store.setUser(account);
      Get.toNamed("/services");
    } catch (e) {
      loginError = true;
      setState(() {});
    }
  }
}
