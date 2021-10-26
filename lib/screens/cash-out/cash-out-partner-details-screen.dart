import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';


class CashOutPartnerDetailsScreen extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  String title;
  String imagePath;

  CashOutPartnerDetailsScreen({this.title, this.imagePath});

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.7954784, 120.8824452),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(14.7954784, 120.8824452),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Partner Details',
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: width * 0.15,
                  height: height * 0.08,
                  margin: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: COLOR_DARK_PURPLE),
                  ),
                  child: Center(
                    child: Image.asset(
                      imagePath,
                    ),
                  ),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Container(
              height: height * 0.30,
              child: Stack(
                children: [
                  GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ButtonTheme(
                        buttonColor: Colors.blue[600],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        minWidth: width * 0.60,
                        child: RaisedButton(
                          onPressed: () {},
                          child: Text(
                            'View nearby branches',
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            )
                          )
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'How to Cash Out',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: COLOR_DARK_PURPLE,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                'At any branch of this official partners',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Colors.black,
                  height: 2,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: CircleAvatar(
                  radius: 20,
                  child: Text('1', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  backgroundColor: COLOR_DARK_PURPLE,
              ),
              title: Text(
                'Fill out the SWIPE Service Form',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  radius: 20,
                  child: Text('2', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  backgroundColor: COLOR_DARK_PURPLE,
              ),
              title: Text(
                'Present Valid ID',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
              subtitle: Text(
                'See list of valid IDs',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_PURPLE,
                  height: 1.5,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  radius: 20,
                  child: Text('3', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  backgroundColor: COLOR_DARK_PURPLE,
              ),
              title: Text(
                'Received text message verifying your cashout and\nconfirm with MPIN or OTP',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                  radius: 20,
                  child: Text('4', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                  backgroundColor: COLOR_DARK_PURPLE,
              ),

              title: Text(
                'Received cash from the cashier.',
                style: GoogleFonts.roboto(
                  fontSize: 12,
                  color: COLOR_DARK_GRAY,
                  height: 1.5,
                ),
              ),
            ),

          ],
        ),
      )
    );
  }

}