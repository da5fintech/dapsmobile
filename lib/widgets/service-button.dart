import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class ServiceButtonWidget extends StatelessWidget {
  final Icon icon;
  final String text;
  final Function onPressed;

  const ServiceButtonWidget({
    Key key,
    @required this.text,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          color: COLOR_GRAY,
          icon: icon,
          onPressed: () {},
        ),
        Text(
          text,
          style: GoogleFonts.roboto(color: Colors.black),
        )
      ],
    );
  }
}
