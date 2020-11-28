import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return OutlineButton(
      borderSide: BorderSide(color: Colors.white, width: 1),
      onPressed: onPressed,
      child: Text(
        text,
        style: GoogleFonts.roboto(color: Colors.white),
      ),
    );
  }
}
