import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class DirectSendViaQrScreen extends StatefulWidget {
  var camera;

  DirectSendViaQrScreen({this.camera});

  @override
  _DirectSendViaQrScreen createState() => _DirectSendViaQrScreen();
}

class _DirectSendViaQrScreen extends State<DirectSendViaQrScreen> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: SubAppbarWidget(
        title: 'Send Via QR',
      ),
        body: FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: height,
            width: width,
            child: Stack(
              children: [
                Positioned.fill(
                  child: new AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: new CameraPreview(_controller)),
                ),
                Container(
                  decoration: ShapeDecoration(
                    shape: _ScannerOverlayShape(
                      borderColor: COLOR_ORANGE,
                      borderWidth: 3.0,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Align QR code to the frame and press\n'
                      'proceed to start scanning.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        height: 2,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )
                    )
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.refresh, color: Colors.white),
                    label: Text('Re-scan QR code', style: TextStyle(color: Colors.white))
                  )
                )
              ],
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}

class _ScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderWidth;
  final Color overlayColor;

  _ScannerOverlayShape({
    this.borderColor = Colors.white,
    this.borderWidth = 1.0,
    this.overlayColor = const Color(0x507A3CDF),
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(10.0);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    Path _getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }

    return _getLeftTopPath(rect)
      ..lineTo(
        rect.right,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.bottom,
      )
      ..lineTo(
        rect.left,
        rect.top,
      );
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    const lineSize = 50;

    final width = rect.width;
    final borderWidthSize = width * 10 / 100;
    final height = rect.height;
    final borderHeightSize = height - (width - borderWidthSize);
    final borderSize = Size(borderWidthSize / 2, borderHeightSize / 2);

    var paint = Paint()
      ..color = overlayColor
      ..style = PaintingStyle.fill;

    canvas
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top, rect.right, borderSize.height + rect.top),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.bottom - borderSize.height, rect.right, rect.bottom),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.left, rect.top + borderSize.height, rect.left + borderSize.width, rect.bottom - borderSize.height),
        paint,
      )
      ..drawRect(
        Rect.fromLTRB(rect.right - borderSize.width, rect.top + borderSize.height, rect.right, rect.bottom - borderSize.height),
        paint,
      );

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderOffset = borderWidth / 2;
    final realReact = Rect.fromLTRB(borderSize.width + borderOffset, borderSize.height + borderOffset + rect.top, width - borderSize.width - borderOffset,
        height - borderSize.height - borderOffset + rect.top);

    //Draw top right corner
    canvas
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.top)
            ..lineTo(realReact.right - lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.top)],
        paint,
      )

    //Draw top left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left, realReact.top + lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.top)
            ..lineTo(realReact.left + lineSize, realReact.top),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.top)],
        paint,
      )

    //Draw bottom right corner
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.right, realReact.bottom)
            ..lineTo(realReact.right - lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.right, realReact.bottom)],
        paint,
      )

    //Draw bottom left corner
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left, realReact.bottom - lineSize),
          paint)
      ..drawPath(
          Path()
            ..moveTo(realReact.left, realReact.bottom)
            ..lineTo(realReact.left + lineSize, realReact.bottom),
          paint)
      ..drawPoints(
        PointMode.points,
        [Offset(realReact.left, realReact.bottom)],
        paint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return _ScannerOverlayShape(
      borderColor: borderColor,
      borderWidth: borderWidth,
      overlayColor: overlayColor,
    );
  }
}
