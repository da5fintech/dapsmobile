import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/service-button.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/bills_payment/category-button-widget.dart';

class PayQrGenerateScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createTheme(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: PAYQR_GENERATE_TITLE,
        ),
        body: Container(
          height: height,
          width: width,
          padding: EdgeInsets.only(top: 20, right: 10, left: 10),
          child: Column(
            children: [
              Text(
                PAYQR_GENERATE_SCREEN_NOTE_TEXT,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: Colors.white,
                    height: 1.5,
                    fontWeight: FontWeight.w400),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                height: height * 0.50,
                width: width,
                child: Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Spacer(),
                      Container(
                        height: 50,
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        color: COLOR_ORANGE,
                        child: Text(
                          'Your Voucher will be redeemed automatically.',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              height: 1.5),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.only(bottom: 32, right: 10, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.refresh, color: Colors.white),
                          Text(
                            'Generate New',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Icon(Icons.circle, color: Colors.white),
                          Text(
                            'Pay QR',
                            style: GoogleFonts.roboto(
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
