import 'dart:io';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/size.config.dart';
import 'package:image_picker/image_picker.dart';

class ImportQrScreen extends StatefulWidget {
  const ImportQrScreen({Key key}) : super(key: key);

  @override
  _ImportQrScreenState createState() => _ImportQrScreenState();
}

class _ImportQrScreenState extends State<ImportQrScreen> {
  File _image;
  final picker = ImagePicker();

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
                onPressed: getImage,
                color: COLOR_DARK_PURPLE,
                icon: Icon(Icons.upload_file, color: Colors.white),
                label: Text('Import', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      )
    );
  }
}
