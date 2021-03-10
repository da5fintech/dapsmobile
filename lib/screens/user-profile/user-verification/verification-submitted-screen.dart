import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationSubmittedScreen extends StatelessWidget {
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Spacer(),
              Icon(Icons.check_circle, color: COLOR_GREEN, size: 62),
              SizedBox(height: 20),
              Text(
                'Application Submitted',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  'Please allow us to review your application within 24 hours. You will be notified via SMS\n. Thank you for your patience and understanding.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    height: 1.5,
                    color: COLOR_DARK_GRAY,
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 30),
                child: SizedBox(
                  width: double.infinity,
                  child: ButtonTheme(
                    buttonColor: COLOR_DARK_PURPLE,
                    child: RaisedButton(
                      // shape: ,
                      onPressed: () async {
                        Get.offAndToNamed('/services');
                      },
                      child: Text(
                        'OK',
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
      ),
    );
  }
}