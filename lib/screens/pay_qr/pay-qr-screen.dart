import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/screens/pay_qr/pay-qr-scan-swipe-partners.dart';

enum ScreenNav {pay, generate, scan}

class PayQRScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width;

    Widget _card ({String imagePath, String title, ScreenNav navTo}) {
      return GestureDetector(
        onTap: () {
          switch(navTo) {
            case ScreenNav.pay:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PayQrScanSwipePartnersScreen()),
              );
              return;
            case ScreenNav.generate:
              Get.toNamed('/services/pay-qr/pay-qr-generate-screen');
              return;
            default:
              return null;

          }
        },
        child: Container(
          height: 130,
          width: width,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    margin: EdgeInsets.only(left: 10, right: 20),
                    child: Image.asset(imagePath)),
                  Text(title, style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black)),
                ],
              ),
            )
          ),
        ),
      );
    }

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: PAYQR_SCREEN_TITLE_TEXT,
        ),
        body: Column(
          children: [
            _card(imagePath: "assets/icons/services/pay-qr/scan-qr.png", title: PAYQR_SCREEN_SCAN_TEXT, navTo: ScreenNav.pay),
            // _card(imagePath: "assets/icons/services/pay-qr/upload-qr.png", title: PAYQR_SCREEN_UPLOAD_TEXT, navTo: ScreenNav.upload),
            // _card(imagePath: "assets/icons/services/pay-qr/generate-qr.png", title: PAYQR_SCREEN_GENERATE_QR_TEXT, navTo: ScreenNav.generate),
          ],
        )
      ),
    );
  }
}