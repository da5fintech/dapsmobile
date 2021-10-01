import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/size.config.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double appHeaderContainerSize = SizeConfig.screenHeight * .50;
    return Align(
      alignment: Alignment.bottomCenter,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        margin: EdgeInsets.symmetric(
            horizontal: SizeConfig.blockSizeVertical * 6),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: appHeaderContainerSize * .50,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/bg-image.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Account',
                style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: SizeConfig.blockSizeVertical * 3),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerLeft,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: Icon(Icons.sim_card,
                      color: Colors.white,
                      size: SizeConfig.blockSizeVertical * 5),
                ),
              ),
              ListTile(
                title: Text('**** **** **43 2012',
                    style: GoogleFonts.roboto(
                      fontSize:
                      SizeConfig.blockSizeVertical * 2.4,
                      color: Colors.white,
                    )),
                trailing: FaIcon(
                  FontAwesomeIcons.ccVisa,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
