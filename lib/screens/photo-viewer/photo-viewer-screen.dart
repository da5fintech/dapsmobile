
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-photo-id-screen.dart';
import 'package:swipe/screens/user-profile/user-verification/verification-scan-face-screen.dart';
import 'package:swipe/store/application-store.dart';

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
              quarterTurns: 3,
              child: Image.asset(
                photo.path,
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