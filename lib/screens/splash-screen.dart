import 'package:swipe/common/constants.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe/common/size.config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: Constants.backgroundColor2,
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
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: SizeConfig.screenDiagonal * .25,
                  child: Image.asset('assets/icons/curiociti-REV-VER.png'),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'From',
                          style: Constants.poppinsNormalWhite11,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Image.asset(
                          'assets/images/thingsph_logo_white.png',
                          width: 100,
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

  _initialize() async {
    // await store.initUser();

    // if (null == store.user) {
    //   await store.logout();
    //   Get.off(LoginScreen());
    // } else {
    //   if (store.onboarded) {
    //     if (store.permitted) {
    //       await store.initApp();
    //       Get.off(HomeScreen(checkUpdate: true));
    //     } else {
    //       Get.off(SetupScreen(checkUpdate: true));
    //     }
    //   } else {
    //     Get.off(OnboardingScreen(checkUpdate: true));
    //   }
    // }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
