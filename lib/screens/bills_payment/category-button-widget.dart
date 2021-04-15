import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

class CategoryButtonWidget extends StatelessWidget {
  final String category;
  final Widget icon;
  final String text;
  final Function onPressed;

  const CategoryButtonWidget({
    Key key,
    @required this.category,
    @required this.text,
    @required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      child: Column(
        children: [
          IconButton(
            iconSize: MediaQuery.of(context).size.height * 0.08,
            color: COLOR_GRAY,
            icon: icon,
            onPressed: () {
              this.onPressed(category);
            },
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: GoogleFonts.roboto(color: Colors.black, fontSize: SizeConfig.blockSizeVertical * 1.7),
          )
        ],
      ),
    );
  }
}
