import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/services/authentication-service.dart';

class SettingsScreen extends StatelessWidget {
  AuthenticationService auth = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'swipe-dialog': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: 'Ooops!',
          contentMessage: SETTINGS_SCREEN_BIOMETRIC_NOT_AVAILABLE,
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      )
    });

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_TITLE,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: ListView(
            children: [
              ListTile(
                onTap: () {
                  Get.toNamed('/settings/change-swipe-mpin/swipe-mpin-screen');
                },
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                title: Text(
                  SETTINGS_SCREEN_CHANGE_MPIN_TEXT,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              Divider(thickness: 0.5),
              ListTile(
                onTap: () async {
                  bool isAvailable = await auth.isBiometricAvailable();
                  if (isAvailable)
                    Get.toNamed(
                        '/settings/biometric/biometric-fingerprint-screen');
                  else
                    OverlayScreen().show(context, identifier: 'swipe-dialog');
                },
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                title: Text(
                  SETTINGS_SCREEN_BIOMETRIC_LOGIN_TEXT,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
              ),
              Divider(thickness: 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
