import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/models/product-model.dart';

class PromoCircleAmountWidget extends StatelessWidget {
  final AirtimeProduct promo;
  const PromoCircleAmountWidget({
    Key key,
    this.promo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor = COLOR_GLOBE_BLUE;

    if (promo.network == Network.SMART) {
      bgColor = COLOR_SMART_GREEN;
    }

    return CircleAvatar(
      backgroundColor: COLOR_DARK_PURPLE,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            formatterInt.format(promo.amount),
            style: GoogleFonts.roboto(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
          ),
          Text(
            BUY_LOAD_PHP_TEXT,
            style: GoogleFonts.roboto(
                color: Colors.black.withOpacity(.87),
                fontSize: 8,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
