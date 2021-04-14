import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final Color color;
  const PrimaryButtonWidget({
    Key key,
    @required this.text,
    this.onPressed,
    this.padding,
    this.color = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: MediaQuery.of(context).devicePixelRatio * 18,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: MediaQuery.of(context).devicePixelRatio * 7, color: color)
        ),
      ),
    );
  }
}
