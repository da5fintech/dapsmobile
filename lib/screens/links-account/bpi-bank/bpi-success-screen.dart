import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class BpiSuccessScreen extends StatefulWidget {
  @override
  _BpiSuccessScreenState createState() => _BpiSuccessScreenState();
}

class _BpiSuccessScreenState extends State<BpiSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        backgroundColor: COLOR_DARK_PURPLE,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  height: SizeConfig.screenHeight * .40,
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Stack(
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: SizeConfig.blockSizeVertical * 3),
                                Icon(Icons.check_circle,
                                  size: SizeConfig.blockSizeVertical * 7, color: COLOR_GREEN),
                                Text(
                                  'Transfer Successful!',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: COLOR_GREEN,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
                                    fontWeight: FontWeight.w700,
                                  )
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                    'Transaction Number: 50228281',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                      color: Colors.grey[500],
                                      fontSize: SizeConfig.blockSizeVertical * 1.7,
                                      fontWeight: FontWeight.w300,
                                    )
                                ),
                                Spacer(),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                  title: Text(
                                    'Amount:',
                                    style: GoogleFonts.roboto(
                                      fontSize: SizeConfig.blockSizeVertical * 2,
                                      color: Colors.grey[500],
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                                  trailing: Text(
                                      '10.00',
                                      style: GoogleFonts.roboto(
                                          fontSize: SizeConfig.blockSizeVertical * 2,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                  title: Text(
                                      'Date:',
                                      style: GoogleFonts.roboto(
                                          fontSize: SizeConfig.blockSizeVertical * 2,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  trailing: Text(
                                      'January 21, 2021',
                                      style: GoogleFonts.roboto(
                                          fontSize: SizeConfig.blockSizeVertical * 2,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),
                                ListTile(
                                  visualDensity: VisualDensity(vertical: -4, horizontal: -4),
                                  title: Text(
                                      'Bank:',
                                      style: GoogleFonts.roboto(
                                          fontSize: SizeConfig.blockSizeVertical * 2,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                  trailing: Text(
                                      'Bank of the Philippines Islands',
                                      style: GoogleFonts.roboto(
                                          fontSize: SizeConfig.blockSizeVertical * 2,
                                          color: Colors.grey[500],
                                          fontWeight: FontWeight.bold
                                      )
                                  ),
                                ),

                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 1.5,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: COLOR_DARK_PURPLE,
                      shape: BoxShape.circle
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      color: COLOR_DARK_PURPLE,
                      shape: BoxShape.circle
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
