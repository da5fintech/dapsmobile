import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class DrawerMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      child: Drawer(
        child: Container(
          color: COLOR_DARK_PURPLE,
          child: ListView(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                  ),
                ),
              ),
              ListTile(
                leading: CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: COLOR_ORANGE,
                    child: Text('${store.user.getInitials()}',
                        style: GoogleFonts.roboto(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: Colors.white))),
                title: Text('${store.user.displayName}',
                    style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16)),
                subtitle: Text(
                  '${store.user.mobileNumber}',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 14),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 22,
                      child: Chip(
                        shape: StadiumBorder(
                            side: BorderSide(color: Colors.white)),
                        padding:
                            EdgeInsets.only(bottom: 10, left: 10, right: 10),
                        backgroundColor: COLOR_DARK_PURPLE,
                        label: Text('View Benefits',
                            style: GoogleFonts.roboto(
                                fontSize: 12, color: Colors.white)),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(vertical: 20.0),
                        child: Stack(
                          children: [
                            Divider(
                              color: COLOR_BLUE,
                              height: 20,
                              thickness: 0.5,
                              indent: 20,
                              endIndent: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 10,
                                      backgroundColor: COLOR_GREEN,
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 12),
                                    ),
                                    Text('Basic Level',
                                        style: GoogleFonts.roboto(
                                            height: 2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 10,
                                      backgroundColor: COLOR_GREEN,
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 12),
                                    ),
                                    Text('Semi Verified',
                                        style: GoogleFonts.roboto(
                                            height: 2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white))
                                  ],
                                ),
                                Column(
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 10,
                                      backgroundColor: COLOR_GREEN,
                                      child: Icon(Icons.check,
                                          color: Colors.white, size: 12),
                                    ),
                                    Text('Fully Verified',
                                        style: GoogleFonts.roboto(
                                            height: 2,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white))
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('My Links Account',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Partner Merchants',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Promos',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Voucher Pocket',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Settings',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Help',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                  onTap: () async {
                    await store.authService.logout();
                    Get.toNamed("/login");
                  },
                  visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                  leading: Icon(Icons.circle, color: Colors.white),
                  title: Transform(
                    transform: Matrix4.translationValues(-20, 0.0, 0),
                    child: Text('Log out',
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.white.withOpacity(0.5)),
                  )),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
