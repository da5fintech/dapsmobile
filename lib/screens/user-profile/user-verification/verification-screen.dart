import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationScreen extends StatelessWidget {

  Widget _iconLabel ({String icon, String label}) {
    return Column(
      children: [
        SvgPicture.asset(
          icon,
          height: 45,
          width: 45,
        ),
        Text(
          label,
          style: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            height: 2,
            color: Colors.black,
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      appBar: SubAppbarWidget(
        title: 'Verification',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Account is in basic level',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.white,
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Upgrade your account to a fully verified level to ensure account security and unlock SWIPE services.',
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Colors.white.withOpacity(0.6),
                    )
                  )
                ],
              ),
            )
          ),
          Flexible(
            flex: 5,
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Get fully verified in just 3 steps',
                        style: GoogleFonts.roboto(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: COLOR_DARK_PURPLE.withOpacity(0.1),
                    padding: EdgeInsets.all(20),
                    height: height * 0.20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed('/user-profile/user-verification/verification-id-list');
                              },
                              child: _iconLabel(
                                icon: 'assets/svg/services/user-id.svg',
                                label: 'Take ID Photo',
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: COLOR_ORANGE),
                            _iconLabel(
                              icon: 'assets/svg/services/faceid.svg',
                              label: 'Scan Face',
                            ),
                            Icon(Icons.arrow_forward_ios, color: COLOR_ORANGE),
                            _iconLabel(
                              icon: 'assets/svg/help/help.svg',
                              label: 'Scan Face',
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      'After verification, unlock more features like:',
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconLabel(
                          icon: 'assets/svg/services/remittance.svg',
                          label: 'Remittance',
                        ),
                        _iconLabel(
                          icon: 'assets/svg/services/bank-transfer.svg',
                          label: 'Bank Transfer',
                        ),
                        _iconLabel(
                          icon: 'assets/svg/services/request-money.svg',
                          label: 'Send / Request',
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Learn more about verification level perks',
                    style: GoogleFonts.roboto(
                      color: COLOR_DARK_PURPLE,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonTheme(
                        buttonColor: COLOR_DARK_PURPLE,
                        child: RaisedButton(
                          // shape: ,
                          onPressed: () {
                          },
                          child: Text(
                            'GET FULLY VERIFIED',
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
              )
            )
          ),
        ],
      )
    );
  }
}