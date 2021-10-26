
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/main.dart';
import 'package:daps/screens/user-profile/user-verification/verification-photo-id-screen.dart';
import 'package:daps/screens/user-profile/user-verification/verification-scan-face-screen.dart';
import 'package:daps/store/application-store.dart';

final store = getIt<ApplicationStore>();

class PhotoViewerScreen extends StatelessWidget {
  AppUtil _appUtil = AppUtil();
  File photo;
  String type;

  PhotoViewerScreen({this.photo, this.type});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'View',
          actions: [
            FlatButton.icon(
              onPressed: () {
                _retakePhoto(context);
              },
              icon: Icon(Icons.photo_camera, color: Colors.white),
              label: Text('Retake Photo', style: TextStyle(color: Colors.white))
            )
          ],
        ),
        body: Container(
          color: Colors.black.withOpacity(0.94),
          child: Center(
            child: RotatedBox(
              quarterTurns: type == 'id' ? 0 : 3,
              child: Image.file(
                File(photo.path),
                height: height * 0.60,
                width: width * 0.90,
                fit: BoxFit.fill,
              ),
            ),
          ),
        )
      )
    );
  }

  void _retakePhoto (context) async {
    if(type == 'id') {
      final cameras = await availableCameras();
      final firstCamera = cameras.first;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VerificationPhotoIdScreen(cameras: firstCamera, retake: true)),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => VerificationScanFace(retake: true))
      );
    }

  }
}