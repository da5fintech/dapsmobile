import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/soon-release-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class RemittanceCategoriesScreen extends StatefulWidget {
  @override
  _RemittanceCategoriesScreenState createState() =>
      _RemittanceCategoriesScreenState();
}

class _RemittanceCategoriesScreenState
    extends State<RemittanceCategoriesScreen> {
  List<String> categories = [
    REMITTANCE_SCREEN_CATEGORIES_BANK_TEXT,
    REMITTANCE_SCREEN_CATEGORIES_WALLET_TEXT,
    REMITTANCE_SCREEN_CATEGORIES_CENTERS_TEXT
  ];
  PanelController _panelController = PanelController();
  bool panelOpened = false;

  @override
  void initState() {
    super.initState();
  }

  Widget createSlideupPanelContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                REMITTANCE_SCREEN_PANEL_SEND_MONEY_TEXT,
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(.87),
                ),
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  _panelController.close();
                },
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            _openInstapay();
          },
          child: Card(
            elevation: 2,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              REMITTANCE_SCREEN_PANEL_SEND_INSTANCE_FREE_TEXT,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR_DARK_PURPLE),
                            ),
                            Image(
                              width: 90,
                              image: AssetImage("assets/icons/instapay.png"),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: new BoxDecoration(
                                  color: COLOR_ORANGE, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              REMITTANCE_SCREEN_PANEL_SEND_OTHER_BANKS_TEXT,
                              style: GoogleFonts.roboto(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: new BoxDecoration(
                                  color: COLOR_ORANGE, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              REMITTANCE_SCREEN_PANEL_CUT_OFF_TEXT,
                              style: GoogleFonts.roboto(fontSize: 12),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: new BoxDecoration(
                                  color: COLOR_ORANGE, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              REMITTANCE_SCREEN_PANEL_TRANSACTION_LIMIT,
                              style: GoogleFonts.roboto(fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            print("pesonet");
          },
          child: Card(
            elevation: 2,
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              REMITTANCE_SCREEN_PANEL_SEND_FOR_FREE,
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR_DARK_PURPLE),
                            ),
                            Image(
                              width: 90,
                              image: AssetImage("assets/icons/pesonet.png"),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: new BoxDecoration(
                                  color: COLOR_ORANGE, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              REMITTANCE_SCREEN_PANEL_SEND_TO_OTHER_BANKS_INSTANCE_TEXT,
                              style: GoogleFonts.roboto(fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 4.0,
                              width: 4.0,
                              decoration: new BoxDecoration(
                                  color: COLOR_ORANGE, shape: BoxShape.circle),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Text(
                                REMITTANCE_SCREEN_PANEL_TRANSACTION_NOTE,
                                style: GoogleFonts.roboto(fontSize: 12),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens(
      {
        'progress': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
              ),
              SizedBox(height: 10.0),
              Text("Processing...",
                  style: GoogleFonts.roboto(color: Colors.white)),
            ],
          ),
        ),
        'oncoming-update': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: SoonReleaseDialog(
            onOk: () {
              OverlayScreen().pop();
            },
          ),
        )
      },
    );

    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            height: 90.0,
            title: REMITTANCE_SCREEN_TITLE_TEXT,
            bottom: TabBar(
              tabs: [
                Tab(icon: Text(REMITTANCE_SCREEN_TAB_SEND_TEXT)),
                Tab(icon: Text(REMITTANCE_SCREEN_TAB_REQUEST_TEXT)),
              ],
            ),
          ),
          body: SlidingUpPanel(
            color: Colors.white,
            controller: _panelController,
            minHeight: 0,
            maxHeight: 350,
            backdropEnabled: true,
            panel: createSlideupPanelContent(),
            body: TabBarView(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(5),
                        itemCount: categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey.withOpacity(.36),
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          categories[index],
                                          style: GoogleFonts.roboto(
                                              color:
                                                  Colors.black.withOpacity(.87),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.black.withOpacity(.54),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              _handleTap(categories[index]);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Icon(Icons.update, color: COLOR_DARK_PURPLE, size: 102),
                    ),
                    Text(
                      'Incoming Future Releases!',
                      style: GoogleFonts.roboto(
                        fontSize: 17,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Soon to be released\nPlease wait for our future Updates.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        height: 1.5,
                        fontSize: 14,
                        color: COLOR_DARK_GRAY,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleTap(String category) {
    if (category == "Banks") {
      _panelController.open();
    } else {
      OverlayScreen().show(
        context,
        identifier: 'oncoming-update',
      );
    }

  }

  void _openInstapay() async {
    OverlayScreen().show(
      context,
      identifier: 'progress',
    );
    var banks = await store.instapayService.getBanks();
    OverlayScreen().pop();
    store.instapayBanks = banks;
    Get.toNamed(
        "/services/remittance/instapay/remittance-instapay-banks-screen");
  }
}
