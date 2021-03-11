import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/photo-viewer/photo-viewer-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-submitted-screen.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class VerificationReviewInfromationScreen extends StatefulWidget {
  @override
  _VerificationReviewInfromationScreenState createState() =>
      _VerificationReviewInfromationScreenState();
}

class _VerificationReviewInfromationScreenState
    extends State<VerificationReviewInfromationScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool checkTerms = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SubAppbarWidget(
          title: 'Review Information',
        ),
        body: ListView(
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
                "${store.verification.firstName} ${store.verification.lastName}",
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
                store.verification.nationality,
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
                store.verification.dateOfBirth,
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
                store.verification.placeOfBirth,
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
                store.verification.contactNumber,
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
                '${store.verification.address} ${store.verification.barangay}. ${store.verification.city} ${store.verification.state}',
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
                store.verification.natureOfWork,
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
                store.verification.sourceOfIncome,
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'IDs',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    photoView(store.verification.id, 'id');
                  },
                  child: Observer(
                    builder: (_) => Image.asset(
                      store.idImage.path,
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              visualDensity: VisualDensity(vertical: -3, horizontal: -4),
              title: Text(
                'Photo',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                ),
              ),
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: GestureDetector(
                    onTap: () {
                      photoView(store.verification.face, 'face');
                    },
                    child: Observer(
                      builder: (_) => Image.asset(
                        store.faceImage.path,
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  Checkbox(
                    value: checkTerms,
                    onChanged: (val) {
                      checkTerms = val;
                      setState(() {});
                    },
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
                        TextSpan(
                            text: 'Terms of Service',
                            style: GoogleFonts.roboto(
                              color: COLOR_DARK_PURPLE,
                              fontWeight: FontWeight.w500,
                            )),
                        TextSpan(text: ' and\n'),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.roboto(
                              color: COLOR_DARK_PURPLE,
                              fontWeight: FontWeight.w500,
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text('To change details, go back and edit the form.',
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.roboto(fontSize: 12, color: COLOR_DARK_GRAY)),
            Padding(
              padding:
                  EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
              child: SizedBox(
                width: double.infinity,
                child: ButtonTheme(
                  buttonColor:
                      checkTerms ? COLOR_DARK_PURPLE : Colors.grey[500],
                  child: RaisedButton(
                    // shape: ,
                    onPressed: () async {
                      if (checkTerms) {
                        _handleSubmit();
                      } else {
                        return null;
                      }
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

  void photoView (File image, String type) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => PhotoViewerScreen(
        photo: image,
        type: type,
      ))
    );
  }

  void _handleSubmit() async {
    if (checkTerms) {
      OverlayScreen().show(context, identifier: 'progress');
      final response =
          await store.verifyService.verify(store.verification, store.user);
      OverlayScreen().pop();
      if (response.result) {
        Navigator.push(context,
            MaterialPageRoute(builder: (_) => VerificationSubmittedScreen()));
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
              content: Text("Something went wrong, Please try again later."),
              backgroundColor: COLOR_DANGER),
        );
      }
    }
  }
}
