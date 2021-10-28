import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:daps/common/errors.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/common/util.dart';
import 'package:daps/screens/login/failed-login-dialog.dart';
import 'package:daps/screens/payment/wrong-mpin-dialog.dart';
import 'package:daps/screens/registration/registration-failed-dialog.dart';
import 'package:daps/services/authentication-service.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/common/widgets/primary-button.widget.dart';
import 'package:daps/common/constants.dart' as Constants;

import '../../main.dart';

final store = getIt<ApplicationStore>();

class LoginEmailScreen extends StatefulWidget {
  @override
  _LoginEmailScreenState createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  AppUtil _appUtil = AppUtil();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loginError = false;
  bool obscureText = true;

  @override
  void initState() {
    username.text = "0002";
    password.text = "4!CN3Qv8";
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
        backgroundColor: Constants.COLOR_DAPS,
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
                              color: Colors.white,
                              letterSpacing: 15),
                        ),
                        SizedBox(
                          height:  height * .25,
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
                                controller: username,
                                autofocus: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                onSaved: (v) {},
                                validator: (t) {
                                  if(t.isEmpty) {
                                    return "Please Enter your Username";
                                  }
                                  return null;
                                },
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: Constants.LOGIN_EMAIL_SCREEN_EMAIL_TEXT,
                                ),
                              ),
                              TextFormField(
                                autofocus: false,
                                controller: password,
                                style: TextStyle(color: Colors.white),
                                onFieldSubmitted: (val) {
                                  FocusScope.of(context).unfocus();
                                  _handleDapsLogin();
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
                                            color: Colors.white.withOpacity(.6))
                                        : Icon(
                                            Icons.visibility,
                                            color: Colors.white.withOpacity(.6),
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
                                    _handleDapsLogin();
                                  },
                                  text: Constants.LOGIN_EMAIL_SCREEN_LOGIN_TEXT,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 15),
                              // Row(
                              //   children: <Widget>[
                              //     Expanded(
                              //       child: Divider(
                              //         thickness: 1.5,
                              //         color: Constants.COLOR_DARK_PURPLE,
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: const EdgeInsets.only(
                              //           left: 5, right: 5),
                              //       child: Text(Constants
                              //           .LOGIN_EMAIL_SCREEN_ALTERNATE_LOGIN_TEXT,
                              //           style: GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 2, fontWeight: FontWeight.w500, color: Constants.COLOR_DARK_PURPLE)),
                              //     ),
                              //     Expanded(
                              //       child: Divider(
                              //         thickness: 1.5,
                              //         color: Constants.COLOR_DARK_PURPLE,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.only(right: 8),
                                  //   child: CircleAvatar(
                                  //     radius: SizeConfig.blockSizeVertical * 3.5,
                                  //     backgroundColor: Colors.white,
                                  //     child: CircleAvatar(
                                  //       backgroundColor: Constants.COLOR_DARK_PURPLE,
                                  //       radius: SizeConfig.blockSizeVertical * 3.5,
                                  //       child: IconButton(
                                  //         iconSize: SizeConfig.blockSizeVertical * 3,
                                  //         icon: FaIcon(
                                  //           FontAwesomeIcons.facebookF,
                                  //           color: Colors.white.withOpacity(.87),
                                  //         ),
                                  //         onPressed: () {
                                  //           _handleSSOLogin(LoginProvider.FACEBOOK);
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  // Container(
                                  //   margin: EdgeInsets.only(right: 8),
                                  //   child: CircleAvatar(
                                  //     radius: SizeConfig.blockSizeVertical * 3.5,
                                  //     backgroundColor: Colors.white,
                                  //     child: CircleAvatar(
                                  //       backgroundColor: Constants.COLOR_DARK_PURPLE,
                                  //       radius: SizeConfig.blockSizeVertical * 3.5,
                                  //       child: IconButton(
                                  //         iconSize: SizeConfig.blockSizeVertical * 3,
                                  //         icon: FaIcon(
                                  //           FontAwesomeIcons.google,
                                  //           color: Colors.white.withOpacity(.87),
                                  //         ),
                                  //         onPressed: () {
                                  //           _handleSSOLogin(LoginProvider.GOOGLE);
                                  //         },
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
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
                      child: Text(Constants.APP_HELP_CENTER, style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2)),
                    ),
                    Text(store.versionNumber, style: TextStyle(color: Colors.white, fontSize: SizeConfig.blockSizeVertical * 2)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///DAPS LOGIN
  _handleDapsLogin () async {
    bool status = _formKey.currentState.validate();
    if(!status) return null;
    try {
      loginError = false;
      setState(() {});
      modalHudLoad(context);
      UserModel user = await store.dapsAuthenticationService.dapsAuth(
        username: username.text,
        password: password.text,
      );
      var account = await store.accountService.getAccount(user.emailAddress);
      Navigator.pop(context);
      if(account == null) {
        UserModel registrant = user;
        store.registrant = registrant;
        Get.toNamed('/registration/registration-create-mpin-screen');
        return;
      }
      account.credentials = user.credentials;
      account.balance = await store.dapsAuthenticationService.balanceSyncing(user.credentials);
      await store.authService.emailLogin(email: user.emailAddress, password: password.text);
      store.setUser(account);
      Get.toNamed('/services');
    } on ApiResponseError catch (e) {
      Navigator.pop(context);
      errorModal(context, title: "D2066", message: e.message);
      loginError = true;
      setState(() {});
    } catch (e) {
      Navigator.pop(context);
      print('error $e');
      loginError = true;
    }
  }

  void _handleOk() {
    OverlayScreen().pop();
  }
}

















