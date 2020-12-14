import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class PaymentVerificationScreen extends StatefulWidget {
  @override
  _PaymentVerificationScreenState createState() =>
      _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends State<PaymentVerificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildOfferingSpecificSection(SwipeServiceOffering offering) {
    if (offering == SwipeServiceOffering.BUY_LOAD) {
      return Column(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10),
            color: COLOR_DARK_PURPLE.withOpacity(.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Buy Load for",
                    style: GoogleFonts.roboto(
                        color: COLOR_DARK_PURPLE.withOpacity(.87),
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Container(
            height: 60,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("My Number"),
                Spacer(),
                Text(store.transaction.recipient),
              ],
            ),
          ),
        ],
      );
    }

    if (offering == SwipeServiceOffering.BILLS_PAYMENT) {
      BillerProduct product = store.transaction.product;
      var fields = product.fields.map((element) {
        return element.field != 'amount'
            ? Container(
                height: 60,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("${element.label}"),
                    Spacer(),
                    Text("${element.value}"),
                  ],
                ),
              )
            : Container();
      }).toList();
      var widget = Column(
        children: [
          Container(
            height: 40,
            padding: EdgeInsets.only(left: 10),
            color: COLOR_DARK_PURPLE.withOpacity(.05),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pay bills for",
                    style: GoogleFonts.roboto(
                        color: COLOR_DARK_PURPLE.withOpacity(.87),
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
        ],
      );

      widget.children.addAll(fields);
      return widget;
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height * 0.70;
    double amount = store.transactionService.getAmount(store.transaction);

    return Theme(
      data: td,
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            height: 96,
            title: "Payment",
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(10),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${store.transaction.product.name}",
                        style: GoogleFonts.roboto(
                            fontSize: 14,
                            color: Colors.white.withOpacity(.87))),
                    Text(formatter.format(amount),
                        style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: Colors.white)),
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
                  height: height,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 10),
                          color: COLOR_DARK_PURPLE.withOpacity(.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Pay with wallet",
                                  style: GoogleFonts.roboto(
                                      color: COLOR_DARK_PURPLE.withOpacity(.87),
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("SWIPE"),
                              Spacer(),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Available Balance",
                                      style: GoogleFonts.roboto(
                                          fontSize: 12,
                                          color: Colors.black.withOpacity(.60),
                                          fontWeight: FontWeight.w400)),
                                  Text(formatter.format(store.balance),
                                      style: GoogleFonts.roboto(
                                          fontSize: 14,
                                          color: COLOR_DARK_PURPLE
                                              .withOpacity(.87),
                                          fontWeight: FontWeight.w700))
                                ],
                              )
                            ],
                          ),
                        ),
                        buildOfferingSpecificSection(
                            store.transaction.offering),
                        Container(
                          height: 40,
                          padding: EdgeInsets.only(left: 10),
                          color: COLOR_DARK_PURPLE.withOpacity(.05),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("You are about to pay",
                                  style: GoogleFonts.roboto(
                                      color: COLOR_DARK_PURPLE.withOpacity(.87),
                                      fontWeight: FontWeight.w500))
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Amount Due"),
                              Spacer(),
                              Text(formatter.format(amount)),
                            ],
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Discount"),
                              Spacer(),
                              Text("No available voucher"),
                            ],
                          ),
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Divider(
                              color: COLOR_GRAY,
                              height: 2,
                            )),
                        Container(
                          height: 60,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total Amount"),
                              Spacer(),
                              Text(formatter.format(amount)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        // shape: ,
                        onPressed: () {
                          _handlePay();
                        },
                        child: Text(
                          "PAY",
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handlePay() {
    Get.toNamed('/services/payment/payment-mpin-screen');
  }
}
