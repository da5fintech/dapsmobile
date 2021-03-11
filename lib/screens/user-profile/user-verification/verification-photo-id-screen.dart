import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/UserVerificationModel.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class VerificationPhotoIdScreen extends StatefulWidget {
  final cameras;

  VerificationPhotoIdScreen({this.cameras});

  @override
  _VerificationPhotoIdScreenState createState() =>
      _VerificationPhotoIdScreenState();
}

class _VerificationPhotoIdScreenState extends State<VerificationPhotoIdScreen> {
  AppUtil _appUtil = AppUtil();
  CameraController _controller;
  bool shutter = false;
  File front;
  String back;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras, ResolutionPreset.medium);
    _controller.initialize().then((_) async {
      if (!mounted) {
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
          title: 'Take ID Photo',
          actions: [
            FlatButton.icon(
              onPressed: () {
                Get.toNamed(
                    '/user-profile/user-verification/verification-id-list');
              },
              icon: Icon(Icons.list, color: Colors.white),
              label: Text(
                'Valid IDs',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Flexible(
              flex: 2,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: front == null
                        ? CameraPreview(_controller)
                        : Image.asset(front.path,
                            fit: BoxFit.fill, width: width),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Front of ID',
                          style: GoogleFonts.roboto(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          height: height * 0.30,
                          width: width * 0.90,
                          decoration: BoxDecoration(
                            border: Border.all(color: COLOR_BLUE, width: 2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        )
                      ],
                    ),
                  ),
                  AnimatedOpacity(
                    duration: Duration(milliseconds: 50),
                    opacity: shutter ? 0.5 : 0,
                    child: Container(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: front == null
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Place you ID within the frame and take a photo.',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _takePhoto(context);
                              // Get.toNamed(
                              //     '/user-profile/user-verification/verification-scan-face-boarding');
                            },
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 28,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    : Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Would you like to Proceed using this ID?',
                              style: GoogleFonts.roboto(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ButtonTheme(
                                buttonColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                child: RaisedButton(
                                  // shape: ,
                                  onPressed: () async {
                                    Get.toNamed(
                                        '/user-profile/user-verification/verification-scan-face-boarding');
                                  },
                                  child: Text(
                                    'NEXT',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 10, left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ButtonTheme(
                                buttonColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                child: RaisedButton(
                                  // shape: ,
                                  onPressed: () async {
                                    setState(() {
                                      front = null;
                                    });
                                  },
                                  child: Text(
                                    'Retake Photo',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _takePhoto(context) async {
    store.verification = UserVerificationModel();
    try {
      if (_controller.value.isTakingPicture) return null;

      _cameraShutter();

      OverlayScreen().show(context, identifier: 'progress');

      final path = join(
        (await getTemporaryDirectory()).path,
        '${_appUtil.generateUid()}.png',
      );

      await _controller.takePicture(path);
      store.verification.id = File(path);
      OverlayScreen().pop();
      setState(() {
        front = File(path);
      });
    } catch (err) {
      print(err);
    }
  }

  void _cameraShutter() async {
    await Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        shutter = true;
      });
    });
    await Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        shutter = false;
      });
    });
  }
}
