import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/direct-send/direct-request-form-screen.dart';

class DirectSendScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 2,
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
            //Send
            Container(
              color: Colors.white,
              child: ListView(
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
                        Get.toNamed(
                            '/services/direct-send/direct-send-form-screen');
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
                        Get.toNamed(
                            '/services/remittance/remittance-categories-screen');
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
            ),
            //Request
            Container(
              height: height,
              width: width,
              padding: EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Column(
                children: [
                  Text(
                    APP_NAME,
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 15,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    height: height * 0.45,
                    width: width * 0.90,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: QrImage(
                              data: "1232456",
                              size: height * 0.25,
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (_) => DirectRequestFormScreen())
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Jose Paulo',
                                  style: GoogleFonts.roboto(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: COLOR_DARK_PURPLE,
                                  ),
                                ),
                                Icon(Icons.edit, color: COLOR_DARK_PURPLE),
                              ],
                            ),
                          ),
                          Spacer(),
                          Container(
                            height: 40,
                            color: COLOR_ORANGE,
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => DirectRequestFormScreen())
                                  );
                                },
                                child: Text(
                                  '+ ADD AMOUNT',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(bottom: 32, right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.download_sharp, color: Colors.white),
                              Text(
                                'Download',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  height: 1.5,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.share, color: Colors.white),
                              Text(
                                'Share',
                                style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  height: 1.5,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
