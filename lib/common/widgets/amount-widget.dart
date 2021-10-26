import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/size.config.dart';

import '../constants.dart';

class AmountWidget extends StatelessWidget {
  final double amount;

  const AmountWidget({
    Key key,
    @required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(SizeConfig.blockSizeVertical * 3);
    SizeConfig().init(context);
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(top: 3),
            child: Text("PHP",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.blockSizeVertical * 1.5,
                    color: Colors.white)),
          ),
          Text(formatterWithoutPHP.format(amount),
              style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w700,
                  fontSize:  SizeConfig.blockSizeVertical * 3,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
