import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
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
  List<String> categories = ["Banks", "Wallets", "Remittance Centers"];
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text("Send money via: ",
                style: GoogleFonts.roboto(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black.withOpacity(.87))),
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _panelController.close();
              },
            )
          ]),
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
                          Text("Send Instantly for free",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR_DARK_PURPLE)),
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
                            "Send to other banks and Wallets, Received instantly",
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
                            "No Cutoff",
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
                            "50,000.00 transaction Limit",
                            style: GoogleFonts.roboto(fontSize: 12),
                          )
                        ],
                      ),
                    ],
                  ),
                )),
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
                          Text("Send for free",
                              style: GoogleFonts.roboto(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: COLOR_DARK_PURPLE)),
                          Image(
                            width: 90,
                            image: AssetImage("assets/icons/pesonet.png"),
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
                            "Send to other banks and Wallets, Receive by end of the day",
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
                          Expanded(
                            child: Text(
                              "Transactions before 3:00 PM cut-off are processed same banking day. Transactions after cut-off, weekends of holidays are processed the next banking day",
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
                )),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

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
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
    });

    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
            // backgroundColor: Constants.backgroundColor2,
            appBar: SubAppbarWidget(
                height: 90.0,
                title: "Send/Request Money",
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Text("Send")),
                    Tab(icon: Text("Request")),
                  ],
                )),
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
                                              color: Colors.grey
                                                  .withOpacity(.36)))),
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
                                            Text(categories[index],
                                                style: GoogleFonts.roboto(
                                                    color: Colors.black
                                                        .withOpacity(.87),
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500)),
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
                            }),
                      ),
                    ],
                  ),
                  Text("Hello tab2")
                ],
              ),
            )),
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
