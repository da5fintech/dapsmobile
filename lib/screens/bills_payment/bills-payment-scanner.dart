import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:get/get.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class BillPaymentScanner extends StatefulWidget {

  @override
  _BillPaymentScannerState createState () => _BillPaymentScannerState();
}

class _BillPaymentScannerState extends State<BillPaymentScanner> {
  QRViewController controller;
  String scanQr = "";
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState () {
    super.initState();
  }

  @override
  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if(scanQr.isEmpty) {
        scanQr = scanData.code;
        setState(() {});
        await _handleNext();
      }
    });
  }


  @override
  void dispose () {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "Scanner",
        ),
        body: Container(
          height: SizeConfig.screenHeight,
          width: SizeConfig.screenWidth,
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
                    'Scan the barcode on the bottom\nright of your bill.',
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
            ],
          ),
        ),
      )
    );
  }


  void _handleNext () async {
    OverlayScreen().show(
      context,
      identifier: 'progress',
    );
    await Future.delayed(Duration(seconds: 2));
    store.selectedBiller.fields[0].defaultValue = scanQr;
    OverlayScreen().pop();
    Get.toNamed('/services/bills-payment/bills-payment-biller-form-screen');
    setState(() {});
  }
}