import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/main.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/screens/payment/processing-failed-dialog.dart';
import 'package:daps/store/application-store.dart';
import 'package:vibration/vibration.dart';

final store = getIt<ApplicationStore>();

class DirectSendViaQrScreen extends StatefulWidget {

  @override
  _DirectSendViaQrScreen createState() => _DirectSendViaQrScreen();
}

class _DirectSendViaQrScreen extends State<DirectSendViaQrScreen> {
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
      if(scanQr.isEmpty) {
        scanQr = scanData.code;
        await _handleNext();
        setState(() {});
      }
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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
      'processing-failed': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: ProcessingFailedDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return Scaffold(
      appBar: SubAppbarWidget(
        title: DIRECT_SEND_VIA_QR_SCREEN_TITLE,
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
            if(scanQr.isNotEmpty) ...[
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
                      )
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

  void _handleNext() async {
    try {
      var data = scanQr.split('/');
      if(data.length != 3) {
        print('No amount was entered');
        Vibration.vibrate(duration: 200);
        return null;
      }
      OverlayScreen().show(
        context,
        identifier: 'progress',
      );
      final a = await store.directPayService.getFees(
          data[2], data[0]);
      if(!a.status) {
        OverlayScreen().pop();
        OverlayScreen().show(
          context,
          identifier: 'processing-failed',
        );
        return null;
      }

      store.createTransaction(SwipeServiceOffering.DIRECT_SEND, "");
      store.setTransactionProduct(DirectPayProduct(
          name: '', mobileNumber: '${data[0]}', message: "", fee: a.fee, amount: double.tryParse(a.amount)),
          double.parse(a.amount));
      OverlayScreen().pop();
      Get.toNamed("/services/payment/payment-verification-screen");
    } catch(err) {}
  }
}

class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  _ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x507A3CDF),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    const lineSize = 50;

    final width = rect.width;
    final borderWidthSize = width * 10 / 100;
    final height = rect.height;
    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(
            rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right,
            rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height,
            rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(
            rect.right - borderSize.width,
            rect.top + borderSize.height,
            rect.right,
            rect.bottom - borderSize.height),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(
        borderSize.width + borderOffset,
        borderSize.height + borderOffset + rect.top,
        width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

      //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

      //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

      //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
