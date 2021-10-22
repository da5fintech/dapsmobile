import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:native_screenshot/native_screenshot.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/screens/direct-send/direct-request-form-screen.dart';
import 'package:swipe/screens/direct-send/direct-send-via-qr-screen.dart';
import 'package:swipe/screens/direct-send/import-qr-screen.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class DirectSendScreen extends StatefulWidget {
  @override
  _DirectSendScreenState createState() => _DirectSendScreenState();
}

class _DirectSendScreenState extends State<DirectSendScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppUtil _appUtil = AppUtil();
  String qrData = "";
  String userNickname = "";
  double php;

  @override
  void initState() {
    qrData = "${store.user.mobileNumber}/${store.user.displayName}";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text(
              "Processing...",
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
    });

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        key: _scaffoldKey,
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
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DAPS,
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
                          fontSize: SizeConfig.blockSizeVertical * 2,
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
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => DirectSendViaQrScreen()));
                      },
                      title: Text(
                        DIRECT_SEND_SCREEN_SEND_QR_TEXT,
                        style: GoogleFonts.roboto(
                          fontSize: SizeConfig.blockSizeVertical * 2,
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
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => ImportQrScreen()),
                         );

                      },
                      title: Text(
                        'Import QR',
                        style: GoogleFonts.roboto(
                          fontSize: SizeConfig.blockSizeVertical * 2,
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
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DAPS,
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
                          fontSize: SizeConfig.blockSizeVertical * 2,
                          fontWeight: FontWeight.w500,
                          color: Colors.black.withOpacity(0.5),
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
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.w500,
                        color: COLOR_DAPS,
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
                          fontSize: SizeConfig.blockSizeVertical * 2,
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
              color: COLOR_DAPS,
              padding: EdgeInsets.only(top: 20, right: 10, left: 10),
              child: Column(
                children: [
                  Text(
                    APP_NAME,
                    style: GoogleFonts.roboto(
                      fontSize: SizeConfig.blockSizeVertical * 2.5,
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
                              data: qrData,
                              size: height * 0.25,
                              embeddedImageEmitsError: true,
                            ),
                          ),
                          if (userNickname.isNotEmpty) ...[
                            Text(
                              userNickname,
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 2.2,
                                color: COLOR_DARK_PURPLE,
                              ),
                            ),
                          ],
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: InkWell(
                              onTap: _customQr,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Juan Cruz',
                                    style: GoogleFonts.roboto(
                                      fontWeight: FontWeight.w500,
                                      fontSize:
                                          userNickname.isEmpty && php == null
                                              ? SizeConfig.blockSizeVertical * 2.2
                                              : SizeConfig.blockSizeVertical * 2,
                                      color: userNickname.isEmpty && php == null
                                          ? COLOR_DARK_PURPLE
                                          : COLOR_DARK_GRAY,
                                    ),
                                  ),
                                  if (userNickname.isEmpty && php == null) ...[
                                    Icon(Icons.edit, color: COLOR_DARK_PURPLE),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          if (php != null) ...[
                            Text(
                              "PHP ${formatterWithoutPHP.format(php).replaceFirst(" ", "")}",
                              style: GoogleFonts.roboto(
                                fontWeight: FontWeight.w500,
                                fontSize: SizeConfig.blockSizeVertical * 2.2,
                                color: COLOR_DARK_PURPLE,
                              ),
                            ),
                          ],
                          Spacer(),
                          Container(
                            height: 40,
                            color: COLOR_ORANGE,
                            child: Center(
                              child: InkWell(
                                onTap: _customQr,
                                // onTap: () {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(builder: (_) => DirectRequestFormScreen())
                                //   );
                                // },
                                child: Text(
                                  '+ ADD AMOUNT',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: SizeConfig.blockSizeVertical * 2,
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
                          child: InkWell(
                            onTap: _downloadQr,
                            child: Column(
                              children: [
                                Icon(Icons.download_sharp, color: Colors.white),
                                Text(
                                  'Download',
                                  style: GoogleFonts.roboto(
                                    color: Colors.white,
                                    height: 1.5,
                                    fontSize: SizeConfig.blockSizeVertical * 1.7,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          child: Column(
                            children: [
                              Icon(Icons.share, color: Colors.white.withOpacity(0.5)),
                              Text(
                                'Share',
                                style: GoogleFonts.roboto(
                                  color: Colors.white.withOpacity(0.5),
                                  height: 1.5,
                                  fontSize: SizeConfig.blockSizeVertical * 1.7,
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

  void _customQr() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => DirectRequestFormScreen(
                  onSave: _handleUpdateQr,
                )));
  }

  _handleUpdateQr(String nickname, String amount) {
    qrData = "${store.user.mobileNumber}/${store.user.displayName}";
    String convertQrData = _appUtil.splitQrData(qrData, amount);
    userNickname = nickname;
    qrData = convertQrData;
    php = double.parse(amount);
    setState(() {});
  }

  _downloadQr () async {
    if(php == null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text('Please Input an amount.'), backgroundColor: COLOR_DANGER),
      );
      return;
    }

    OverlayScreen().show(
      context,
      identifier: 'progress',
    );
    await NativeScreenshot.takeScreenshot();
    await Future.delayed(Duration(seconds: 3));

    OverlayScreen().pop();
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(CASH_IN_DOWNLOAD_CODE), backgroundColor: COLOR_GREEN),
    );

  }
}
