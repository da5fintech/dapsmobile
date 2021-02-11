import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/fixtures.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class PartnerMerchantsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width * 0.44;
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Partner Merchants',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 20, bottom: 10),
              child: Text(
                'Find where you can shop',
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
              ),
            ),
            Expanded(
                child: Wrap(
              children: partners.map((partner) {
                return Container(
                  height: 90,
                  width: width,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        partner['imagePath'],
                      ),
                    ),
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        height: 90,
                        width: width,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.30),
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          partner['title'],
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                );
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }
}
