import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/links-account/union-bank/union-bank-otp-screen.dart';

class UnionBankLoginScreen extends StatefulWidget {
  @override
  _UnionBankLoginScreenState createState () =>
      _UnionBankLoginScreenState();

}

class _UnionBankLoginScreenState extends State<UnionBankLoginScreen> {

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
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Form(
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Image.asset(
                      'assets/images/union-bank.png',
                    ),
                    Text(
                      'Confirm Your Online Payment',
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: COLOR_ORANGE),
                        SizedBox(width: 5),
                        Text(
                          'CyberSecure',
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Ensure that your browser shows our verified URL',
                        style: GoogleFonts.roboto(
                          fontSize: 12,
                          color: Colors.black,
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(2),
                      width: width * 0.60,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.lock_outline),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            width: 2,
                            height: 15,
                            color: COLOR_DARK_GRAY.withOpacity(0.3),
                          ),
                          Text(
                            'https://online.unionbankph.com',
                            style: GoogleFonts.roboto(
                              fontSize: 12,
                              color: COLOR_DARK_GRAY,
                            )
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: COLOR_DARK_GRAY.withOpacity(0.5)),
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "User ID",
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
                    SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 15),
                      child: TextField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          hintText: "Password",
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
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                      child: RichText(
                        text: TextSpan(
                          text: "By accessing UnionBank Online Account through our partner, you consert the processing and disclosure of your account information and transaction details to our partner in order to fulfill the services you wish UnionBank and our partner to provide you. For more info, read UnionBank’s Privacy Policy",
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 12,
                            height: 1.5,
                          ),
                          children: <TextSpan>[
                            TextSpan(text: " UnionBank's Privacy Policy", style: GoogleFonts.roboto(
                              color: COLOR_ORANGE,
                              fontWeight: FontWeight.w700,
                            )),
                          ],
                        ),
                      ),
                    ),
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
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 1,
                              color: COLOR_DARK_GRAY.withOpacity(0.3),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'OR',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              )
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Container(
                              height: 1,
                              color: COLOR_DARK_GRAY.withOpacity(0.3),
                            ),
                          ),
                        ],
                      ),
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
                            elevation: 0,
                            onPressed: () async {
                              _handleNext();
                            },
                            child: Text(
                              'GUEST CHECKOUT',
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
            ],
          ),
        )
      )
    );
  }

  void _handleNext () {
    Navigator.push(context,
      MaterialPageRoute(builder: (_) => UnionBankOtpScreen()),
    );
  }

}

