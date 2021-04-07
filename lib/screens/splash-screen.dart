import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:package_info/package_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe/common/constants.dart' as Constants;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/screens/login-screen.dart';
import 'package:swipe/screens/setup-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:url_launcher/url_launcher.dart';

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

    OverlayScreen().saveScreens({
      'update-dialog': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: 'IMPORTANT UPDATE!',
          contentMessage: "In order to enjoy and secured experience Please UPDATE to the latest version of our app now!",
          cancelBtn: true,
          onOk: () {
            OverlayScreen().pop();
            if(Platform.isAndroid) {
              launch("market://details?id=" + 'ph.kabootek.swipeapp');
              userLogin();
            } else {
              ///open ios app store here
              userLogin();
            }
          },
          cancel: () {
            userLogin();
          },
        )
      )
    });

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
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Map<Permission, PermissionStatus> statuses = await [
      Permission.contacts,
      Permission.storage,
      Permission.location,
      Permission.camera,
      Permission.microphone,
    ].request();

    store.setVersionNumber(packageInfo.version);
    String latestVersion = await store.accountService.getLatestAppVersion();
    if(packageInfo.version != latestVersion) {
      OverlayScreen().show(
        context,
        identifier: 'update-dialog',
      );
    } else {
      userLogin();
    }

  }

  void userLogin () async {
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
      store.setPermissionsGranted();
      print("granted");
      print(store.permissionsGranted);
      if (store.permissionsGranted) {
        Get.off(LoginScreen());
      } else {
        Get.off(SetupScreen());
      }
      Get.offAllNamed("/login");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
