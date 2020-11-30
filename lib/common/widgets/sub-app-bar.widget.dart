import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SubAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final String title;

  SubAppbarWidget({Key key, @required this.title})
      : preferredSize = Size.fromHeight(kToolbarHeight),
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
          style: GoogleFonts.roboto(
              fontSize: 14, fontWeight: FontWeight.w800, letterSpacing: 2)),
      actions: [],
    );
  }

  void _handleBack() {
    Get.back();
  }
}
