import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Notification',
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 3,
                fontWeight: FontWeight.w700,
                color: Colors.black
              )
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: COLOR_DARK_GRAY),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.notification_important, size: SizeConfig.blockSizeVertical * 18, color: COLOR_DARK_PURPLE),
                Text(
                  'Nothing here!',
                  style: GoogleFonts.roboto(
                    fontSize: SizeConfig.blockSizeVertical * 2.5,
                    fontWeight: FontWeight.bold,
                    color: COLOR_DARK_PURPLE,
                  )
                ),
                SizedBox(height: 20),
                Text(
                    'Tap the notification button below and\ncheck again',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2.3,
                      fontWeight: FontWeight.w300,
                      color: Colors.grey[500],
                    )
                )
              ],
            ),
          ),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              color: COLOR_DARK_PURPLE,
              onPressed: () {},
              child: Text('Refresh', style: TextStyle(color: Colors.white)),
            )
          )
        ],
      ),
    );
  }
}