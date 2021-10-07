import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-scan-face-screen.dart';

class VerificationScanFaceBoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(title: VERIFICATION_SCAN_TITLE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: COLOR_DARK_PURPLE,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: COLOR_DARK_PURPLE,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      height: 5,
                      width: width * 0.15,
                      decoration: BoxDecoration(
                        color: COLOR_DARK_PURPLE.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 20, right: 20, bottom: 10),
              child: Text(
                VERIFICATION_TAKE_SELFIE,
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 2.2,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DAPS,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text(
                VERIFICATION_NOTE,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w400,
                  fontSize: SizeConfig.blockSizeVertical * 1.7,
                  color: COLOR_DARK_GRAY,
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.30,
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/services/face-scan.svg',
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: MediaQuery.of(context).size.height * 0.10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.circle, color: COLOR_DAPS, size: 10),
                      Icon(Icons.circle, color: COLOR_DAPS, size: 10),
                      Icon(Icons.circle, color: COLOR_DAPS, size: 10),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            VERIFICATION_GUIDE,
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 1.7,
                              fontWeight: FontWeight.w400,
                              color: COLOR_DARK_GRAY,
                            )
                        ),
                        Text(
                            VERIFICATION_GUIDE_2,
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 1.7,
                              fontWeight: FontWeight.w400,
                              color: COLOR_DARK_GRAY,
                            )
                        ),
                        Text(
                            VERIFICATION_GUIDE_3,
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 1.7,
                              fontWeight: FontWeight.w400,
                              color: COLOR_DARK_GRAY,
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  VERIFICATION_NOTE_NEXT,
                  style: GoogleFonts.roboto(
                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                    color: COLOR_DARK_GRAY,
                  )
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
              child: SizedBox(
                width: double.infinity,
                child: ButtonTheme(
                  height: SizeConfig.blockSizeVertical * 5,
                  buttonColor: COLOR_DAPS,
                  child: RaisedButton(
                    // shape: ,
                    onPressed: () async {
                      final cameras = await availableCameras();
                      final firstCamera = cameras[1];
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => VerificationScanFace(
                          cameras: firstCamera,
                        )),
                      );
                    },
                    child: Text(
                      'NEXT',
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.blockSizeVertical * 2,
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
