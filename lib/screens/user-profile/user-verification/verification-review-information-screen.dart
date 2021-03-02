import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationReviewInfromationScreen extends StatefulWidget {
  @override
  _VerificationReviewInfromationScreenState createState() =>
      _VerificationReviewInfromationScreenState();
}

class _VerificationReviewInfromationScreenState
    extends State<VerificationReviewInfromationScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Review Information',
        ),
        body: Column(
          children: [
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Full Name',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'Jose Paulo Dela Cruz',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Nationality',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'Full Name',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Date of Birth',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'November 20, 2022',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Place of Birth',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'Malolos Bulacan',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Contact Number',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                '09056535707',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Current Address',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                '1234 Maimpok St., San Pablo, Malolos, Bulacan, 3000, Philippines',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Nature of Work',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'Information Technology',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Source of Funds',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
              subtitle: Text(
                'Cash on Hand',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (val) {},
                  ),
                  RichText(
                    text: TextSpan(
                      text: "I agree to Swipe app's",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: 12,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Terms of Service', style: GoogleFonts.roboto(
                          color: COLOR_DARK_PURPLE,
                          fontWeight: FontWeight.w500,
                        )),
                        TextSpan(text: ' and\n'),
                        TextSpan(text: 'Privacy Policy', style: GoogleFonts.roboto(
                          color: COLOR_DARK_PURPLE,
                          fontWeight: FontWeight.w500,
                        )),
                      ],
                    ),
                  ),

                ],
              ),
            ),
            Spacer(),
            Text(
              'To change details, go back and edit the form.',
              style: GoogleFonts.roboto(
                fontSize: 12,
                color: COLOR_DARK_GRAY
              )
            ),
            Padding(
              padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
              child: SizedBox(
                width: double.infinity,
                child: ButtonTheme(
                  buttonColor: COLOR_DARK_PURPLE,
                  child: RaisedButton(
                    // shape: ,
                    onPressed: () async {
                    },
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
