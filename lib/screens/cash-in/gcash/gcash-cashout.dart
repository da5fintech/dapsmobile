import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/main.dart';
import 'package:daps/models/transaction-model.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/screens/cash-in/gcash/success-dialog.dart';
import 'package:daps/screens/payment/processing-failed-dialog.dart';

final store = getIt<ApplicationStore>();

class GCashOut extends StatefulWidget {
  @override
  _GcashOutState createState () =>
      _GcashOutState();
}

class _GcashOutState extends State<GCashOut> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState () {
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
        backgroundColor: Colors.white.withOpacity(.2), content: ProcessingFailedDialog(
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
                errorStyle: TextStyle(
                    color: COLOR_DANGER,
                    fontSize: 12,
                    height: 0.3),
                labelText: REGISTER_SCREEN_MOBIILE_TEXT,
                floatingLabelBehavior: FloatingLabelBehavior
                    .always,
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
                    style: GoogleFonts.roboto(
                        color: Colors.black),
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
                errorStyle: TextStyle(
                    color: COLOR_DANGER,
                    fontSize: 12,
                    height: 0.3),
                labelText: 'Amount',
                floatingLabelBehavior: FloatingLabelBehavior
                    .always,
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
                errorStyle: TextStyle(
                    color: COLOR_GRAY,
                    fontSize: 12,
                    height: 0.3),
                labelText: 'Fees',
                floatingLabelBehavior: FloatingLabelBehavior
                    .always,
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
                onPressed: () {
                  _handleNext();
                },
                child: Text('Cash Out'),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleNext() async {
    bool status = _formKey.currentState.validate();
    if(status) {
      try {
        modalHudLoad(context);
        store.lastTransactionResponse = await store.gcashService.cashOut("0${mobileNumber.text}", amount.text);
        if (store.lastTransactionResponse == null ||
            store.lastTransactionResponse.status == false) {
          Navigator.pop(context);
          OverlayScreen().show(
            context,
            identifier: 'processing-failed',
          );
        } else {
          store.user.balance = store.user.balance + double.tryParse(amount.text);
          await store.accountService.create(store.user);
          store.setNewBalance(store.user.balance);
          Navigator.pop(context);
          OverlayScreen().show(
            context,
            identifier: 'success-dialog',
          );
        }
      } catch (err) {}
    }
  }


}