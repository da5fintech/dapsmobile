import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/main-app-bar.widget.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class CashInViaCodeScreen extends StatefulWidget {
  String partner;

  CashInViaCodeScreen({this.partner});

  @override
  _CashInViaCodeScreenState createState() =>
      _CashInViaCodeScreenState();

}

class _CashInViaCodeScreenState extends State<CashInViaCodeScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
                  onFieldSubmitted: (text) {
                  },
                  decoration: InputDecoration(
                    labelText: "Amount",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    focusColor: COLOR_DARK_PURPLE,
                    errorStyle: TextStyle(
                        color: COLOR_GRAY, fontSize: 12, height: 0.3),
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
                          onPressed: () async {
                          },
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

}