import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/fixtures.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';


class CashOutMainScreen extends StatefulWidget {
  @override
  _CashOutMainScreenState createState () =>
      _CashOutMainScreenState();
}

class _CashOutMainScreenState extends State<CashOutMainScreen>{

  Widget partnerWidget ({String title, String imagePath}) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (_) => CashInPartnerDetailsScreen(
        //   title: title,
        //   imagePath: imagePath,
        // )));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width* 0.16,
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: 5),
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
      ),
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
          title: 'Cash Out'
        ),
        body: Column(
          children: [
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
                  ...otcOptions.map((bank) {
                    return partnerWidget(title: bank['title'], imagePath: bank['imagePath']);
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
            Expanded(
              child: SizedBox(
                child: Container(
                  color: COLOR_LIGHT_PURPLE,
                )
              ),
            )
          ],

        ),
      )
    );

  }
}