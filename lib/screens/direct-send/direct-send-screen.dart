import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class DirectSendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            height: 90.0,
            title: DIRECT_SEND_SCREEN_TITLE_TEXT,
            bottom: TabBar(
              indicatorColor: COLOR_ORANGE,
              tabs: [
                Tab(icon: Text('Send')),
                Tab(icon: Text('Request')),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: COLOR_DARK_PURPLE.withOpacity(0.15),
                    child: Text(
                      DIRECT_SEND_SCREEN_SWIPE_SEND_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DARK_PURPLE,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed('/services/direct-send/direct-send-form-screen');
                      },
                      title: Text(
                        DIRECT_SEND_SCREEN_DIRECT_SEND_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        DIRECT_SEND_SCREEN_SEND_QR_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: COLOR_DARK_PURPLE.withOpacity(0.15),
                    child: Text(
                      DIRECT_SEND_SCREEN_SEND_TO_BANK_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DARK_PURPLE,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      title: Text(
                        DIRECT_SEND_SCREEN_BANKS_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    color: COLOR_DARK_PURPLE.withOpacity(0.15),
                    child: Text(
                      DIRECT_SEND_SCREEN_REMITTANCE_TEXT,
                      style: GoogleFonts.roboto(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DARK_PURPLE,
                      ),
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Get.toNamed('/services/remittance/remittance-categories-screen');
                      },
                      title: Text(
                        DIRECT_SEND_SCREEN_REMITTANCE_CENTERS_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, size: 14),
                    ),
                  ),
                ],
              ),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
