import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/screens/cash-in/gcash/gcash-cash-in.dart';
import 'package:daps/screens/cash-in/gcash/gcash-cashout.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/main.dart';

final store = getIt<ApplicationStore>();

class GcashMainScreen extends StatefulWidget {
  @override
  _GcashMainScreenState createState() => _GcashMainScreenState();
}

class _GcashMainScreenState extends State<GcashMainScreen> {
  String type = 'Cash In';

  Widget _button(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        minWidth: SizeConfig.blockSizeVertical * 12,
        height: SizeConfig.blockSizeVertical * 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: type == text ? Colors.transparent : Colors.white.withOpacity(
                .4),
          ),
        ),
        child: RaisedButton(
          elevation: 0,
          onPressed: () {
            setState(() {
              type = text;
            });
          },
          textColor: type == text ? COLOR_DARK_PURPLE : Colors.white,
          color: type == text ? Colors.white : COLOR_DARK_PURPLE,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style:
            GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 2,
                fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          elevation: 0,
          title: 'G-Cash',
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Container(
              height: SizeConfig.screenHeight * .90,
              child: Column(
                children: [
                  Flexible(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      color: COLOR_DARK_PURPLE,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Account Balance',
                            style: GoogleFonts.roboto(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: SizeConfig.blockSizeVertical * 2.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Text(
                                '₱',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 6,
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                '${store.user.balance}0',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: SizeConfig.blockSizeVertical * 4,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              _button('Cash In'),
                              _button('Cash Out'),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: type == "Cash In" ? GcashIn() : GCashOut(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
