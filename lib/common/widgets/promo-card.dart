import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PromoCard extends StatelessWidget {
  String iconPath;
  String title;
  String subTitle;

  PromoCard({this.iconPath, this.title, subTitle});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 125,
      width: 320,
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
                    height: 150,
                    width: 150,
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
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DARK_PURPLE,
                        height: 1.5,
                      ),
                    ),
                    Text(
                      PROMOS_SCREEN_TITLE_EXTENDS_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400,
                        color: COLOR_DARK_GRAY,
                        height: 1.5,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 2),
                        child: ButtonTheme(
                          minWidth: 20,
                          height: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: RaisedButton(
                            onPressed: () {},
                            elevation: 0,
                            textColor: Colors.white,
                            color: COLOR_DARK_GRAY.withOpacity(0.5),
                            padding:
                            EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              PROMOS_SCEREN_LINK_NOW,
                              style: GoogleFonts.roboto(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
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