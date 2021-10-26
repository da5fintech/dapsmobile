import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
// import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/main.dart';
import 'package:daps/store/application-store.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

final store = getIt<ApplicationStore>();

// typedef HandleDetection = Future<List<Face>> Function(
//     FirebaseVisionImage image);

class VerificationScanFace extends StatefulWidget {
  final cameras;
  bool retake;

  VerificationScanFace({this.cameras, this.retake = false});

  @override
  _VerificationScanFaceState createState() => _VerificationScanFaceState();
}

class _VerificationScanFaceState extends State<VerificationScanFace> {
  AppUtil _appUtil = AppUtil();
  double loader = 0.00;
  CameraController _camera;
  List<Face> faces;
  bool _isDetecting = false;
  bool stopScan = true;
  InputImageRotation rotation;
  String path;
  CameraLensDirection _direction = CameraLensDirection.front;
  final FaceDetector faceDetector = GoogleMlKit.vision.faceDetector(
      FaceDetectorOptions(
          mode: FaceDetectorMode.accurate,
          enableClassification: true,
          enableLandmarks: true,
          enableContours: true,
          enableTracking: true));

  @override
  void initState() {
    super.initState();
    getPath();
    if(widget.retake) _appUtil.deleteImage(store.verification.face.path);
    if(mounted) {
      _initializeCamera();
    }
  }

  Future<void> getPath() async {
    final directory = await getTemporaryDirectory();
    setState(() {
      path = directory.path;
    });
  }

  void _initializeCamera() async {
    CameraDescription description = await _appUtil.getCamera(_direction);
    InputImageRotation rotation = _appUtil.rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera = CameraController(
      description,
      defaultTargetPlatform == TargetPlatform.iOS
          ? ResolutionPreset.ultraHigh
          : ResolutionPreset.veryHigh,
    );
    await _camera.initialize();

    _camera.startImageStream((CameraImage image) {
      if (_isDetecting) return;

      _isDetecting = true;

      _appUtil.detect(image, faceDetector.processImage, rotation).then(
        (dynamic result) async {
          setState(() {
            faces = result;
          });
          print(faces);

          // loader reach 100% capture face
          if (loader >= 1.00 && stopScan) {
            stopScan = false;
            _isDetecting = false;
            final a = await _appUtil.convertImagetoPng(image);
            Uint8List bytes = Uint8List.fromList(a);
            store.verification.face =
                await File('${path}/${_appUtil.generateUid()}.png').writeAsBytes(bytes);
            store.setFace(store.verification.face);
            print(store.faceImage.path);
            setState(() {});
            _camera.stopImageStream();
            if(!widget.retake) {
              Get.toNamed(
                  '/user-profile/user-verification/verification-user-information-screen');
            } else {
              Navigator.pop(context);
              Navigator.pop(context);
            }
          }

          //check eyes blink
          if (faces[0].rightEyeOpenProbability < 0.1 &&
              faces[0].leftEyeOpenProbability < 0.1) {
            double incrementLoader = 0.15;
            print(loader);
            setState(() {
              loader = loader <= 1.00 ? loader + incrementLoader : 1.00;
              // loader =  loader + incrementLoader ;
            });
          }

          _isDetecting = false;
          setState(() {});
        },
      ).catchError(
        (_) {
          _isDetecting = false;
        },
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    // _controller.dispose();
    _camera.dispose();
    _camera.stopImageStream();
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
                          height: MediaQuery.of(context).size.height * 0.35,
                          width: MediaQuery.of(context).size.width * 0.65,
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
