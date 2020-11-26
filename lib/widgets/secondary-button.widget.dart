import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';

class SecondaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final bool showBorders;
  const SecondaryButtonWidget({
    Key key,
    @required this.text,
    this.onPressed,
    this.padding,
    this.showBorders = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
      onPressed: onPressed ?? () {},
      borderSide:
          showBorders ? BorderSide(color: Colors.white, width: 0.5) : null,
      splashColor: Colors.grey.shade600,
      highlightedBorderColor: Colors.grey,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: poppinsW500White14,
      ),
    );
  }
}
