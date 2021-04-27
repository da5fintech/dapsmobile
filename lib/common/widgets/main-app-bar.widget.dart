import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final double elevation;
  final Function onPressed;
  double queryData;

  MainAppBarWidget({Key key, this.elevation, this.onPressed, this.queryData})
      : preferredSize = Size.fromHeight(queryData * 25),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.list, size: queryData * 12),
          onPressed: () {
            onPressed('drawer');
          }),
      title: Text(APP_NAME,
          style: GoogleFonts.roboto(
              fontSize: queryData * 6, fontWeight: FontWeight.w800, letterSpacing: 15)),
      actions: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            onPressed('notification');
          },
          icon: Icon(
            Icons.notifications,
            size: queryData * 8,
          ),
        ),
        SizedBox(
          width: queryData * 5,
        )
      ],
    );
  }
}
