import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/amount-widget.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/markdowns-views/terms-condition-screen.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class PaymentVerificationScreen extends StatefulWidget {
  @override
  _PaymentVerificationScreenState createState() =>
      _PaymentVerificationScreenState();
}

class _PaymentVerificationScreenState extends State<PaymentVerificationScreen> {
  bool hasDiscount = true;
  bool termsAndConditions = false;
  bool proceed = true;

  @override
  void initState() {
    super.initState();
  }

  Widget buildBuyLoadSection() {
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10),
          color: COLOR_DARK_PURPLE.withOpacity(.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_LOAD_FOR_TEXT,
                style: GoogleFonts.roboto(
                  color: COLOR_DARK_PURPLE.withOpacity(.87),
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 60,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_MY_NUMBER_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text(store.transaction.recipient, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildBillsPaymentSection() {
    BillerProduct product = store.transaction.product;
    var widget = Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          color: COLOR_DARK_PURPLE.withOpacity(.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_PAY_BILLS_TEXT,
                style: GoogleFonts.roboto(
                    color: COLOR_DARK_PURPLE.withOpacity(.87),
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );

    var fields = product.fields.map((element) {
      var value = product.getFieldValue(element.field);

      return element.field != 'amount'
          ? Container(
              height: 60,
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      "${element.label}",
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                      )
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: Text(
                      "$value",
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container();
    }).toList();
    var fee = Container(
      height: 60,
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              PAYMENT_VERIFICATION_SCREEN_FEE_TEXT,
              style: TextStyle(
                fontSize: SizeConfig.blockSizeVertical * 2,
              )
            ),
          ),
          Spacer(),
          Expanded(
              child: Text(
            formatter.format(product.fee),
            style: TextStyle(
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),
            textAlign: TextAlign.right,
          )),
        ],
      ),
    );

    widget.children.addAll(fields);
    widget.children.add(fee);

    return widget;
  }

  Widget buildRemittanceInstapaySection() {
    InstapayBankProduct product = store.transaction.product;
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10),
          color: COLOR_DARK_PURPLE.withOpacity(.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_SEND_MONEY_TEXT,
                style: GoogleFonts.roboto(
                  color: COLOR_DARK_PURPLE.withOpacity(.87),
                  fontWeight: FontWeight.w500,
                  fontSize: SizeConfig.blockSizeVertical * 2,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_SEND_VIA_TEXT),
              Spacer(),
              Image(
                width: 90,
                image: AssetImage("assets/icons/instapay.png"),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_ACCOUNT_NUMBER_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.accountNumber}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_RECIPIENT_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.recipientName}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_FEE_TEXT,
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)
              ),
              Spacer(),
              Text(
                formatter.format(INSTAPAY_FEE),
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRemittancePesonetSection() {
    PesonetBankProduct product = store.transaction.product;
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10),
          color: COLOR_DARK_PURPLE.withOpacity(.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_SEND_MONEY_TEXT,
                style: GoogleFonts.roboto(
                    color: COLOR_DARK_PURPLE.withOpacity(.87),
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_SEND_VIA_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Image(
                width: 90,
                image: AssetImage("assets/icons/pesonet.png"),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_ACCOUNT_NUMBER_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.accountNumber}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_RECIPIENT_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.recipientName}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_FEE_TEXT,
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)
              ),
              Spacer(),
              Text(
                formatter.format(INSTAPAY_FEE),
                style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildAutosweepSection() {
    AutosweepProduct product = store.transaction.product;

    return Column(
      children: [
        Container(
          height: 40.0,
          padding: EdgeInsets.only(
            left: 10.0,
          ),
          color: AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_COLOR.withOpacity(
            AUTOSWEEP_VERIFICATION_TEXT_CONTAINER_OPACITY,
          ),
          child: Row(
            children: [
              Text(
                AUTOSWEEP_VERIFICATION_TEXT,
                style: GoogleFonts.roboto(
                  color: AUTOSWEEP_VERIFICATION_TEXT_COLOR.withOpacity(
                    AUTOSWEEP_VERIFICATION_TEXT_COLOR_OPACITY,
                  ),
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  fontWeight: AUTOSWEEP_VERIFICATION_TEXT_FONT_WEIGHT,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: 10.0,
            right: 10.0,
          ),
          child: Column(
            children: [
              Container(
                height: 40.0,
                child: Row(
                  children: [
                    Text(AUTOSWEEP_VERIFICATION_TEXT_PAY_FOR, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                    Spacer(),
                    Text("${product.plateNumber}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                  ],
                ),
              ),
              Container(
                height: 40.0,
                child: Row(
                  children: [
                    Text(AUTOSWEEP_VERIFICATION_TEXT_FEE, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                    Spacer(),
                    Text(
                      formatter.format(AUTOSWEEP_FEE, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDirectSendSection() {
    DirectPayProduct product = store.transaction.product;
    return Column(
      children: [
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10),
          color: COLOR_DARK_PURPLE.withOpacity(.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                PAYMENT_VERIFICATION_SCREEN_SEND_MONEY_TEXT,
                style: GoogleFonts.roboto(
                    color: COLOR_DARK_PURPLE.withOpacity(.87),
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_SEND_VIA_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text(DIRECT_SEND_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2))
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(PAYMENT_VERIFICATION_SCREEN_ACCOUNT_NUMBER_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("+${product.mobileNumber}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Recipient's Name", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.name}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
        Container(
          height: 40,
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Message", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
              Spacer(),
              Text("${product.message}", style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildOfferingSpecificSection(SwipeServiceOffering offering) {
    if (offering == SwipeServiceOffering.BUY_LOAD) {
      return buildBuyLoadSection();
    }

    if (offering == SwipeServiceOffering.BILLS_PAYMENT) {
      return buildBillsPaymentSection();
    }

    if (offering == SwipeServiceOffering.REMITTANCE_INSTAPAY) {
      hasDiscount = false;
      return buildRemittanceInstapaySection();
    }

    if (offering == SwipeServiceOffering.REMITTANCE_PESONET) {
      hasDiscount = false;
      return buildRemittancePesonetSection();
    }


    if (offering == SwipeServiceOffering.AUTOSWEEP) {
      hasDiscount = false;
      return buildAutosweepSection();
    }

    if(offering == SwipeServiceOffering.DIRECT_SEND) {
      hasDiscount = false;
      return buildDirectSendSection();
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    double amount = store.transactionService.getAmount(store.transaction);
    double totalAmount =
        store.transactionService.getTotalAmount(store.transaction);

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          height: 96,
          title: PAYMENT_MPIN_SCREEN_TITLE,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "${store.transaction.product.name}",
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        color: Colors.white.withOpacity(.87),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  AmountWidget(amount: amount)
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 40.0,
                        padding: EdgeInsets.only(left: 10.0),
                        color: COLOR_DARK_PURPLE.withOpacity(.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              PAYMENT_VERIFICATION_SCREEN_PAY_WALLET_TEXT,
                              style: GoogleFonts.roboto(
                                color: COLOR_DARK_PURPLE.withOpacity(.87),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 2
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(APP_NAME, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  PAYMENT_VERIFICATION_SCREEN_BALANCE_TEXT,
                                  style: GoogleFonts.roboto(
                                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                                    color: Colors.black.withOpacity(.60),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  formatter.format(store.balance),
                                  style: GoogleFonts.roboto(
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    color: COLOR_DARK_PURPLE.withOpacity(.87),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      buildOfferingSpecificSection(store.transaction.offering),
                      Container(
                        height: 40,
                        padding: EdgeInsets.only(left: 10),
                        color: COLOR_DARK_PURPLE.withOpacity(.05),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              PAYMENT_VERIFICATION_SCREEN_ABOUT_TO_PAY_TEXT,
                              style: GoogleFonts.roboto(
                                color: COLOR_DARK_PURPLE.withOpacity(.87),
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(PAYMENT_VERIFICATION_SCREEN_DUE_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                            Spacer(),
                            Text(formatter.format(amount), style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                          ],
                        ),
                      ),
                      hasDiscount
                          ? Container(
                              height: 60,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      PAYMENT_VERIFICATION_SCREEN_DISCOUNT_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                                  Spacer(),
                                  Text(
                                      PAYMENT_VERIFICATION_SCREEN_VOUCHER_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                                ],
                              ),
                            )
                          : Container(),
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Divider(
                          color: COLOR_GRAY,
                          height: 2,
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(PAYMENT_VERIFICATION_SCREEN_TOTAL_AMOUNT_TEXT, style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                            Spacer(),
                            Text(
                              formatter.format(totalAmount) , style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
                child: Row(
                  children: [
                    Checkbox(
                      value: termsAndConditions,
                      onChanged: (val) =>
                          setState(() {
                            termsAndConditions = val;
                            proceed = true;
                          }),
                    ),
                    Text(
                      PAYMENT_VERIFICATION_AGREE_TERMS_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 1.7,
                        fontWeight: FontWeight.w400,
                        color: COLOR_DARK_GRAY,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => TermsAndCondtionScreen(type: 'terms')),
                        );
                      },
                      child: Text(
                        PAYMENT_VERIFICATION_TERMS_CONDITION_TEXT,
                        style: GoogleFonts.roboto(
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            fontWeight: FontWeight.w500,
                            color: COLOR_GREEN),
                      )
                    ),
                  ],
                ),
              ),
              if (!proceed) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: Text(
                    PAYMENT_VERIFICATION_WARNING_TEXT,
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: COLOR_DANGER,
                    ),
                  ),
                ),
              ],
              Padding(
                padding:
                    const EdgeInsets.only(right: 20.0, left: 20, bottom: 10),
                child: Text(
                  PAYMENT_VERIFICATION_NOTE_TEXT,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      color: COLOR_DARK_GRAY),
                ),
              ),
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
                      PAYMENT_VERIFICATION_SCREEN_PAY_TEXT,
                    ),
                  ),
                ),
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

  void _handlePay() {
    termsAndConditions
        ? Get.toNamed('/services/payment/payment-mpin-screen')
        : setState(() => proceed = false);
  }
}
