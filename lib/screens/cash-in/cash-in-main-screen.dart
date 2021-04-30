import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:permission_handler/permission_handler.dart' as handler;
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/fixtures.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/screens/cash-in/cash-in-map-screen.dart';
import 'package:swipe/screens/cash-in/cash-in-partner-details-screen.dart';

class CashInMainScreen extends StatefulWidget {
  @override
  _CashInMainScreen createState () =>
      _CashInMainScreen();
}

class _CashInMainScreen extends State<CashInMainScreen>{

  Widget partnerWidget ({String title, String imagePath, bool isDisable = false}) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if(!isDisable) {
          Navigator.push(context, MaterialPageRoute(builder: (_) => CashInPartnerDetailsScreen(
            title: title,
            imagePath: imagePath,
          )));
        }
        return;
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width* 0.16,
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: COLOR_DARK_PURPLE),
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                color: isDisable ? COLOR_DARK_GRAY : null,
                height: height * 0.04
              ),
            ),
          ),
          SizedBox(height:10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(
              fontSize: SizeConfig.blockSizeVertical * 1.3,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'location-dialog': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: CASH_IN_LOCATION_DIALOG_TITLE,
          contentMessage: CASH_IN_LOCATION_DIALOG_CONTENT,
          cancelBtn: true,
          onOk: () async {
            OverlayScreen().pop();
            if(await handler.Permission.location.request().isGranted) {
              Position a = await _determinePosition();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CashInMapScreen(position: a)),
              );
            } else {
              await handler.openAppSettings();
            }
          }
        )
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: CASH_IN_TITLE_TEXT,
        ),
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    CASH_IN_LINKED_ACCOUNTS_TEXT,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    Get.toNamed('/links-account');
                  },
                  child: Text(
                    CASH_IN_MANAGED_TEXT,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      fontWeight: FontWeight.w500,
                      color: COLOR_DARK_PURPLE,
                    ),
                  ),
                )
              ],
            ),
            ListTile(
              leading: SvgPicture.asset(
                  'assets/svg/services/cash-in/link-account.svg'),
              title: Text(
                CASH_IN_LINKED_NOTE_TEXT,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: SizeConfig.blockSizeVertical * 2,
                ),
              ),
              subtitle: Text(
                CASH_IN_LINKED_SUBNOTE_TEXT,
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 1.7,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, top: 10, bottom: SizeConfig.blockSizeVertical * 1.5),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  CASH_IN_OTC_TEXT,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: SizeConfig.blockSizeVertical * 2,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10),
                  ...otcOptions.map((otc) {
                    return partnerWidget(title: otc['title'], imagePath: otc['imagePath']);
                  }).toList(),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                OverlayScreen().show(
                  context,
                  identifier: 'location-dialog',
                );
              },
              child: Container(
                height: height * 0.15,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/services/map.png',
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_pin,
                            color: COLOR_DANGER,
                          ),
                          Text(
                            'View nearby partners',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.roboto(
                              color: COLOR_DARK_PURPLE,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                child: Text(
                  CASH_IN_ONLINE_BANK,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10),
                  ...bankOptions.map((bank) {
                    return partnerWidget(title: bank['title'], imagePath: bank['imagePath'], isDisable: true);
                  }).toList(),
                ],
              ),
            ),
            SizedBox(
              height: 10,
              child: Container(
                color: COLOR_LIGHT_PURPLE,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding:
                const EdgeInsets.only(left: 15, top: 12, bottom: 12),
                child: Text(
                  CASH_IN_REMITTANCE,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            Container(
              height: height * 0.13,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 10),
                  ...remittanceOptions.map((remittance) {
                    return partnerWidget(title: remittance['title'], imagePath: remittance['imagePath'], isDisable: true);
                  }).toList(),
                ],
              ),
            ),
          ],
        )
      ),
    );
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }

      if (permission == LocationPermission.denied) {
        return Future.error(
            'Location permissions are denied');
      }
    }

    Position a = await Geolocator.getCurrentPosition();
    print(a.longitude);
    print(a.latitude);

    return await Geolocator.getCurrentPosition();
  }
}
