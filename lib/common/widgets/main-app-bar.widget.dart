import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final double elevation;
  final Function onPressed;

  MainAppBarWidget({Key key, this.elevation, this.onPressed})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      leading: IconButton(
          icon: Icon(Icons.list),
          onPressed: () {
            onPressed();
          }),
      title: Text(APP_NAME,
          style: GoogleFonts.roboto(
              fontSize: 12, fontWeight: FontWeight.w800, letterSpacing: 15)),
      actions: [
        Icon(
          Icons.notifications,
          size: 16,
        ),
        SizedBox(
          width: 10,
        )
      ],
    );
  }
}
