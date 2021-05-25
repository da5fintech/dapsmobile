import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';

class GCashOut extends StatefulWidget {
  @override
  _GcashOutState createState () =>
      _GcashOutState();
}

class _GcashOutState extends State<GCashOut> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.white),
              hintText: "904033902",
              errorStyle: TextStyle(
                  color: COLOR_GRAY,
                  fontSize: 12,
                  height: 0.3),
              labelText: REGISTER_SCREEN_MOBIILE_TEXT,
              floatingLabelBehavior: FloatingLabelBehavior
                  .always,
              prefix: Container(
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.white,
                      width: 0.5,
                    ),
                  ),
                ),
                child: Text(
                  '+63',
                  style: GoogleFonts.roboto(
                      color: Colors.black),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Enter GCash Account number',
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 1.5,
                fontWeight: FontWeight.w500,
                color: COLOR_DARK_GRAY,
                height: 2,
              ),
            ),
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.white),
              hintText: "₱ 1,000.00",
              errorStyle: TextStyle(
                  color: COLOR_GRAY,
                  fontSize: 12,
                  height: 0.3),
              labelText: 'Amount',
              floatingLabelBehavior: FloatingLabelBehavior
                  .always,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'The Amount you can Cash in is ₱500.00 - ₱ 50,000.00',
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 1.5,
                fontWeight: FontWeight.w500,
                color: COLOR_DARK_GRAY,
                height: 2,
              ),
            ),
          ),
          TextFormField(
            // readOnly: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              counterStyle: TextStyle(color: Colors.white),
              hintText: "₱10.00",
              errorStyle: TextStyle(
                  color: COLOR_GRAY,
                  fontSize: 12,
                  height: 0.3),
              labelText: 'Fees',
              floatingLabelBehavior: FloatingLabelBehavior
                  .always,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Service Fee for every transaction is ₱10.00',
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 1.5,
                fontWeight: FontWeight.w500,
                color: COLOR_DARK_GRAY,
                height: 2,
              ),
            ),
          ),
          Spacer(),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              child: Text('Cash Out'),
            ),
          )
        ],
      ),
    );
  }


}