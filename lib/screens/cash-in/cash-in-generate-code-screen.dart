import 'dart:ui';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/main.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/store/application-store.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

final store = getIt<ApplicationStore>();

class CashInGenerateCodeScreen extends StatefulWidget {
  CashInProduct product;

  CashInGenerateCodeScreen({this.product});

  @override
  _CashInGenerateCodeScreenState createState() =>
      _CashInGenerateCodeScreenState();
}

class _CashInGenerateCodeScreenState extends State<CashInGenerateCodeScreen> {
  String barcodeNumber;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    barcodeNumber = widget.product.referenceNumber;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeData td = createThemePurpleOnWhite(context);
    DateTime timestamps = widget.product.timestamp;
    DateTime validUntil = timestamps.add(Duration(hours: 3));
    String formatDate = DateFormat("dd MMMM yyyy").add_jm().format(validUntil);


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
            Text(
              "Processing...",
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
    });

    return Theme(
      data: td,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SubAppbarWidget(title: CASH_IN_VIA_CODE),
        body: SingleChildScrollView(
          child: Container(
            height: height,
            width: width,
            padding: EdgeInsets.symmetric(vertical: height * 0.02, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  CASH_IN_VIA_CODE_SUBNOTE,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    color: COLOR_DARK_GRAY,
                    height: 1.5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.05),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "The amount of\n",
                      style: GoogleFonts.roboto(
                        color: Colors.black,
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        height: 1.5,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'PHP ${widget.product.amount}',
                          style: GoogleFonts.roboto(
                            color: COLOR_DARK_PURPLE,
                            fontWeight: FontWeight.w500,
                            fontSize: SizeConfig.blockSizeVertical * 2.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height * 0.25,
                  width: width * 0.60,
                  child: Center(
                    child: QrImage(
                      data: barcodeNumber,
                      size: height * 0.25,
                      // embeddedImage: AssetImage('assets/images/ic_launcher.png'),
                      // embeddedImageEmitsError: true,
                    ),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Text(
                  barcodeNumber,
                  style: GoogleFonts.roboto(
                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                    letterSpacing: 2,
                    color: COLOR_DARK_GRAY,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: height * 0.05),
                Container(
                  height: height * 0.12,
                  width: width * 0.50,
                  decoration: BoxDecoration(
                    color: COLOR_DARK_PURPLE.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Center(
                    child: Text(
                      barcodeNumber,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w500,
                        fontSize: SizeConfig.blockSizeVertical * 2.5,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.05, bottom: height * 0.01),
                  child: Text(
                    'valid until\n${formatDate}',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      color: COLOR_DARK_GRAY,
                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                      height: 1.5,
                    ),
                  ),
                ),
                ButtonTheme(
                  height: SizeConfig.blockSizeVertical * 5,
                  buttonColor: COLOR_DAPS,
                  child: RaisedButton(
                    elevation: 0,
                    // shape: ,
                    onPressed: _downloadBarcode,
                    child: Text(
                      CASH_IN_VIA_CODE_DOWLOAD,
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                ButtonTheme(
                  buttonColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.5, color: COLOR_DARK_PURPLE),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: SizeConfig.blockSizeVertical * 5,
                    child: RaisedButton(
                      elevation: 0,
                      // shape: ,
                      onPressed: () {
                        Get.offAllNamed('/services');
                      },
                      child: Text(
                        CASH_IN_VIA_CODE_DONE,
                        style: GoogleFonts.roboto(
                          color: COLOR_DARK_PURPLE,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _downloadBarcode () async {
    OverlayScreen().show(
      context,
      identifier: 'progress',
    );
    await NativeScreenshot.takeScreenshot();
    await Future.delayed(Duration(seconds: 3));

    OverlayScreen().pop();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(CASH_IN_DOWNLOAD_CODE), backgroundColor: COLOR_GREEN),
    );
    // print('downloading');
    // RenderRepaintBoundary boundary = _key.currentContext.findRenderObject();
    // var image = await boundary.toImage();
    // var byteData = await image.toByteData(format: ImageByteFormat.png);
    // var pngBytes = byteData.buffer.asUint8List();
    // print(pngBytes);
    // print('save');
  }
}
