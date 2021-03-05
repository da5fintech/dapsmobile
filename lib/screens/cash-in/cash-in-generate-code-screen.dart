import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/store/application-store.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';

final store = getIt<ApplicationStore>();

class CashInGenerateCodeScreen extends StatefulWidget {
  String amount;
  String referenceNumber;

  CashInGenerateCodeScreen({this.referenceNumber, this.amount});

  @override
  _CashInGenerateCodeScreenState createState() =>
      _CashInGenerateCodeScreenState();
}

class _CashInGenerateCodeScreenState extends State<CashInGenerateCodeScreen> {
  String barcodeData;
  String barcodeNumber;

  @override
  void initState() {
    barcodeNumber = widget.referenceNumber;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    ThemeData td = createThemePurpleOnWhite(context);
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
                        text: 'PHP ${widget.amount}',
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
                width: width,
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
                    '13209293',
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
                  'valid until 01\nMarch 2021 3:05:15 PM',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    color: Colors.black,
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
                    onPressed: () {},
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
