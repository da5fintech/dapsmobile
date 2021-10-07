import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipe/common/size.config.dart';

class PromoCard extends StatelessWidget {
  String iconPath;
  String title;
  String subTitle;

  PromoCard({this.iconPath, this.title, subTitle});


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.80,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Row(
            children: [
              Flexible(
                  flex: 1,
                  child: SvgPicture.asset(
                    iconPath,
                    // height: MediaQuery.of(context).size.height * 0.09,
                    // width: 10,
                  )
              ),
              Flexible(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DAPS,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      PROMOS_SCREEN_TITLE_EXTENDS_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 1.6,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        color: COLOR_DARK_GRAY,
                        height: 1.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: SizeConfig.blockSizeVertical * 2.5,
                        width: MediaQuery.of(context).size.width  * 0.18,
                        decoration: BoxDecoration(
                          color: COLOR_DARK_GRAY.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Center(
                          child: Text(
                            'Link Now',
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 1.5,
                              color: Colors.white,
                            ),
                          ),
                        )
                      )
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