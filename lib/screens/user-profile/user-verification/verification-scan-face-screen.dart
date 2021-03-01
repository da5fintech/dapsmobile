import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationScanFace extends StatefulWidget {
  final cameras;

  VerificationScanFace({this.cameras});

  @override
  _VerificationScanFaceState createState() =>
      _VerificationScanFaceState();

}

class _VerificationScanFaceState extends State<VerificationScanFace> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
        widget.cameras,
        ResolutionPreset.high
    );
    _initializeControllerFuture = _controller.initialize();
    // _initializeControllerFuture = _controller.initialize().then((_) async {
    //   print('Image stream');
    //   await _controller.startImageStream((image) => print(image));
    // });
  }

  @override
  void dispose () {
    super.dispose();
    _controller.dispose();
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
              SizedBox(height: 30),
              FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width* 0.60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(color: COLOR_BLUE, width: 5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(200),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CameraPreview(_controller),

                            ),
                          ),
                        )
                      ],
                    );
                  } else {
                    return Center(child: CircularProgressIndicator(backgroundColor: COLOR_ORANGE));
                  }
                },
              )
            ],
          )
        )
      )
    );
  }

}