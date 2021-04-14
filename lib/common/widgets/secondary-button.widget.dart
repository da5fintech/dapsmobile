import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  const SecondaryButtonWidget({
    Key key,
    @required this.text,
    this.onPressed,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: MediaQuery.of(context).devicePixelRatio * 18,
      child: OutlineButton(
        borderSide: BorderSide(color: COLOR_DARK_PURPLE, width: 1.5),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
