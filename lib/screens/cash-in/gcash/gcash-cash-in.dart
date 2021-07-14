import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/cash-in/gcash/success-dialog.dart';
import 'package:swipe/screens/payment/processing-failed-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class GcashIn extends StatefulWidget {
  @override
  _GCashInState createState() => _GCashInState();
}

class _GCashInState extends State<GcashIn> {
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'processing-failed': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: ProcessingFailedDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
      'success-dialog': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SuccessDialog(
          onOk: () {
            OverlayScreen().pop();
            Get.toNamed('/services');
          },
        ),
      )
    });
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: mobileNumber,
              keyboardType: TextInputType.phone,
              validator: (t) {
                if (t.isEmpty) {
                  return "Mobile Number is required";
                }
                return null;
              },
              decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                hintText: "904033902",
                errorStyle:
                    TextStyle(color: COLOR_DANGER, fontSize: 12, height: 0.3),
                labelText: REGISTER_SCREEN_MOBIILE_TEXT,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                prefix: Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.white,
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Text(
                    '+63',
                    style: GoogleFonts.roboto(color: Colors.black),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Enter GCash Account number',
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_GRAY,
                  height: 2,
                ),
              ),
            ),
            TextFormField(
              controller: amount,
              keyboardType: TextInputType.number,
              validator: (t) {
                if (t.isEmpty) {
                  return "Amount is required";
                }
                return null;
              },
              decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                hintText: "₱ 1,000.00",
                errorStyle:
                    TextStyle(color: COLOR_DANGER, fontSize: 12, height: 0.3),
                labelText: 'Amount',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'The Amount you can Cash in is ₱500.00 - ₱ 50,000.00',
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_GRAY,
                  height: 2,
                ),
              ),
            ),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                counterStyle: TextStyle(color: Colors.white),
                hintText: "₱10.00",
                errorStyle:
                    TextStyle(color: COLOR_GRAY, fontSize: 12, height: 0.3),
                labelText: 'Fees',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Service Fee for every transaction is ₱10.00',
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 1.5,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_GRAY,
                  height: 2,
                ),
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text('Cash In'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleNext() async {
    bool status = _formKey.currentState.validate();
    if (status) {
      try {
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );
        store.lastTransactionResponse = await store.gcashService
            .cashIn("0${mobileNumber.text}", amount.text);

        if (store.lastTransactionResponse == null ||
            store.lastTransactionResponse.status == false) {
          OverlayScreen().pop();
          print('FAILED TRANSACTION');
          OverlayScreen().show(
            context,
            identifier: 'processing-failed',
          );
        } else {
          OverlayScreen().pop();
          OverlayScreen().show(
            context,
            identifier: 'success-dialog',
          );
        }
      } catch (err) {}
    }
  }
}
