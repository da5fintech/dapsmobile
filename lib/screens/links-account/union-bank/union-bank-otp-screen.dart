import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/screens/links-account/union-bank/union-bank-confirmation-screen.dart';

class UnionBankOtpScreen extends StatefulWidget {
  @override
  _UnionBankOtpScreenState createState () =>
      _UnionBankOtpScreenState();

}

class _UnionBankOtpScreenState extends State<UnionBankOtpScreen> {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width;
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "Union Bank Linking",
        ),
        body: Container(
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Image.asset(
                'assets/images/union-bank.png',
              ),
              Text(
                'Enter your One-Time Password',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Please enter the One-Time Password generated by your UnionBank Online App.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: TextField(
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    hintText: "Enter 6-digit One-Time Password",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: COLOR_DARK_GRAY),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: COLOR_DARK_GRAY),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                      borderSide: BorderSide(width: 1,color: COLOR_DARK_GRAY),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,)
                    ),
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: COLOR_DANGER)
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                        borderSide: BorderSide(width: 1,color: COLOR_DANGER)
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              ButtonTheme(
                  minWidth: width * 0.80,
                  buttonColor: COLOR_DARK_ORANGE,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: RaisedButton(
                      onPressed: () async {
                        _handleNext();
                      },
                      child: Text(
                        'LOG IN',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                  )
              ),
              ButtonTheme(
                  minWidth: width * 0.80,
                  buttonColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: COLOR_DARK_GRAY.withOpacity(0.3),
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(50),

                  ),
                  child: RaisedButton(
                      elevation: 0.5,
                      onPressed: () async {
                        _handleNext();
                      },
                      child: Text(
                        'RECEIVED OTP VIA SMS',
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                  )
              ),
            ],
          ),
        )
      )
    );
  }

  void _handleNext () {
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => UnionBankConfirmationScreen()),
    );
  }

}