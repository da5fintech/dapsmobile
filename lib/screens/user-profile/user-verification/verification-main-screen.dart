import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationMainScreen extends StatefulWidget {
  var cameras;

  VerificationMainScreen({this.cameras});

  @override
  _VerificationMainScreenState createState() =>
      _VerificationMainScreenState();

}

class _VerificationMainScreenState extends State<VerificationMainScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.cameras,
      ResolutionPreset.high
    );

    _initializeControllerFuture = _controller.initialize().then((_) async {
      print('Image stream');
      await _controller.startImageStream((image) => print(image));
    });
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
          title: "User Verification",
        ),
        body: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: new AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  )
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator(backgroundColor: COLOR_ORANGE));
            }
          },
        ),
      )
    );
  }
}