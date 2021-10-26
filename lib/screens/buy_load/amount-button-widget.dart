import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/models/product-model.dart';

class AmountButtonWidget extends StatefulWidget {
  final AirtimeProduct promo;
  final AirtimeProduct selectedPromo;
  final Function onPressed;

  const AmountButtonWidget({
    Key key,
    @required this.promo,
    @required this.selectedPromo,
    this.onPressed,
  }) : super(key: key);

  @override
  _AmountButtonWidgetState createState() => _AmountButtonWidgetState();
}

class _AmountButtonWidgetState extends State<AmountButtonWidget> {
  @override
  Widget build(BuildContext context) {
    var defaultFont1 = GoogleFonts.roboto(
        color: Colors.black.withOpacity(.87),
        fontSize: 20,
        fontWeight: FontWeight.w700);
    var defaultFont2 = GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: COLOR_DARK_PURPLE.withOpacity(.87));

    var selectedFont1 = GoogleFonts.roboto(
        color: Colors.white.withOpacity(.87),
        fontSize: 20,
        fontWeight: FontWeight.w700);

    var selectedFont2 = GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white.withOpacity(.87));

    var defaultColor = COLOR_DARK_PURPLE.withOpacity(.05);
    var selectedColor = COLOR_DARK_PURPLE.withOpacity(.87);

    var font1 = defaultFont1;
    var font2 = defaultFont2;
    var color = defaultColor;

    if (widget.selectedPromo != null &&
        widget.promo.code == widget.selectedPromo.code &&
        widget.promo.amount == widget.selectedPromo.amount) {
      font1 = selectedFont1;
      font2 = selectedFont2;
      color = selectedColor;
    }

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
            color: color,
            onPressed: () {
              widget.onPressed(widget.promo);
            },
            child: Column(
              children: [
                Text(
                  formatterInt.format(widget.promo.amount),
                  style: font1,
                ),
                Text(
                  BUY_LOAD_PHP_TEXT,
                  style: font2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
