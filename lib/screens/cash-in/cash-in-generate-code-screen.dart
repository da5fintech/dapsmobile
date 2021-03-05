import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
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

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(title: 'Cash in via Code'),
        body: Container(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Please show one of these codes to the\ncashier of any participating merchant to cash in.',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: 14,
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
                      fontSize: 14,
                      height: 1.5,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'PHP ${widget.product.amount}',
                        style: GoogleFonts.roboto(
                          color: COLOR_DARK_PURPLE,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: height * 0.10,
                width: width * 0.60,
                child: SfBarcodeGenerator(
                  value: barcodeNumber,
                ),
              ),
              SizedBox(height: height * 0.02),
              Text(
                barcodeNumber,
                style: GoogleFonts.roboto(
                  fontSize: 12,
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
                      fontSize: 20,
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
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
              RaisedButton(
                elevation: 0,
                // shape: ,
                onPressed: () {},
                child: Text(
                  'DOWNLOAD',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
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
                  child: RaisedButton(
                    elevation: 0,
                    // shape: ,
                    onPressed: () {
                      Get.offAllNamed('/services');
                    },
                    child: Text(
                      'DONE',
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
    );
  }
}
