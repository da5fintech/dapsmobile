import 'dart:io';
import 'package:flavor/flavor.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/close-dialog.dart';
import 'package:swipe/common/widgets/notification-drawer.dart';
import 'package:swipe/common/widgets/promo-card.dart';

import 'package:swipe/common/widgets/amount-widget.dart';
import 'package:swipe/common/widgets/drawer-menu-widget.dart';
import 'package:swipe/common/widgets/soon-release-dialog.dart';
import 'package:swipe/common/widgets/verified-dialog.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/screens/direct-send/direct-send-form-screen.dart';
import 'package:swipe/services/account-service.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/main-app-bar.widget.dart';
import 'package:swipe/common/widgets/service-button.dart';

import '../main.dart';

final store = getIt<ApplicationStore>();

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  AppUtil _appUtil = AppUtil();

  @override
  void initState() {
    super.initState();
    getNotifications();
  }

  Future<void> getNotifications () async {
    store.notifications = await store.requestMoneyService.getRequest(store.user);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    double height = queryData.size.height;
    SizeConfig().init(context);

    OverlayScreen().saveScreens({
      'oncoming-update': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SoonReleaseDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
      'unverified': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: VerifiedDialog(
          onOk: () {
            OverlayScreen().pop();
            Get.toNamed('/user-profile/user-verification/verification');
          },
        ),
      ),
      'close-dialog': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: CloseDialog(
          onOk: () {
            OverlayScreen().pop();
            SystemNavigator.pop();
          },
        ),
      ),
    });
    return WillPopScope(
      onWillPop: () async {
        if(_drawerKey.currentState.isDrawerOpen || _drawerKey.currentState.isEndDrawerOpen) {
          if(_drawerKey.currentState.isEndDrawerOpen) {
            store.notifications = await store.requestMoneyService.isNotificationSeen(store.user, store.notifications);
            setState(() {});
          }
          Navigator.of(context).pop();
        } else {
          OverlayScreen().show(
            context,
            identifier: 'close-dialog',
          );
        }
      },
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        key: _drawerKey,
        drawer: DrawerMenuWidget(level: store.user.level),
        endDrawer: NotificationDrawer(
          notifications: store.notifications,
          directSend: (notification) {
            if (store.user.level >= 2) {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DirectSendFormScreen(notification: notification))
              );
            } else {
              Navigator.pop(context);
              OverlayScreen().show(
                context,
                identifier: 'unverified',
              );
            }
          },
          close: () async {
            store.notifications = await store.requestMoneyService.isNotificationSeen(store.user, store.notifications);
            setState(() {});
            Navigator.pop(context);
          }
              
        ),
        appBar: MainAppBarWidget(
          queryData: queryData.devicePixelRatio,
          elevation: 0,
          onPressed: (val) {
            if(val == 'drawer') {
              _drawerKey.currentState.openDrawer();
            } else {
              _drawerKey.currentState.openEndDrawer();
            }
          },
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: SizeConfig.blockSizeVertical * 3,
                          backgroundColor: COLOR_ORANGE,
                          child: store.user.photoURL == null
                              ? Text(
                                  store.user.getInitials(),
                                  style:
                                      GoogleFonts.roboto(color: Colors.white),
                                )
                              : ClipOval(
                                  child: Image.network(store.user.photoURL),
                                ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Observer(
                            builder: (_) => Text(
                              store.user.displayName,
                              style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Spacer(),
                        Container(
                            height: SizeConfig.blockSizeVertical * 3,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: store.user.level >= 3
                                    ? null
                                    : COLOR_DANGER,
                                border: store.user.level >= 3 ?  Border.all(color: Colors.white) : null,
                                borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Center(
                              child: Text(
                                store.user.level >= 3
                                    ? SERVICES_SCREEN_VERIFIED_TEXT
                                    : "GET VERIFIED",
                                style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 1.3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          SERVICES_SCREEN_BALANCE_TEXT,
                          style: GoogleFonts.roboto(
                            fontSize: SizeConfig.blockSizeVertical * 1.5,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "**** *** ${_appUtil.formatUserPhoneNumber(store.user.mobileNumber)}",
                          style: GoogleFonts.roboto(
                            fontSize: SizeConfig.blockSizeVertical * 2,
                            color: Colors.white.withOpacity(0.7),
                          ),
                        ),
                        Observer(
                          builder: (_) {
                            return Row(
                              children: [
                                AmountWidget(amount: store.balance),
                                SizedBox(width: 5),
                                InkWell(
                                  onTap: () {
                                    Get.toNamed("/services/cash-in");
                                  },
                                  child: Icon(Icons.add_circle,
                                      size: queryData.devicePixelRatio * 12,
                                      color: Colors.white),
                                )
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1.5,
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                color: Colors.white,
                child: Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: queryData.size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.CASH_IN,
                              onPressed: _handleButtonClick,
                              icon: SvgPicture.asset(
                                'assets/svg2/ICONS_CASH_IN.svg',
                              ),
                              text: SERVICES_SCREEN_CASH_IN_TEXT,
                            ),
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.BUY_LOAD,
                              onPressed: _handleButtonClick,
                              // icon: Image.asset('assets/icons/services/buy-load.png'),
                              icon: SvgPicture.asset(
                                'assets/svg2/ICONS_BUY_LOAD.svg',
                              ),
                              text: SERVICES_SCREEN_BUY_LOAD_TEXT,
                            ),
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.PAY_QR,
                              onPressed: _handleButtonClick,
                              icon: SvgPicture.asset(
                                  'assets/svg2/ICONS_SCAN_QR.svg'),
                              text: SERVICES_SCREEN_PAY_QR_TEXT,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        color: Colors.white,
                        width: queryData.size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceButtonWidget(
                              // offering: SwipeServiceOffering.REMITTANCE,
                              offering: SwipeServiceOffering.DIRECT_SEND,
                              onPressed: (offering) {
                                if (store.user.level >= 2) {
                                  _handleButtonClick(offering);
                                  return null;
                                }
                                OverlayScreen().show(
                                  context,
                                  identifier: 'unverified',
                                );
                              },
                              // icon: Image.asset('assets/icons/services/remittance.png'),
                              icon: SvgPicture.asset(
                                  'assets/svg2/ICONS_DIRECT_SEND.svg'),
                              text: SERVICES_SCREEN_REMITTANCE_TEXT,
                            ),
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.BILLS_PAYMENT,
                              onPressed: _handleButtonClick,
                              // icon: Image.asset('assets/icons/services/pay-bills.png'),
                              icon: SvgPicture.asset(
                                'assets/svg2/ICONS_BILLS_PAYMENT.svg',
                              ),
                              text: SERVICES_SCREEN_PAY_BILLS_TEXT,
                            ),
                            Opacity(
                              opacity: .5,
                              child: ServiceButtonWidget(
                                offering: SwipeServiceOffering.INSURANCE,
                                onPressed: _handleButtonClick,
                                icon: SvgPicture.asset(
                                  'assets/svg2/ICONS_INSURANCE.svg',
                                ),
                                text: SERVICES_SCREEN_INSURANCE_TEXT,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        width: queryData.size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.REMITTANCE,
                              onPressed: (offering) {
                                if (store.user.level >= 2) {
                                  _handleButtonClick(offering);
                                  return null;
                                }
                                OverlayScreen().show(
                                  context,
                                  identifier: 'unverified',
                                );
                              },
                              icon: SvgPicture.asset(
                                'assets/svg2/ICONS_BANK.svg',
                              ),
                              text: SERVICES_SCREEN_BANK_TRANSFER_TEXT,
                            ),
                            ServiceButtonWidget(
                              offering: SwipeServiceOffering.REQUEST_MONEY,
                              onPressed: _handleButtonClick,
                              icon: SvgPicture.asset(
                                'assets/svg2/ICONS_SEND_AND_RECEIVE.svg',
                              ),
                              text: SERVICES_SCREEN_REQUEST_MONEY_TEXT,
                            ),
                            Opacity(
                              opacity: .5,
                              child: ServiceButtonWidget(
                                offering: SwipeServiceOffering.MORE,
                                onPressed: _handleButtonClick,
                                icon: SvgPicture.asset(
                                  'assets/svg/services/more.svg',
                                ),
                                text: SERVICES_SCREEN_MORE_TEXT,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Container(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed("/transactions/transaction-history-screen");
                      },
                      child: Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.book,
                                  color: COLOR_GREEN,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  SERVICES_SCREEN_TRANSACTION_TEXT,
                                  style: GoogleFonts.roboto(
                                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                                      color: Colors.black.withOpacity(.87)),
                                ),
                              ],
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeVertical * 1,
                      child: Container(
                        color: COLOR_LIGHT_PURPLE,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 2),
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 2, left: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                SERVICES_SCREEN_ADVANTAGE_DAPS_TEXT,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 2,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 2, left: SizeConfig.blockSizeVertical * 2),
                              child: Text(
                                SERVICES_SCREEN_REASON_SWIPE_TEXT,
                                style: GoogleFonts.roboto(
                                  color: COLOR_DARK_GRAY,
                                  fontSize: 2 * SizeConfig.blockSizeVertical,
                                ),
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    PromoCard(
                                      iconPath: 'assets/svg/promos/undraw_wallet.svg',
                                      title: PROMOS_SCREEN_TITLE_DO_MORE_TEXT,
                                      subTitle: PROMOS_SCREEN_TITLE_EXTENDS_TEXT,
                                    ),
                                    PromoCard(
                                      iconPath: 'assets/svg/promos/undraw_savings.svg',
                                      title: PROMOS_SCREEN_TITLE_SAVE,
                                      subTitle: PROMOS_SCREEN_TITLE_ANNUM,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleButtonClick(SwipeServiceOffering offering) async {
    if (offering == SwipeServiceOffering.CASH_IN) {
      Get.toNamed("/services/cash-in");
    } else if (offering == SwipeServiceOffering.BUY_LOAD) {
      Get.toNamed("/services/buy-load/buy-load-recipient-screen");
    } else if (offering == SwipeServiceOffering.BILLS_PAYMENT) {
      Get.toNamed("/services/bills-payment/bills-payment-categories-screen");
    } else if (offering == SwipeServiceOffering.REMITTANCE) {
      Get.toNamed("/services/remittance/remittance-categories-screen");
    } else if (offering == SwipeServiceOffering.DIRECT_SEND) {
      Get.toNamed("/services/direct-send");
    } else if (offering == SwipeServiceOffering.REQUEST_MONEY) {
      Get.toNamed('/services/request-money');
    } else if(offering == SwipeServiceOffering.PAY_QR) {
      Get.toNamed("/services/pay-qr/pay-qr-screen");
    } else {
      OverlayScreen().show(
        context,
        identifier: 'oncoming-update',
      );
    }
  }
}
