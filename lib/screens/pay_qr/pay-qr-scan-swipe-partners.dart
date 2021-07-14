import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class PayQrScanSwipePartnersScreen extends StatefulWidget {
  const PayQrScanSwipePartnersScreen({Key key}) : super(key: key);

  @override
  _PayQrScanSwipePartnersScreenState createState() =>
      _PayQrScanSwipePartnersScreenState();
}

class _PayQrScanSwipePartnersScreenState
    extends State<PayQrScanSwipePartnersScreen> {
  QRViewController controller;
  String scanQr = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AppUtil _appUtil = AppUtil();

  @override
  void initState() {
    super.initState();
  }

  @override
  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (scanQr.isEmpty) {
        scanQr = scanData.code;
        await _handleNext();
        setState(() {});
      }
    });
  }

  void _handleNext() {}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SubAppbarWidget(
        title: "Scan Swipe Partners",
      ),
      body: Container(
        height: height,
        width: width,
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: COLOR_ORANGE,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
                overlayColor: COLOR_DARK_PURPLE.withOpacity(0.50),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  DIRECT_SEND_VIA_QR_SCREEN_NOTE,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    height: 2,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (scanQr.isNotEmpty) ...[
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      DIRECT_SEND_VIA_QR_SCREEN_DETECTED,
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    FlatButton.icon(
                      onPressed: () {
                        scanQr = "";
                        setState(() {});
                      },
                      icon: Icon(Icons.refresh, color: Colors.white),
                      label: Text(
                        DIRECT_SEND_VIA_QR_SCREEN_RESCAN,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Padding(
                    //   padding: EdgeInsets.only(left: 25, right: 25),
                    //   child: SizedBox(
                    //     width: double.infinity,
                    //     child: Opacity(
                    //       opacity: 0.5,
                    //       child: RaisedButton(
                    //         // shape: ,
                    //         onPressed: () {
                    //         },
                    //         child: Text(
                    //           DIRECT_SEND_VIA_QR_SCREEN_PROCEED,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
