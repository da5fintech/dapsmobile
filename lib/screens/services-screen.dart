import 'dart:io';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/promo-card.dart';

import 'package:swipe/common/widgets/amount-widget.dart';
import 'package:swipe/common/widgets/drawer-menu-widget.dart';
import 'package:swipe/common/widgets/soon-release-dialog.dart';
import 'package:swipe/common/widgets/verified-dialog.dart';
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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
    });
    return WillPopScope(
      onWillPop: () async {},
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        key: _drawerKey,
        drawer: DrawerMenuWidget(level: store.user.level),
        appBar: MainAppBarWidget(
          elevation: 0,
          onPressed: () {
            _drawerKey.currentState.openDrawer();
          },
        ),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: COLOR_ORANGE,
                        child: store.user.photoURL == null
                            ? Text(
                                store.user.getInitials(),
                                style: GoogleFonts.roboto(color: Colors.white),
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
                            style: GoogleFonts.roboto(fontSize: 14),
                          ),
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 22,
                        child: Chip(
                          padding: EdgeInsets.only(bottom: 10),
                          backgroundColor: store.user.level >= 3
                              ? COLOR_GREEN
                              : COLOR_DANGER,
                          label: Text(
                            store.user.level >= 3
                                ? SERVICES_SCREEN_VERIFIED_TEXT
                                : "UNVERIFIED",
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        SERVICES_SCREEN_BALANCE_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Text("**** *** 9870",
                      //     style: GoogleFonts.roboto(
                      //         fontSize: 12,
                      //         color: Colors.white.withOpacity(0.7))),
                      Observer(
                        builder: (_) {
                          return AmountWidget(amount: store.balance);
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                padding: EdgeInsets.only(top: 20),
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1.2,
                  crossAxisCount: 3,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 20,
                  children: [
                    ServiceButtonWidget(
                      offering: SwipeServiceOffering.CASH_IN,
                      onPressed: _handleButtonClick,
                      icon: SvgPicture.asset(
                        'assets/svg/services/cash-in.svg',
                      ),
                      text: SERVICES_SCREEN_CASH_IN_TEXT,
                    ),
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
                          'assets/svg/services/direct-send.svg'),
                      text: SERVICES_SCREEN_REMITTANCE_TEXT,
                    ),
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
                        'assets/svg/services/bank-transfer.svg',
                      ),
                      text: SERVICES_SCREEN_BANK_TRANSFER_TEXT,
                    ),
                    ServiceButtonWidget(
                      offering: SwipeServiceOffering.BUY_LOAD,
                      onPressed: _handleButtonClick,
                      // icon: Image.asset('assets/icons/services/buy-load.png'),
                      icon: SvgPicture.asset(
                        'assets/svg/services/buy-load.svg',
                      ),
                      text: SERVICES_SCREEN_BUY_LOAD_TEXT,
                    ),
                    ServiceButtonWidget(
                      offering: SwipeServiceOffering.BILLS_PAYMENT,
                      onPressed: _handleButtonClick,
                      // icon: Image.asset('assets/icons/services/pay-bills.png'),
                      icon: SvgPicture.asset(
                        'assets/svg/services/pay-bills.svg',
                      ),
                      text: SERVICES_SCREEN_PAY_BILLS_TEXT,
                    ),
                    Opacity(
                      opacity: .5,
                      child: ServiceButtonWidget(
                        offering: SwipeServiceOffering.REQUEST_MONEY,
                        onPressed: _handleButtonClick,
                        icon: SvgPicture.asset(
                          'assets/svg/services/request-money.svg',
                        ),
                        text: SERVICES_SCREEN_REQUEST_MONEY_TEXT,
                      ),
                    ),
                    Opacity(
                      opacity: .5,
                      child: ServiceButtonWidget(
                        offering: SwipeServiceOffering.PAY_QR,
                        onPressed: _handleButtonClick,
                        icon:
                            SvgPicture.asset('assets/svg/services/pay-qr.svg'),
                        text: SERVICES_SCREEN_PAY_QR_TEXT,
                      ),
                    ),
                    Opacity(
                      opacity: .5,
                      child: ServiceButtonWidget(
                        offering: SwipeServiceOffering.INSURANCE,
                        onPressed: _handleButtonClick,
                        icon: SvgPicture.asset(
                          'assets/svg/services/insurance.svg',
                        ),
                        text: SERVICES_SCREEN_INSURANCE_TEXT,
                      ),
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
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/transactions/transaction-history-screen");
              },
              child: Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, bottom: 4, top: 10),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.book,
                          color: COLOR_GREEN,
                        ),
                        Text(
                          SERVICES_SCREEN_TRANSACTION_TEXT,
                          style: GoogleFonts.roboto(
                              fontSize: 14,
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
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      SERVICES_SCREEN_ADVANTAGE_SWIPE_TEXT,
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15),
                    child: Text(
                      SERVICES_SCREEN_REASON_SWIPE_TEXT,
                      style: GoogleFonts.roboto(
                        color: COLOR_DARK_GRAY,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Container(
                    height: 140,
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
                  )
                ],
              ),
            )
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
    if(offering == SwipeServiceOffering.CASH_IN) {
      Get.toNamed("/services/cash-in");
    } else if (offering == SwipeServiceOffering.BUY_LOAD) {
      Get.toNamed("/services/buy-load/buy-load-recipient-screen");
    } else if (offering == SwipeServiceOffering.BILLS_PAYMENT) {
      Get.toNamed("/services/bills-payment/bills-payment-categories-screen");
    } else if (offering == SwipeServiceOffering.REMITTANCE) {
      Get.toNamed("/services/remittance/remittance-categories-screen");
    } else if (offering == SwipeServiceOffering.DIRECT_SEND) {
      Get.toNamed("/services/direct-send");
    } else {
      OverlayScreen().show(
        context,
        identifier: 'oncoming-update',
      );
    }
    // } else if(offering == SwipeServiceOffering.PAY_QR) {
    //   Get.toNamed("/services/pay-qr/pay-qr-screen");
    // }
  }
}
