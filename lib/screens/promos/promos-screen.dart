import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class PromosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: PROMOS_SCREEN_TITLE_TEXT,
        ),
        body: ListView(
          children: [
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 125,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/svg/promos/undraw_wallet.svg',
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
                              PROMOS_SCREEN_TITLE_DO_MORE_TEXT,
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
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              height: 125,
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: SvgPicture.asset(
                          'assets/svg/promos/undraw_savings.svg',
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              PROMOS_SCREEN_TITLE_SAVE,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: COLOR_DARK_PURPLE,
                                height: 1.5,
                              ),
                            ),
                            Text(
                              PROMOS_SCREEN_TITLE_ANNUM,
                              style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: COLOR_DARK_GRAY,
                                letterSpacing: 1.2,
                                height: 1.5,
                              ),
                            ),
                            Spacer(),
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
            ),
          ],
        ),
      ),
    );
  }
}
