import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class CashInMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SubAppbarWidget(
        title: 'Cash in',
      ),
      body: Container(
        height: height,
        width: width,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    'My Linked Accounts',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  child: Text(
                    'Manage',
                    style: GoogleFonts.roboto(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: COLOR_DARK_PURPLE,
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/svg/services/cash-in/link-account.svg'),
              title: Text('Linked your accounts for more easy access',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14,
                  )),
              subtitle: Text(
                'Connect your accounts with swipe wallet for\neasy cash in process.',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10, bottom: 20),
              child: Text('Over the Counter',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14,
                  )),
            ),
            Container(
              height: height * 0.10,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    width: width * 0.17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: COLOR_DARK_PURPLE),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/services/cash-in/villarica.png',
                      ),
                    ),
                  ),
                  Container(
                      width: width * 0.17,
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: COLOR_DARK_PURPLE),
                      ),
                      child: Center(
                          child: Image.asset(
                        'assets/icons/services/cash-in/gcash.png',
                      ))),
                  Container(
                    width: width * 0.17,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: COLOR_DARK_PURPLE),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/services/cash-in/rdpawnshop.png',
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.17,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: COLOR_DARK_PURPLE),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/services/cash-in/7-eleven.png',
                      ),
                    ),
                  ),
                  Container(
                    width: width * 0.17,
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: COLOR_DARK_PURPLE),
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/icons/services/cash-in/raquel.png',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: height * 0.10,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/icons/services/map.png',
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: COLOR_DANGER,
                        ),
                        Text(
                          'View nearby partners',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            color: COLOR_DARK_PURPLE,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Flexible(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                    child: Text(
                      'Online Bank',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.10,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(width: 10),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            width: width * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: COLOR_DARK_PURPLE),
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/icons/services/cash-in/union-bank.png',
                            ))),
                        Container(
                            width: width * 0.17,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: COLOR_DARK_PURPLE),
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/icons/services/cash-in/bpi.png',
                            ))),
                        Container(
                          width: width * 0.17,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: COLOR_DARK_PURPLE),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/services/cash-in/instapay.png',
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.17,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: COLOR_DARK_PURPLE),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/services/cash-in/pesonet.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  SizedBox(
                    height: 10,
                    child: Container(
                      color: COLOR_LIGHT_PURPLE,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 10, bottom: 30),
                    child: Text(
                      'Remittance',
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Container(
                    height: height * 0.10,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        SizedBox(width: 10),
                        Container(
                            margin: EdgeInsets.only(right: 10),
                            width: width * 0.17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: COLOR_DARK_PURPLE),
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/icons/services/cash-in/wu.png',
                            ))),
                        Container(
                            width: width * 0.17,
                            margin: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: COLOR_DARK_PURPLE),
                            ),
                            child: Center(
                                child: Image.asset(
                              'assets/icons/services/cash-in/cebuana.png',
                            ))),
                        Container(
                          width: width * 0.17,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: COLOR_DARK_PURPLE),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/services/cash-in/rd-padala.png',
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.17,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: COLOR_DARK_PURPLE),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/services/cash-in/ria.png',
                            ),
                          ),
                        ),
                        Container(
                          width: width * 0.17,
                          margin: EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: COLOR_DARK_PURPLE),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/icons/services/cash-in/iremit.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
