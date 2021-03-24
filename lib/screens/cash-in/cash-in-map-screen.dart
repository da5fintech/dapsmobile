import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:geolocator/geolocator.dart';

class CashInMapScreen extends StatefulWidget {
  Position position;

  CashInMapScreen({this.position});

  @override
  _CashInMapScreenState createState() => _CashInMapScreenState();
}

class _CashInMapScreenState extends State<CashInMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor customIcon1;
  AppUtil _appUtil = AppUtil();
  Set<Marker> markers;
  Position position;
  CameraPosition _kGooglePlex;

  @override
  void initState() {
    super.initState();
    _kGooglePlex = CameraPosition(
          target:  LatLng(widget.position.latitude, widget.position.longitude),
          zoom: 14.4746,
    );
    setState(() { });
    markers = Set.from([]);
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

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Partners Location',
          actions: [
            IconButton(
              onPressed: () async {
                Position a = await _determinePosition();
                setState(() {
                  position = a;
                });
              },
              icon: Icon(Icons.gps_fixed),
            )
          ],
        ),
        body: Container(
          height: height,
          width: width,
          child: Stack(
            children: [
              GoogleMap(
                zoomControlsEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                markers: markers,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                  controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                      bearing: 0,
                      target: LatLng(position.latitude, position.longitude),
                      zoom: 14.4746,
                    ),
                  ));
                },
                onTap: (pos) async {
                  // Uint8List markerIcon = await _appUtil.getBytesFromAsset(
                  //     'assets/icons/services/cash-in/7-eleven.png', 80);
                  // print(pos);
                  //
                  // Marker f = Marker(
                  //     markerId: MarkerId('1'),
                  //     icon: BitmapDescriptor.fromBytes(markerIcon),
                  //     position: LatLng(pos.latitude, pos.longitude),
                  //     onTap: () {});
                  // setState(() {
                  //   markers.add(f);
                  // });
                },
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Card(
                    elevation: 10,
                    child: TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Search Partners'),
                    ),
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              //     child: Card(
              //       elevation: 20,
              //       child: ListTile(
              //         leading: Image.asset(
              //           'assets/icons/services/cash-in/7-eleven.png',
              //         ),
              //         title: Text(
              //           '7 Eleven',
              //           style: GoogleFonts.roboto(
              //             fontWeight: FontWeight.w500,
              //             color: COLOR_DARK_PURPLE,
              //             fontSize: 14,
              //           ),
              //         ),
              //         subtitle: Text(
              //           'Santa Ana, Bulacan',
              //           style: GoogleFonts.roboto(
              //             fontSize: 12,
              //             color: COLOR_DARK_GRAY,
              //             height: 1.5,
              //           ),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
