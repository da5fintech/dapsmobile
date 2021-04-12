import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class ServiceButtonWidget extends StatelessWidget {
  final SwipeServiceOffering offering;
  final Widget icon;
  final String text;
  final Function onPressed;

  const ServiceButtonWidget({
    Key key,
    @required this.offering,
    @required this.text,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          iconSize: MediaQuery.of(context).size.height * 0.065,
          color: COLOR_GRAY,
          icon: icon,
          onPressed: () {
            this.onPressed(offering);
          },
        ),
        Text(
          text,
          style: GoogleFonts.roboto(color: Colors.black),
        )
      ],
    );
  }
}
