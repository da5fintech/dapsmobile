import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/cash-in/cash-in-generate-code-screen.dart';
import 'package:swipe/screens/payment/processing-failed-dialog.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class CashInViaCodeScreen extends StatefulWidget {
  String partner;

  CashInViaCodeScreen({this.partner});

  @override
  _CashInViaCodeScreenState createState() =>
      _CashInViaCodeScreenState();

}

class _CashInViaCodeScreenState extends State<CashInViaCodeScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountText = TextEditingController(text: "100");

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


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
            Text(
              "Processing...",
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
      'processing-failed': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: ProcessingFailedDialog(
          onOk: () {
          },
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Cash in Via Code'
        ),
        body: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cash in made easier via Barcode\nor a unique Reference Code',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  height: 1.5,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              Form(
                key: _formKey,
                child:  TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  textAlign: TextAlign.end,
                  keyboardType: TextInputType.numberWithOptions(),
                  controller: amountText,
                  onFieldSubmitted: (text) {
                  },
                  validator: (text) {
                    if(text.isEmpty) {
                      return "Please input amount";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Amount",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusColor: COLOR_DARK_PURPLE,
                  ),
                ),
              ),
              Column(
                children: [
                  Text(
                    'Please check the amount before you proceed',
                    style: GoogleFonts.roboto(
                      fontSize: 12,
                      color: COLOR_DARK_GRAY,
                      height: 5,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonTheme(
                        buttonColor: COLOR_DARK_PURPLE,
                        child: RaisedButton(
                          // shape: ,
                          onPressed: _handleNext,
                          child: Text(
                            'NEXT',
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ),
    );
  }

  void _handleNext () async {
    bool status = _formKey.currentState.validate();
    if(status) {
      OverlayScreen().show(
        context,
        identifier: 'progress',
      );
      final a = await store.cashInService.addMoney(
        user: store.user,
        amount: amountText.text,
      );

      if(!a.status) {
        OverlayScreen().pop();
        print('failed');

        // OverlayScreen().show(
        //   context,
        //   identifier: 'processing-failed',
        // );
        return null;
      }

      OverlayScreen().pop();
      Navigator.push(context, MaterialPageRoute(builder: (_) => CashInGenerateCodeScreen(
        referenceNumber: a.referenceNumber,
        amount: amountText.text,
      )));
    }
  }

}