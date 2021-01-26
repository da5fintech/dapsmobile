import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/store/application-store.dart';

import '../../main.dart';
import 'category-button-widget.dart';

final store = getIt<ApplicationStore>();

class BillsPaymentCategoriesScreen extends StatefulWidget {
  @override
  _BillsPaymentCategoriesScreenState createState() =>
      _BillsPaymentCategoriesScreenState();
}

class _BillsPaymentCategoriesScreenState
    extends State<BillsPaymentCategoriesScreen> {
  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => initBillers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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

    return Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          title: "Pay Bills",
        ),
        body: Container(
          child: Column(
            children: [
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(25),
                      width: double.infinity,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryButtonWidget(
                                category: "AIRLINES",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "AIRLINES",
                              ),
                              CategoryButtonWidget(
                                category: "CABLE",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "CABLE",
                              ),
                              CategoryButtonWidget(
                                category: "ELECTRICITY",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "ELECTRICITY",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryButtonWidget(
                                category: "INSURANCE",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "INSURANCE",
                              ),
                              CategoryButtonWidget(
                                category: "ONLINE SHOPPING",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "ONLINE SHOPPING",
                              ),
                              CategoryButtonWidget(
                                category: "UTILITIES",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "UTILITIES",
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CategoryButtonWidget(
                                category: "WATER",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "WATER",
                              ),
                              CategoryButtonWidget(
                                category: "OTHERS",
                                onPressed: _handleButtonClick,
                                icon: Icon(Icons.circle),
                                text: "OTHERS",
                              ),
                              Container(
                                height: 90,
                                width: 90,
                              )
                            ],
                          ),
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

  _handleButtonClick(String category) async {
    if (store.selectedBillerCategory != category) {
      OverlayScreen().show(context);
      store.selectedBillerCategory = category;
      var billers =
          await store.billsPaymentService.getBillersByCategory(category);
      store.billers = billers;

      OverlayScreen().pop();
    }

    Get.toNamed('/services/bills-payment/bills-payment-billers-screen');
  }
}
