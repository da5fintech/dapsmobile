import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/third.png',
            width: SizeConfig.blockSizeVertical * 37,
            height: SizeConfig.blockSizeVertical * 37,
          ),
          Text(
              ONBOARDING_THIRD_SCREEN_TITLE,
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                height: 1.5,
                fontSize: SizeConfig.blockSizeVertical * 2,
                color: COLOR_DARK_PURPLE,
                fontWeight: FontWeight.w600,
              )
          ),
          Text(
              ONBOARDING_THIRD_SCREEN_SUB_TITLE,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: SizeConfig.blockSizeVertical * 1.5,
                height: 2,
                color: COLOR_DARK_GRAY,
              )
          )
        ],
      ),
    );
  }
}