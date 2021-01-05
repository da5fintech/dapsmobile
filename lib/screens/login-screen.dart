import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/services/authentication-service.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:swipe/common/widgets/secondary-button.widget.dart';
import 'package:swipe/common/constants.dart' as Constants;

import '../main.dart';

final store = getIt<ApplicationStore>();

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: Constants.backgroundColor2,
      body: Container(
        child: Column(
          children: <Widget>[
            Expanded(
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: SecondaryButtonWidget(
                              onPressed: () {
                                _handleLogin();
                              },
                              text: "LOG IN",
                            )),

                        SizedBox(
                            width: double.infinity,
                            child: PrimaryButtonWidget(
                              onPressed: () {
                                _handleRegister();
                              },
                              text: "REGISTER",
                            )),

                        // OutlineButton(
                        //   child: Text("REGISTER",
                        //       style: Constants.primaryButtonText),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(children: <Widget>[
                          Expanded(
                              child: Divider(
                            color: Colors.white.withOpacity(.87),
                          )),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text("OR SIGNUP USING"),
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
                                  backgroundColor: Constants.COLOR_DARK_PURPLE,
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
                                  backgroundColor: Constants.COLOR_DARK_PURPLE,
                                  radius: 25,
                                  child: IconButton(
                                      iconSize: 30,
                                      icon: FaIcon(
                                        FontAwesomeIcons.google,
                                        color: Colors.white.withOpacity(.87),
                                      ),
                                      onPressed: () {
                                        _handleSignup(LoginProvider.GOOGLE);
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

                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Help Center"),
                            Text("v1.1.1"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleLogin() {
    Get.offAllNamed("/services");
  }

  _handleRegister() {
    Get.toNamed("/registration");
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSignup(LoginProvider provider) async {
    try {
      var res = await store.authService.login(provider);
      var user = await store.accountService.findOrCreate(res.uid, res.email);
      print("user ${user.toMap()}");
      store.setUser(user);
      Get.offAllNamed("/services");
    } catch (e) {}
  }
}
