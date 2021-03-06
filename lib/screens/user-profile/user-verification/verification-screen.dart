import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/models/UserVerificationModel.dart';
import 'package:daps/screens/user-profile/user-verification/verification-photo-id-screen.dart';

class VerificationScreen extends StatelessWidget {

  Widget _iconLabel ({String icon, String label}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          icon,
          height: 45,
          width: 45,
        ),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontSize: SizeConfig.blockSizeVertical * 1.7,
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
      backgroundColor: COLOR_DAPS,
      appBar: SubAppbarWidget(
        title: 'Verification',
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    VERIFICATION_MAIN_SCREEN,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 2.2,
                      color: Colors.white,
                    )
                  ),
                  SizedBox(height: 10),
                  Text(
                    VERIFICATION_MAIN_UPGRADE,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w400,
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                      height: 1,
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),
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
                        VERIFICATION_MAIN_SCREE_STEPS,
                        style: GoogleFonts.roboto(
                          fontSize: SizeConfig.blockSizeVertical * 2.2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: COLOR_DAPS.withOpacity(0.1),
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
                                label: VERIFICATION_MAIN_LABEL_ID,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, color: COLOR_ORANGE),
                            _iconLabel(
                              icon: 'assets/svg/services/faceid.svg',
                              label: VERIFICATION_MAIN_LABEL_SCAN_FACE,
                            ),
                            Icon(Icons.arrow_forward_ios, color: COLOR_ORANGE),
                            _iconLabel(
                              icon: 'assets/svg/help/help.svg',
                              label: VERIFICATIOPN_MAIN_LABEL_INFORMATION,
                            ),
                          ],
                        )
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 2),
                    child: Text(
                      VERIFICATION_MAIN_UNLOCK,
                      style: GoogleFonts.roboto(
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.blockSizeVertical * 3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _iconLabel(
                          icon: 'assets/svg2/ICONS_DIRECT_SEND.svg',
                          label: VERIFICATION_MAIN_LABEL_REMITTANCE,
                        ),
                        _iconLabel(
                          icon: 'assets/svg2/ICONS_BANK.svg',
                          label: VERIFICATION_MAIN_LABEL_BANK_TRANSFER,
                        ),
                        _iconLabel(
                          icon: 'assets/svg2/ICONS_SEND_AND_RECEIVE.svg',
                          label: VERIFICATION_MAIN_LABEL_SEND_REQUEST,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    VERIFICATION_MAIN_LEARN_MORE,
                    style: GoogleFonts.roboto(
                      color: COLOR_DAPS,
                      fontWeight: FontWeight.w500,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, bottom: 30),
                    child: SizedBox(
                      width: double.infinity,
                      child: ButtonTheme(
                        height: SizeConfig.blockSizeVertical * 5,
                        buttonColor: COLOR_DAPS,
                        child: RaisedButton(
                          onPressed: () async {
                            if(await Permission.camera.request().isGranted) {
                              store.verification = UserVerificationModel();
                              final cameras = await availableCameras();
                              final firstCamera = cameras.first;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => VerificationPhotoIdScreen(
                                    cameras: firstCamera,
                                  ))
                              );
                            } else {
                              openAppSettings();
                            }

                          },
                          child: Text(
                            'GET FULLY VERIFIED',
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
              )
            )
          ),
        ],
      )
    );
  }
}