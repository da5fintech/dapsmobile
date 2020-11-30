import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';

class AmountButtonWidget extends StatelessWidget {
  final int amount;
  final Function onPressed;

  const AmountButtonWidget({
    Key key,
    @required this.amount,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 60,
      child: Column(
        children: [
          FlatButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              padding: EdgeInsets.only(left: 5, top: 15, bottom: 15, right: 5),
              color: COLOR_DARK_PURPLE.withOpacity(.05),
              onPressed: onPressed,
              child: Column(
                children: [
                  Text(
                    amount.toString(),
                    style: GoogleFonts.roboto(
                        color: Colors.black.withOpacity(.87),
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "PHP",
                    style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: COLOR_DARK_PURPLE.withOpacity(.87)),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
