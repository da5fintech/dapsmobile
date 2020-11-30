import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0

  MainAppBarWidget({Key key})
      : preferredSize = Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Icon(Icons.list),
      title: Text("SWIPE",
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
