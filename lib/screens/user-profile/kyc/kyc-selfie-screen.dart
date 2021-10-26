import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:image_picker/image_picker.dart';

class KycSelfieScreen extends StatefulWidget {
  @override
  _KycSelfieScreenState createState() => _KycSelfieScreenState();
}

class _KycSelfieScreenState extends State<KycSelfieScreen> {
  File _image;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            'Add your Selfie',
            style: GoogleFonts.roboto(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: _image == null ? Icon(
              Icons.account_circle,
              size: 150,
              color: COLOR_DARK_PURPLE.withOpacity(0.3),
            ) : CircleAvatar(
              radius: 75,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.file(
                  _image,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
              ),
            ) ,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                flex: 1,
                child: ButtonTheme(
                    minWidth: 160,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: COLOR_DARK_PURPLE,
                      ),
                    ),
                  child: RaisedButton.icon(
                    color: Colors.white,
                    onPressed: () async {
                      // File image = await ImagePicker.pickImage(
                      //     source: ImageSource.camera, imageQuality: 50
                      // );
                      // _image = image;
                      setState(() {});
                    },
                    icon: Icon(Icons.camera_alt, color: COLOR_DARK_PURPLE),
                    label: Text(
                      'TAKE A PHOTO',
                      style: GoogleFonts.roboto(
                        color: COLOR_DARK_PURPLE,
                      )
                    ),
                  )
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                flex: 1,
                child: ButtonTheme(
                  minWidth: 160,
                  child: RaisedButton(
                    onPressed: () async {
                      //  File image = await ImagePicker.pickImage(
                      //     source: ImageSource.gallery, imageQuality: 50
                      // );
                      // _image = image;
                       setState(() {});
                    },
                    color: COLOR_DARK_PURPLE,
                    child: Text(
                      'CHOOSE FILE',
                      style: GoogleFonts.roboto(
                        color: Colors.white,
                      )
                    )
                  ),
                )
              ),
            ],
          )
        ],
      ),
    );
  }
}
