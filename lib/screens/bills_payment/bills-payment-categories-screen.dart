import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/bills_payment/transportation/transportation-categories-screen.dart';
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
            Container(
                color: Colors.white,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Saved Biller(s)',
                        style: GoogleFonts.roboto(
                            color: Colors.black, fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Container(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                  maxRadius: 30,
                                  backgroundColor: COLOR_DARK_PURPLE,
                                  child: InkWell(
                                    onTap: () {},
                                    child: CircleAvatar(
                                        maxRadius: 29,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.add)),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  'Add Biller',
                                  style: GoogleFonts.roboto(
                                      color: COLOR_DARK_GRAY,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                    )
                  ],
                )),
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
                          category: "Airlines",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage("assets/icons/services/cash-in.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Airlines",
                        ),
                        CategoryButtonWidget(
                          category: "Cable / Internet",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/cable-internet.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Cable / Internet",
                        ),
                        CategoryButtonWidget(
                          category: "Electricity",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/electricity.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Electricity",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryButtonWidget(
                          category: "Insurance",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/loans.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Insurance",
                        ),
                        Container(
                          width: 90,
                          height: 90,
                          child: Column(
                            children: [
                              IconButton(
                                color: COLOR_GRAY,
                                icon: ImageIcon(
                                  AssetImage(
                                      "assets/icons/services/bills-payment/transportation.png"),
                                  color: COLOR_DARK_PURPLE,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TransportationCategoriesScreen(),
                                    ),
                                  );
                                },
                              ),
                              Text(
                                "Transportation",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                        ),
                        CategoryButtonWidget(
                          category: "Online Shopping",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/credit-card.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Online Shopping",
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CategoryButtonWidget(
                          category: "Utilities",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/real-estate.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Utilities",
                        ),
                        CategoryButtonWidget(
                          category: "Water",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/water-utility.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Water",
                        ),
                        CategoryButtonWidget(
                          category: "Others",
                          onPressed: _handleButtonClick,
                          icon: ImageIcon(
                            AssetImage(
                                "assets/icons/services/bills-payment/others.png"),
                            color: COLOR_DARK_PURPLE,
                          ),
                          text: "Others",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  _handleButtonClick(String category) async {
    if (store.selectedBillerCategory != category) {
      OverlayScreen().show(context);
      store.selectedBillerCategory = category;
      print(category);
      var billers =
          await store.billsPaymentService.getBillersByCategory(category);
      store.billers = billers;

      OverlayScreen().pop();
    }

    Get.toNamed('/services/bills-payment/bills-payment-billers-screen');
  }
}
