import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/fixtures.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';

class VerificationIdListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "ID List",
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                'Recommended ID',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_PURPLE,
                ),
              ),
            ),
            ...recommendedId?.map((id) {
                  return Column(
                    children: [
                      ListTile(
                          visualDensity:
                              VisualDensity(vertical: -4, horizontal: 0),
                          title: Text(id,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ))),
                      Divider(
                          thickness: 0.5,
                          color: COLOR_DARK_GRAY.withOpacity(0.4))
                    ],
                  );
                })?.toList() ??
                [],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Text(
                'Other ID',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_PURPLE,
                ),
              ),
            ),
            ...otherId?.map((id) {
                  return Column(
                    children: [
                      ListTile(
                          visualDensity:
                              VisualDensity(vertical: -4, horizontal: 0),
                          title: Text(id,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ))),
                      Divider(
                          thickness: 0.5,
                          color: COLOR_DARK_GRAY.withOpacity(0.4))
                    ],
                  );
                })?.toList() ??
                [],
          ],
        ),
      ),
    );
  }
}
