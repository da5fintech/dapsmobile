import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/direct-send/direct-send-form-screen.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/size.config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:swipe/common/util.dart';

class ImportQrScreen extends StatefulWidget {
  const ImportQrScreen({Key key}) : super(key: key);

  @override
  _ImportQrScreenState createState() => _ImportQrScreenState();
}

class _ImportQrScreenState extends State<ImportQrScreen> {
  File _image;
  final picker = ImagePicker();
  FirebaseVisionImage visionImage;
  AppUtil _appUtil = AppUtil();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<String> decode() async {
    String qrCode;
    if(_image == null) return null;
    FirebaseVisionImage ourImage = FirebaseVisionImage.fromFile(_image);
    BarcodeDetector barcodeDetector = FirebaseVision.instance.barcodeDetector();
    List barCodes = await barcodeDetector.detectInImage(ourImage);

    for (Barcode readableCode in barCodes) {
      qrCode = readableCode.displayValue;
    }
    return qrCode;
  }

  @override
  Widget build(BuildContext context) {
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: "Import QR",
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Text(
              'Import QR code',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 3,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 20),
            _image == null ?
            Icon(
              Icons.photo,
              color: COLOR_DARK_PURPLE,
              size: SizeConfig.blockSizeVertical * 12,
            ) : Image.file(_image, height: SizeConfig.screenHeight * .60),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: RaisedButton.icon(
                elevation: 5,
                onPressed: getImage,
                color: Colors.grey[200],
                icon: Icon(Icons.upload_file, color: Colors.black),
                label: Text('Import', style: TextStyle(color: Colors.black)),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ButtonTheme(
                child: RaisedButton(
                  onPressed: () {
                    handleNext();
                  },
                  child: Text('Next', style: TextStyle(color: Colors.white))
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  Future<void> handleNext() async {
    modalHudLoad(context);
    String code = await decode();
    await Future.delayed(Duration(seconds: 2));
    Navigator.pop(context);
    if(code == null) {
      errorModal(context, title: "Failed to scan Image", message: "No Image was added");
      return null;
    }
    List a = code.split('/');
    NotificationModel notificationModel = new NotificationModel();
    notificationModel.senderMobileNumber =  a[0];
    notificationModel.senderDisplayName = a[1];
    notificationModel.amount = double.parse(a[2]);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => DirectSendFormScreen(notification: notificationModel)),
    );
  }
}
