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
          title: CASH_IN_PARTNER_DETAILS_TITLE,
        ),
        body: SingleChildScrollView(
          child: Column(
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
                        height: height * 0.04,
                      ),
                    ),
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2,
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
                                    CASH_IN_VIEW_NEARBY_STORES,
                                    style: GoogleFonts.roboto(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.blockSizeVertical * 2,
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
                    height: height * 0.08
                  ),
                  title: Text(
                    CASH_IN_GENERATE_BARCODE,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: COLOR_DAPS,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                    ),
                  ),
                  subtitle: Text(
                    CASH_IN_SUBNOTE_BARCODE, style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2,
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
                  CASH_IN_HOW_TO_CASH,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.blockSizeVertical * 2.2,
                    color: COLOR_DAPS,
                  )
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: Text(
                    CASH_IN_HOW_TO_CASH_SUBNOTE,
                    style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w700,
                      fontSize: SizeConfig.blockSizeVertical * 1.9,
                      color: Colors.black,
                      height: 1,
                    )
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: COLOR_DAPS,
                    radius: SizeConfig.blockSizeVertical * 2.8,
                    child: Text('1')
                  ),
                  subtitle: Text(
                    CASH_IN_STEP_1,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
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
                    backgroundColor: COLOR_DAPS,
                    radius: SizeConfig.blockSizeVertical * 2.8,
                    child: Text('2')
                  ),
                  subtitle: Text(
                    CASH_IN_STEP_2,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
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
                      backgroundColor: COLOR_DAPS,
                      radius: SizeConfig.blockSizeVertical * 2.8,
                      child: Text('3')
                  ),
                  subtitle: Text(
                    CASH_IN_STEP_3,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                      color: COLOR_DARK_GRAY,
                      height: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      )
    );
  }
}