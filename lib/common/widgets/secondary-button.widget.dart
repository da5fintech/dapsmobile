import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';

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
      height: SizeConfig.blockSizeVertical * 5,
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.white, width: 1.5),
        onPressed: onPressed,
        child: Text(
          text,
          style: GoogleFonts.roboto(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
