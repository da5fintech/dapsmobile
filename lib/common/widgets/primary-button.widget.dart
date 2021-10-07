import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final Color color;
  final Color colorText;
  const PrimaryButtonWidget({
    Key key,
    @required this.text,
    this.onPressed,
    this.padding,
    this.color = COLOR_DARK_PURPLE,
    this.colorText = COLOR_DAPS,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      buttonColor: color,
      height: SizeConfig.blockSizeVertical * 5,
      child: RaisedButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(fontSize: SizeConfig.blockSizeVertical * 2, color: colorText)
        ),
      ),
    );
  }
}
