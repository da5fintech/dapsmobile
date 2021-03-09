import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

typedef HandleDetection = Future<List<Face>> Function(
    FirebaseVisionImage image);

class VerificationScanFace extends StatefulWidget {
  final cameras;

  VerificationScanFace({this.cameras});

  @override
  _VerificationScanFaceState createState() => _VerificationScanFaceState();
}

class _VerificationScanFaceState extends State<VerificationScanFace> {
  double loader = 0.00;
  CameraController _camera;
  List<Face> faces;
  bool _isDetecting = false;
  ImageRotation rotation;
  CameraLensDirection _direction = CameraLensDirection.front;
  final FaceDetector faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.accurate,
          enableClassification: true,
          enableLandmarks: true,
          enableContours: true,
          enableTracking: true));

  @override
  void initState() {
    super.initState();
    _initializeCamera();

    Future.delayed(Duration(seconds: 2), () {
      Get.toNamed('/user-profile/user-verification/verification-user-information-screen');
    });
  }

  void _initializeCamera() async {
    CameraDescription description = await getCamera(_direction);
    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.high
          : ResolutionPreset.ultraHigh,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      detect(image, faceDetector.processImage, rotation).then(
        (dynamic result) {
          setState(() {
            faces = result;
          });

          if (faces[0].rightEyeOpenProbability < 0.90 &&
              faces[0].leftEyeOpenProbability < 0.90) {
            double incrementLoader = 0.15;
            setState(() {
              loader = loader + incrementLoader;
            });
          }

          _isDetecting = false;
        },
      ).catchError(
        (_) {
          _isDetecting = false;
        },
      );
    });
  }

  Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return await availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  ImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 0:
        return ImageRotation.rotation0;
      case 90:
        return ImageRotation.rotation90;
      case 180:
        return ImageRotation.rotation180;
      default:
        assert(rotation == 270);
        return ImageRotation.rotation270;
    }
  }

  Future<List<Face>> detect(CameraImage image, HandleDetection handleDetection,
      ImageRotation rotation) async {
    return handleDetection(
      FirebaseVisionImage.fromBytes(
        concatenatePlanes(image.planes),
        buildMetaData(image, rotation),
      ),
    );
  }

  Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    planes.forEach((Plane plane) => allBytes.putUint8List(plane.bytes));
    return allBytes.done().buffer.asUint8List();
  }

  FirebaseVisionImageMetadata buildMetaData(
    CameraImage image,
    ImageRotation rotation,
  ) {
    return FirebaseVisionImageMetadata(
      rawFormat: image.format.raw,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      rotation: rotation,
      planeData: image.planes.map(
        (Plane plane) {
          return FirebaseVisionImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    _camera.stopImageStream();
    _camera.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Scan Face',
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Please blink your eyes',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: COLOR_DARK_PURPLE,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: AnimatedContainer(
                  duration: Duration(seconds: 1),
                  height: 30,
                  width: MediaQuery.of(context).size.width * loader,
                  decoration: BoxDecoration(
                    color: COLOR_DARK_PURPLE,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 30),
              _camera == null
                  ? Center(
                      child: CircularProgressIndicator(
                          backgroundColor: COLOR_ORANGE))
                  : Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: COLOR_BLUE, width: 5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CameraPreview(_camera),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
