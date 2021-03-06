import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/main.dart';
import 'package:daps/models/UserVerificationModel.dart';
import 'package:daps/screens/user-profile/user-verification/verification-review-information-screen.dart';
import 'package:daps/store/application-store.dart';

final store = getIt<ApplicationStore>();

class VerificationPhotoIdScreen extends StatefulWidget {
  final cameras;
  bool retake;

  VerificationPhotoIdScreen({this.cameras, this.retake = false});

  @override
  _VerificationPhotoIdScreenState createState() =>
      _VerificationPhotoIdScreenState();
}

class _VerificationPhotoIdScreenState extends State<VerificationPhotoIdScreen> {
  AppUtil _appUtil = AppUtil();
  CameraController _controller;
  Future<void> _initializeControllerFuture;
  bool shutter = false;
  File front;
  String back;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _controller != null
          ? _initializeControllerFuture = _controller.initialize()
          : null; //on pause camera is disposed, so we need to call again "issue is only for android"
    }
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
          title: VERIFICATION_PHOTO,
          actions: [
            FlatButton.icon(
              onPressed: () {
                Get.toNamed(
                    '/user-profile/user-verification/verification-id-list');
              },
              icon: Icon(Icons.list, color: Colors.white),
              label: Text(
                VERIFICATION_VALID_ID,
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
                        ? FutureBuilder<void>(
                            future: _initializeControllerFuture,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return CameraPreview(_controller);
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          )
                        : Image.file(
                            File(front.path),
                            fit: BoxFit.fill,
                            width: width,
                          ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          VERFICATION_FRONT_ID,
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
                              VERIFICATION_PLACE_ID,
                              style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical * 2.2,
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
                              radius: SizeConfig.blockSizeVertical * 5,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: SizeConfig.blockSizeVertical * 4.5,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: SizeConfig.blockSizeVertical * 4,
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
                              VERIFICATION_PROCEED_id,
                              style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical * 2.2,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 0, left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ButtonTheme(
                                height: SizeConfig.blockSizeVertical * 5,
                                buttonColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                child: RaisedButton(
                                  // shape: ,
                                  onPressed: () async {
                                    if (!widget.retake) {
                                      Get.toNamed(
                                          '/user-profile/user-verification/verification-scan-face-boarding');
                                    } else {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text(
                                    VERIFICATION_NEXT,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.blockSizeVertical * 2,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 0, left: 15, right: 15),
                            child: SizedBox(
                              width: double.infinity,
                              child: ButtonTheme(
                                height: SizeConfig.blockSizeVertical * 5,
                                buttonColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                ),
                                child: RaisedButton(
                                  // shape: ,
                                  onPressed: () async {
                                    await _appUtil.deleteImage(front.path);
                                    setState(() {
                                      front = null;
                                    });
                                  },
                                  child: Text(
                                    VERIFICATION_RETAKE_PHOTO,
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize: SizeConfig.blockSizeVertical * 2,
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
    try {
      _cameraShutter();
      await _initializeControllerFuture;
      final path = join(
        (await getApplicationDocumentsDirectory()).path,
        '${_appUtil.generateUid()}.png',
      );
      XFile file = await _controller.takePicture();
      store.verification.id = File(file.path);
      store.setId(store.verification.id);
      setState(() {
        front = File(file.path);
      });
    } catch (err) {
      rethrow;
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
