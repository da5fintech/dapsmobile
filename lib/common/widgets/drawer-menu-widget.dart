import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/services/account-service.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class DrawerMenuWidget extends StatefulWidget {
  int level;

  DrawerMenuWidget({key, @required this.level = 1}) : super(key: key);

  @override
  _DrawerMenuWidgetState createState() => _DrawerMenuWidgetState();
}

class _DrawerMenuWidgetState extends State<DrawerMenuWidget> {
  List<TransactionRecordModel> transactions = [];

  @override
  void initState() {
    super.initState();
  }

  Widget isVerifiedIcon({bool isVerified, String title}) {
    return Column(
      children: [
        CircleAvatar(
          maxRadius: 10,
          backgroundColor: isVerified ? COLOR_GREEN : COLOR_DANGER,
          child: isVerified
              ? Icon(Icons.check, color: Colors.white, size: 12)
              : Icon(Icons.close, color: Colors.white, size: 12),
        ),
        Text(
          title,
          style: GoogleFonts.roboto(
              height: 2,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.white),
        )
      ],
    );
  }

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
                onTap: () {
                  Get.toNamed('/user-profile');
                },
                leading: CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: COLOR_ORANGE,
                  child: Text(
                    '${store.user.getInitials()}',
                    style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
                title: Text(
                  '${store.user.displayName}',
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                ),
                subtitle: Text(
                  '+63${store.user.mobileNumber}',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.toNamed('/user-profile/user-verification/verification');
                          },
                          child: Container(
                            height: 22,
                            child: Chip(
                              shape: StadiumBorder(
                                side: BorderSide(color: Colors.white),
                              ),
                              padding: EdgeInsets.only(
                                  bottom: 10, left: 10, right: 10),
                              backgroundColor: COLOR_DARK_PURPLE,
                              label: Text(
                                DRAWER_MENU_SCREEN_VIEW_NOW,
                                style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              Text('Swipe Points',
                                  style: GoogleFonts.roboto(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  )),
                              Observer(
                                builder: (_) => Text(
                                  store.swipePoints.toStringAsFixed(2),
                                  style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                              isVerifiedIcon(
                                  isVerified: widget.level >= 1,
                                  title: DRAWER_MENU_SCREEN_BASIC_LEVEL),
                              isVerifiedIcon(
                                  isVerified: widget.level >= 2,
                                  title: DRAWER_MENU_SCREEN_SEMI_VERIFIED),
                              isVerifiedIcon(
                                  isVerified: widget.level >= 3,
                                  title: DRAWER_MENU_SCREEN_FULLY_VERIFIED),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/links-account');
                },
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.smartphone, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_LINK_ACCOUNTS,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                onTap: () => Get.toNamed('/partner-merchants'),
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.people, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_PARTNER_MERCHANTS,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/promos');
                },
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.wallet_giftcard, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_PROMOS,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                onTap: () => Get.toNamed('/voucher-pockets'),
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.receipt, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_VOUCHER,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                onTap: () => Get.toNamed('/settings'),
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.settings, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_SETTINGS,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
              Divider(
                color: Colors.white.withOpacity(0.5),
                thickness: 0.5,
              ),
              ListTile(
                onTap: () {
                  Get.toNamed('/help');
                },
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: Icon(Icons.help, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_HELP,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
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
                leading: Icon(Icons.logout, color: Colors.white),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                  child: Text(
                    DRAWER_MENU_SCREEN_LOGOUT,
                    style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
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
