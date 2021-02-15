import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/login-screen.dart';
import 'package:swipe/screens/setup-screen.dart';
import 'package:swipe/store/application-store.dart';

import '../main.dart';

final store = getIt<ApplicationStore>();

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // _initialize();
    SchedulerBinding.instance.addPostFrameCallback((_) => _initialize(context));
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = Constants.createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        body: Column(
          children: <Widget>[
            Expanded(
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
                            color: Constants.COLOR_DARK_PURPLE,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 15),
                      ),
                      Image.asset(
                        'assets/icons/swipe-logo.png',
                        height: height * 0.35,
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
          ],
        ),
      ),
    );
  }

  _initialize(BuildContext context) async {
    User creds = store.authService.getCurrentUser();
    if (creds != null) {
      print("creds ${creds.uid}");
      var user = await store.accountService.getAccount(creds.uid);
      if (user != null) {
        store.setUser(user);
        Get.offAllNamed("/login/login-mpin-screen");
      } else {
        Get.offAllNamed("/login");
      }

      // await store.authService.logout();

    } else {
      // store.setPermissionsGranted();
      // print("granted");
      // print(store.permissionsGranted);
      // if (store.permissionsGranted) {
      //   Get.off(LoginScreen());
      // } else {
      //   Get.off(SetupScreen());
      // }
      Get.offAllNamed("/login");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
