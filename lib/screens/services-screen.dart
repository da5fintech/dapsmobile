import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

import 'package:swipe/common/widgets/amount-widget.dart';
import 'package:swipe/common/widgets/drawer-menu-widget.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

    return Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        key: _drawerKey,
        drawer: DrawerMenuWidget(),
        appBar: MainAppBarWidget(
          elevation: 0,
          onPressed: () {
            _drawerKey.currentState.openDrawer();
          },
        ),
        body: Column(
          children: [
            Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: COLOR_ORANGE,
                            child: store.user.photoURL == null
                                ? Text(
                                    store.user.getInitials(),
                                    style:
                                        GoogleFonts.roboto(color: Colors.white),
                                  )
                                : ClipOval(
                                    child: Image.network(store.user.photoURL))),
                        Container(
                            margin: EdgeInsets.only(left: 10),
                            child: Text(store.user.displayName,
                                style: GoogleFonts.roboto(fontSize: 14))),
                        Spacer(),
                        Container(
                          height: 22,
                          child: Chip(
                            padding: EdgeInsets.only(bottom: 10),
                            backgroundColor: COLOR_GREEN,
                            label: Text('VERIFIED',
                                style: GoogleFonts.roboto(
                                    fontSize: 12, color: Colors.white)),
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
                        Text("Available balance",
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7)))
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("**** *** 9870",
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7))),
                        Observer(builder: (_) {
                          return AmountWidget(amount: store.balance);
                        })
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                )),
            Container(
                padding: EdgeInsets.all(25),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.CASH_IN,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage("assets/icons/services/cash-in.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Cash In",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.BUY_LOAD,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage("assets/icons/services/buy-load.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Buy Load",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.PAY_QR,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage("assets/icons/services/pay-qr.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Pay QR",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.REMITTANCE,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage("assets/icons/services/remittance.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Remittance",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.BILLS_PAYMENT,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage("assets/icons/services/pay-bills.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Pay Bills",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.INSURANCE,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage("assets/icons/services/insurance.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Insurance",
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.BANK_TRANSFER,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage(
                                  "assets/icons/services/bank-transfer.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Bank Transfer",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.REQUEST_MONEY,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage(
                                  "assets/icons/services/request-money.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "Request Money",
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ServiceButtonWidget(
                          offering: SwipeServiceOffering.MORE,
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                              AssetImage("assets/icons/services/more.png"),
                              color: COLOR_DARK_PURPLE),
                          text: "More",
                        ),
                      ],
                    )
                  ],
                )),
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
                          "Transaction History",
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
            Expanded(
                child: Container(
              color: Colors.white,
              child: Row(
                children: [Text("Helo")],
              ),
            ))
          ],
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleButtonClick(SwipeServiceOffering offering) {
    if (offering == SwipeServiceOffering.BUY_LOAD) {
      Get.toNamed("/services/buy-load/buy-load-recipient-screen");
    } else if (offering == SwipeServiceOffering.BILLS_PAYMENT) {
      Get.toNamed("/services/bills-payment/bills-payment-categories-screen");
    } else if (offering == SwipeServiceOffering.REMITTANCE) {
      Get.toNamed("/services/remittance/remittance-categories-screen");
    }
  }
}
