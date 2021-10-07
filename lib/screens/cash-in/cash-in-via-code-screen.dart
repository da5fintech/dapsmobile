import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/amount-masking.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/cash-in/cash-in-generate-code-screen.dart';
import 'package:swipe/screens/payment/processing-failed-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/util.dart';

final store = getIt<ApplicationStore>();

class CashInViaCodeScreen extends StatefulWidget {
  String partner;

  CashInViaCodeScreen({this.partner});

  @override
  _CashInViaCodeScreenState createState() =>
      _CashInViaCodeScreenState();

}

class _CashInViaCodeScreenState extends State<CashInViaCodeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  TextEditingController amountText = TextEditingController();
  bool hasError = false;
  AppUtil _appUtil = AppUtil();


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
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
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SubAppbarWidget(
          title: CASH_IN_VIA_CODE,
        ),
        body: Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CASH_IN_VIA_CODE_SUBNOTE,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 2,
                  height: 1.5,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              Form(
                key: _formKey,
                child: AmountMasking(
                  noUnderline: false,
                  controller: amountText,
                  type: 'Amount',
                  onChanged: (string) {
                    string = '${_appUtil.formatNumber(string.replaceAll(',', ''))}';
                    amountText.value = TextEditingValue(
                      text: string,
                      selection: TextSelection.collapsed(offset: string.length),
                    );
                  },
                  hasError: hasError,
                ),
              ),
              Column(
                children: [
                  Text(
                    CASH_IN_VIA_CODE_AMOUNT_VALIDATION,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                      color: COLOR_DARK_GRAY,
                      height: 5,
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: SizeConfig.blockSizeVertical * 5,
                        buttonColor: COLOR_DAPS,
                        child: RaisedButton(
                          // shape: ,
                          onPressed: _handleNext,
                          child: Text(
                            CASH_IN_VIA_CODE_NEXT,
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
    if(amountText.text.length <= 0) {
      hasError = true;
      setState(() {});
    } else {
      hasError = false;
      FocusScope.of(context).unfocus();
      OverlayScreen().show(
        context,
        identifier: 'progress',
      );
      final a = await store.cashInService.addMoney(
        user: store.user,
        amount: _appUtil.unFormatAmount(amountText.text),
      );

      if(!a.status) {
        OverlayScreen().pop();
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text("Unable to process transactions, Please Try again later"), backgroundColor: COLOR_DANGER),
        );
        return null;
      }

      OverlayScreen().pop();
      Navigator.push(context, MaterialPageRoute(builder: (_) => CashInGenerateCodeScreen(
        product: CashInProduct(
          amount: _appUtil.unFormatAmount(amountText.text),
          referenceNumber: a.referenceNumber,
          timestamp: a.timestamp,
        ),
      )));
      setState(() {});
    }
  }

}