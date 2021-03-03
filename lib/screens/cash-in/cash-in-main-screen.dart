import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/fixtures.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class CashInMainScreen extends StatefulWidget {
  @override
  _CashInMainScreen createState () =>
      _CashInMainScreen();
}

class _CashInMainScreen extends State<CashInMainScreen>{

  Widget partnerWidget ({String title, String imagePath}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width * 0.16,
          height: height * 0.08,
          margin: EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: COLOR_DARK_PURPLE),
          ),
          child: Center(
            child: Image.asset(
              imagePath,
            ),
          ),
        ),
        SizedBox(height:10),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }

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
          title: 'Cash in',
        ),
        body: ListView(
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
              title: Text(
                'Linked your accounts for more easy access',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
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
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Over the Counter',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10),
                  ...otcOptions.map((otc) {
                    return partnerWidget(title: otc['title'], imagePath: otc['imagePath']);
                  }).toList(),
                ],
              ),
            ),
            Container(
              height: height * 0.15,
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
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
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
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[ SizedBox(width: 10),
                  ...bankOptions.map((bank) {
                    return partnerWidget(title: bank['title'], imagePath: bank['imagePath']);
                  }).toList(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
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
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[ SizedBox(width: 10),
                  ...remittanceOptions.map((remittance) {
                    return partnerWidget(title: remittance['title'], imagePath: remittance['imagePath']);
                  }).toList(),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
