import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

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
    SizeConfig().init(context);
    return Column(
      children: [
        IconButton(
          color: COLOR_GRAY,
          icon: icon,
          iconSize: SizeConfig.blockSizeVertical * 7,
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
