import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/amount-widget.dart';
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

    double amount = store.transactionService.getAmount(store.transaction);
    double totalAmount =
        store.transactionService.getTotalAmount(store.transaction);
    double fee = store.transactionService.getFee(store.transaction);
    String recipient = store.transactionService.getRecipient(store.transaction);
    String transactionType =
        store.transactionService.getTransactionType(store.transaction);
    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          height: 170,
          title: PAYMENT_CONFIRMATION_SCREEN_TITLE_TEXT,
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
                  Text(
                    PAYMENT_CONFIRMATION_SCREEN_RECEIVED_TEXT,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white.withOpacity(.87),
                    ),
                  ),
                  AmountWidget(
                    amount: totalAmount,
                  ),
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
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_TRANSACTION_TEXT),
                    Spacer(),
                    Text(
                      transactionType,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_SENT_TEXT),
                    Spacer(),
                    Text(
                      "$recipient",
                      textAlign: TextAlign.right,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_AMOUNT_TEXT),
                    Spacer(),
                    Text(
                      formatter.format(amount),
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_FEE_TEXT),
                    Spacer(),
                    Text(
                      formatter.format(fee),
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_DUE_TEXT),
                    Spacer(),
                    Text(
                      formatter.format(totalAmount),
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_DATE_TEXT),
                    Spacer(),
                    Text(
                      DateFormat.yMMMMEEEEd().format(DateTime.now()),
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: COLOR_GRAY.withOpacity(.36),
                    ),
                  ),
                ),
                height: 40,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(PAYMENT_CONFIRMATION_SCREEN_REF_TEXT),
                    Spacer(),
                    Text(
                      store.lastTransactionResponse.reference,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black.withOpacity(.60),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Column(
                children: [
                  Text(
                    PAYMENT_CONFIRMATION_SCREEN_PROCESSED_TEXT,
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
                        icon:
                            Icon(Icons.file_download, color: COLOR_DARK_PURPLE),
                        onPressed: () {},
                      ),
                      FlatButton(
                        onPressed: () {
                          _handleDone();
                        },
                        child: Text(PAYMENT_CONFIRMATION_SCREEN_DONE_TEXT),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
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
