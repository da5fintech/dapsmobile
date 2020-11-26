import "package:flutter/material.dart";

import 'package:swipe/common/constants.dart' as Constants;
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';

class LoginScreen extends StatefulWidget {
  final bool checkUpdate;
  LoginScreen({this.checkUpdate = false});
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _appleSignInAllowed = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () => appUtil.onWillExit(context),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Constants.backgroundColor2,
        body: Container(
          decoration: BoxDecoration(
            // color: getBlack1818(),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Constants.themeRed,
                Constants.themeRed2,
                Constants.themeBlue,
                Constants.themeBlue
              ],
            ),
          ),
          child: Column(
            children: <Widget>[
              Expanded(
                // flex: 3,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset('assets/icons/curiociti-REV-VER.png',
                      width: SizeConfig.screenDiagonal * .25),
                ),
              ),
              _isLoading
                  ? Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 50),
                          child: Text('LOADING...',
                              style: Constants.poppinsW500White18),
                        ),
                      ),
                    )
                  : Expanded(
                      // flex: 2,
                      child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(),

                          // Padding(
                          //   padding: EdgeInsets.all(10),
                          //   child: SignInButton(
                          //     Buttons.Facebook,
                          //     padding: EdgeInsets.all(5),
                          //     mini: true,
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(25.0),
                          //     ),
                          //     onPressed: () => _login(LoginProvider.FACEBOOK),
                          //   ),
                          // ),

                          Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: RichText(
                              text: TextSpan(
                                style: Constants.poppinsNormalBlack11
                                    .copyWith(color: Colors.white70),
                                children: [
                                  TextSpan(
                                    text: 'By continuing you accept the ',
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                        ],
                      ),
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
