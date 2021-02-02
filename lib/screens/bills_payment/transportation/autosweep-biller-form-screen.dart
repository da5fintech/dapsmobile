import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class AutosweepBillerFormScreen extends StatefulWidget {
  @override
  _AutosweepBillerFormScreenState createState() =>
      _AutosweepBillerFormScreenState();
}

class _AutosweepBillerFormScreenState extends State<AutosweepBillerFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String plateNumber;
  double amount;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    double width = MediaQuery.of(context).size.width * 0.70;

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          elevation: 0,
          title: BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TITLE,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: 15.0,
                  top: 5.0,
                  left: 15.0,
                  right: 5.0,
                ),
                color: COLOR_DARK_PURPLE,
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage(
                        "assets/icons/autosweep.jpg",
                      ),
                    ),
                    Container(
                      width: width,
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TEXT,
                            style: GoogleFonts.roboto(
                              fontSize: 16.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            BILLS_PAYMENT_TRANSPORTATION_POSTED_IMMEDIATELY,
                            style: GoogleFonts.roboto(
                              fontSize: 12.0,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 25.0, right: 25.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextField(
                          onChanged: (value) {
                            plateNumber = value;
                          },
                          decoration: InputDecoration(
                            labelText: BILLS_PAYMENT_TRANSPORTATION_PLATE_NUMBER_TEXT,
                          ),
                        ),
                        TextField(
                          onChanged: (value) {
                            amount = double.parse(value);
                          },
                          decoration: InputDecoration(
                            labelText: BILLS_PAYMENT_TRANSPORTATION_AMOUNT_TEXT,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: PrimaryButtonWidget(
                    onPressed: () => {
                      _handleNext(),
                    },
                    text: BILLS_PAYMENT_NEXT_TEXT,
                  ),
                ),
              ),
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

  void _handleNext() {
    bool status = _formKey.currentState.validate();

    if (status == true) {
      store.createTransaction(SwipeServiceOffering.AUTOSWEEP, plateNumber);
      _formKey.currentState.save();

      store.setTransactionProduct(
        AutosweepProduct(plateNumber: plateNumber),
        amount,
      );

      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed to validate autosweep form.");
    }
  }
}
