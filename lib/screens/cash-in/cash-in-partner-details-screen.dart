import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/screens/cash-in/cash-in-via-code-screen.dart';

class CashInPartnerDetailsScreen extends StatelessWidget {
  Completer<GoogleMapController> _controller = Completer();
  String title;
  String imagePath;

  CashInPartnerDetailsScreen({this.title, this.imagePath});

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
                )
              ],
            ),
            Container(
              height: height * 0.30,
              child: Stack(
                children: [
                  GoogleMap(
                    zoomControlsEnabled: false,
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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CashInViaCodeScreen(
                      partner: title,
                    )),
                  );
                },
                leading: SvgPicture.asset(
                  'assets/svg/services/cash-in/barcode.svg',
                ),
                title: Text(
                  'Generate Barcode',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    color: COLOR_DARK_PURPLE,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Have the cashier scan this barcode linked to your SWIPE account.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: COLOR_DARK_GRAY,
                    height: 1.5,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 12, color: COLOR_DARK_PURPLE),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: COLOR_DARK_GRAY.withOpacity(.56),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                'How to Cash In',
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: COLOR_DARK_PURPLE,
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                  'At any branch of this official partners.',
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                    color: Colors.black,
                    height: 2,
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: Text('1')
                ),
                subtitle: Text(
                  'Inform the Cashier that you would like to Cash In to your SWIPE wallet.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: COLOR_DARK_GRAY,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    radius: 20,
                    child: Text('2')
                ),
                subtitle: Text(
                  'Tap on “Generate Barcode” button above. Enter the amount then Tap ‘Generate Barcode’. Show the generated barcode in the app.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: COLOR_DARK_GRAY,
                    height: 1.5,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                    radius: 20,
                    child: Text('3')
                ),
                subtitle: Text(
                  'Cashier to confirm, collect payment and print receipt. Wait for a text confirmation upon successful Cash In before leaving the store.',
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    color: COLOR_DARK_GRAY,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}