import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;
  final Widget bottom;
  final double height;
  final List<Widget> actions;

  SubAppbarWidget(
      {Key key, @required this.title, this.bottom, this.height, this.actions})
      : preferredSize = Size.fromHeight(height ?? 56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            _handleBack();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),
      title: Text(title,
          style: GoogleFonts.roboto(fontSize: 20, fontWeight: FontWeight.w500)),
      actions: actions,
      bottom: bottom,
    );
  }

  void _handleBack() {
    Get.back();
  }
}
