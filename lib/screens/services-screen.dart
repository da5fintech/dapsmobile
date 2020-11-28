import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/widgets/primary-button.widget.dart';
import 'package:swipe/widgets/secondary-button.widget.dart';
import 'package:swipe/widgets/service-button.dart';

import '../main.dart';

final store = getIt<ApplicationStore>();

class ServicesScreen extends StatefulWidget {
  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: AppBar(
          leading: Icon(Icons.list),
          title: Text("SWIPE",
              style: GoogleFonts.roboto(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 15)),
          actions: [
            Icon(
              Icons.notifications,
              size: 16,
            ),
            SizedBox(
              width: 10,
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: COLOR_ORANGE,
                            child: Text(
                              'AH',
                              style: GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text("Juan Mateo Matipid",
                                  style: GoogleFonts.roboto(fontSize: 14))),
                          Spacer(),
                          Container(
                            height: 22,
                            child: Chip(
                              padding: EdgeInsets.only(bottom: 10),
                              backgroundColor: COLOR_GREEN,
                              label: Text('VERIFIED',
                                  style: GoogleFonts.roboto(
                                      fontSize: 12, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Available balance",
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7)))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("**** *** 9870",
                              style: GoogleFonts.roboto(
                                  fontSize: 12,
                                  color: Colors.white.withOpacity(0.7))),
                          Text("PHP 28,000.00",
                              style: GoogleFonts.roboto(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  )),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(25),
                      width: double.infinity,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Cash In",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Buy Load",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Pay QR",
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Remittance",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Pay Bills",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Insurance",
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Bank Transfer",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.circle),
                                text: "Request Money",
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              ServiceButtonWidget(
                                icon: Icon(Icons.more_horiz),
                                text: "More",
                              ),
                            ],
                          )
                        ],
                      )))
            ],
          ),
        ));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
