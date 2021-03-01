import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class VerificationPhotoIdScreen extends StatefulWidget {
  final cameras;

  VerificationPhotoIdScreen({this.cameras});

  @override
  _VerificationPhotoIdScreenState createState() =>
      _VerificationPhotoIdScreenState();
}

class _VerificationPhotoIdScreenState extends State<VerificationPhotoIdScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras, ResolutionPreset.high);

    _initializeControllerFuture = _controller.initialize();
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
    return Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            title: 'Take ID Photo',
          ),
          body: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: CameraPreview(_controller),
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
                                    border:
                                        Border.all(color: COLOR_BLUE, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                )
                              ],
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
                        child: Column(
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
                                print('PHOTO taken');
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
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                        backgroundColor: COLOR_ORANGE));
              }
            },
          ),
        ));
  }
}
