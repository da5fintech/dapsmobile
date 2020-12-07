import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class PaymentConfirmationScreen extends StatefulWidget {
  @override
  _PaymentConfirmationScreenState createState() =>
      _PaymentConfirmationScreenState();
}

class _PaymentConfirmationScreenState extends State<PaymentConfirmationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            height: 170,
            title: "Reciept",
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: COLOR_GREEN,
                      size: 30,
                    ),
                    SizedBox(height: 5),
                    Text("Payment Received!",
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white.withOpacity(.87))),
                    Text(formatter.format(store.transaction.product.amount),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white)),
                    SizedBox(height: 15),
                  ],
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: COLOR_GRAY.withOpacity(.36)))),
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Transaction"),
                      Spacer(),
                      Text("Buy a Load",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.60),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: COLOR_GRAY.withOpacity(.36)))),
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Sent to"),
                      Spacer(),
                      Text("${store.transaction.recipient}",
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.60),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: COLOR_GRAY.withOpacity(.36)))),
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Amount due"),
                      Spacer(),
                      Text(formatter.format(store.transaction.product.amount),
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.60),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: COLOR_GRAY.withOpacity(.36)))),
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Date"),
                      Spacer(),
                      Text(formatter.format(store.transaction.product.amount),
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.60),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: COLOR_GRAY.withOpacity(.36)))),
                  height: 40,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Reference No."),
                      Spacer(),
                      Text(store.lastTransactionResponse.reference,
                          style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: Colors.black.withOpacity(.60),
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "Your payment is being processed. \n You will receive a text message regarding this transaction.",
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.file_download,
                                color: COLOR_DARK_PURPLE),
                            onPressed: () {}),
                        FlatButton(
                            onPressed: () {
                              _handleDone();
                            },
                            child: Text("DONE"))
                      ],
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleDone() {
    Get.toNamed('/services');
  }
}
