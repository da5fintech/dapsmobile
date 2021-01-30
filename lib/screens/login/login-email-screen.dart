import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/payment/wrong-mpin-dialog.dart';
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

    OverlayScreen().saveScreens({
      'wrong-mpin': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: WrongMpinDialog(
            onOk: () {
              _handleOk();
            },
          )),
    });

    return Scaffold(
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
                        Text('SWIPE',
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 15)),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 40, right: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                            controller: email,
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (v) {},
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'email is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: "Email",
                            ),
                          ),
                          TextFormField(
                            controller: password,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: obscureText,
                            onSaved: (v) {},
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                suffixIcon: IconButton(
                                    onPressed: () => setState(
                                        () => obscureText = !obscureText),
                                    icon: obscureText
                                        ? Icon(Icons.visibility_off,
                                            color: Colors.white.withOpacity(.6))
                                        : Icon(Icons.visibility,
                                            color:
                                                Colors.white.withOpacity(.6)))),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          loginError ? Text("Login error") : Container(),
                          SizedBox(
                              width: double.infinity,
                              child: PrimaryButtonWidget(
                                onPressed: () {
                                  _handleLogin();
                                },
                                text: "LOG IN",
                              )),
                          Row(children: <Widget>[
                            Expanded(
                                child: Divider(
                              color: Colors.white.withOpacity(.87),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, top: 15),
                              child: Text("OR LOGIN USING"),
                            ),
                            Expanded(
                                child: Divider(
                                    color: Colors.white.withOpacity(.87))),
                          ]),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Constants.COLOR_DARK_PURPLE,
                                    radius: 25,
                                    child: IconButton(
                                        iconSize: 30,
                                        icon: FaIcon(
                                          FontAwesomeIcons.facebookF,
                                          color: Colors.white.withOpacity(.87),
                                        ),
                                        onPressed: () {}),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 8),
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    backgroundColor:
                                        Constants.COLOR_DARK_PURPLE,
                                    radius: 25,
                                    child: IconButton(
                                        iconSize: 30,
                                        icon: FaIcon(
                                          FontAwesomeIcons.google,
                                          color: Colors.white.withOpacity(.87),
                                        ),
                                        onPressed: () {
                                          _handleSSOLogin(LoginProvider.GOOGLE);
                                        }),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                radius: 26,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Constants.COLOR_DARK_PURPLE,
                                  radius: 25,
                                  child: IconButton(
                                      iconSize: 30,
                                      icon: FaIcon(
                                        FontAwesomeIcons.linkedinIn,
                                        color: Colors.white.withOpacity(.87),
                                      ),
                                      onPressed: () {}),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // OutlineButton(
                      //   child: Text("REGISTER",
                      //       style: Constants.primaryButtonText),
                      // ),
                    ],
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Help Center"),
                  Text("v1.1.1"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleLogin() async {
    try {
      loginError = false;
      setState(() {});
      var user = await store.authService
          .emailLogin(email: email.text, password: password.text);
      print("user logged in");
      var account = await store.accountService.getAccount(user.uid);
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

  void _handleOk() {
    OverlayScreen().pop();
  }

  void _handleSSOLogin(provider) async {
    try {
      loginError = false;
      setState(() {});
      var user = await store.authService.login(provider);
      var account = await store.accountService.getAccount(user.uid);
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
