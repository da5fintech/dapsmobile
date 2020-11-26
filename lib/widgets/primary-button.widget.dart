import 'package:swipe/common/constants.dart';
import 'package:flutter/material.dart';

class PrimaryButtonWidget extends StatelessWidget {
  final String text;
  final Function onPressed;
  final EdgeInsets padding;
  final bool expand;
  const PrimaryButtonWidget(
      {Key key,
      @required this.text,
      this.onPressed,
      this.padding,
      this.expand = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var btn = Container(
      height: 40,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff003F5C), Color(0xff0679AD)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(8.0)),
      child: FlatButton(
        disabledColor: Colors.blueGrey.shade300,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: poppinsW500White14,
        ),
      ),
    );
    if (expand) {
      return Expanded(child: btn);
    } else {
      return btn;
    }
  }
}
