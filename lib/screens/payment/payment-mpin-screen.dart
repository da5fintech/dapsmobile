import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/errors.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/payment/wrong-mpin-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class PaymentMpinScreen extends StatefulWidget {
  @override
  _PaymentMpinScreenState createState() => _PaymentMpinScreenState();
}

class _PaymentMpinScreenState extends State<PaymentMpinScreen> {
  TextEditingController controller = new TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _cleanupOverlay());
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height * 0.70;
    double width = MediaQuery.of(context).size.width * 0.50;

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'dialog': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: WrongMpinDialog(
            onOk: () {
              _handleOk();
            },
          )),
      'processing error': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: WrongMpinDialog(
            onOk: () {
              _handleOk();
            },
          )),
    });
    return Theme(
      data: td,
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            title: "Payment",
          ),
          body: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        size: 45,
                        color: COLOR_DARK_PURPLE,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text("Fantastic!",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: COLOR_DARK_PURPLE,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 10,
                      ),
                      Text("Please enter your 6-digit MPIN to proceed."),
                      Container(
                        width: width,
                        child: PinCodeTextField(
                          controller: controller,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            print("change ${str}");
                          },
                          appContext: context,
                          length: 6,
                          pinTheme: PinTheme(
                            activeColor: COLOR_DARK_PURPLE,
                            inactiveColor: Colors.black.withOpacity(.30),
                            fieldWidth: 20,
                          ),
                        ),
                      ),
                    ],
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
                          "PROCEED",
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

  void _handlePay() async {
    try {
      if (controller.text == store.user.mpin) {
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );

        store.lastTransactionResponse =
            await store.transactionService.process(store.transaction);

        await Future.delayed(Duration(seconds: 1));
        OverlayScreen().pop();

        Get.toNamed('/services/payment/payment-confirmation-screen');
      } else {
        OverlayScreen().show(
          context,
          identifier: 'dialog',
        );
      }
    } on EloadProcessingError catch (e) {
      OverlayScreen().pop();
    } finally {}
  }

  void _handleOk() {
    OverlayScreen().pop();
  }

  _cleanupOverlay() {
    // OverlayScreen().removeScreens(identifiers)
  }
}
