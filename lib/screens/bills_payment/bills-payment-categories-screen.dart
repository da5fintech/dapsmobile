import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/common-alert.dialog.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/models/product-model.dart';
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
    getSavedBiller();
    super.initState();
  }

  Future getSavedBiller () async {
    // await store.addBillerService.deleteAll();
    List<BillerProduct> a = await store.addBillerService.onLoading();
    store.setNewBiller(a);
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
        title: BILLS_PAYMENT_TITLE_TEXT,
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
                  if(store.savedBillers.isNotEmpty) ...[
                    Text(
                      BILLS_PAYMENT_CATEGORIES_SCREEN_SAVED_BILLERS_TEXT,
                      style: GoogleFonts.roboto(
                          color: Colors.black, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(width: 10),
                          Observer(
                            builder: (_) => Container(
                              child: Row(
                                children: store.savedBillers?.map((biller) {
                                  var avatar = biller.logo != null
                                      ? Image.network(biller.logo,
                                      height: 50, width: 75)
                                      : CircleAvatar(
                                    maxRadius: 28,
                                    backgroundColor: COLOR_DARK_PURPLE,
                                    child: CircleAvatar(
                                      backgroundColor:
                                      Colors.transparent,
                                      maxRadius: 26,
                                      child: Text(
                                          "${biller.name.characters.characterAt(0)}"),
                                    ),
                                  );
                                  return GestureDetector(
                                    onLongPress: () {
                                      return showDialog(
                                          context: context,
                                          builder: (context) => CommonAlertDialog(
                                              message: Text('${BILLS_PAYMENT_CATEGORIES_SCREEN_DELETE_BILLER_TEXT} ${biller.name}?'),
                                              onOk: () {
                                                store.addBillerService.deleteBiller(biller);
                                                var updateBiller = store.addBillerService.billers;
                                                store.setNewBiller(updateBiller);
                                                Navigator.pop(context);
                                              }
                                          )
                                      );
                                    },
                                    onTap: () {
                                      store.selectedBiller = biller;
                                      Get.toNamed('/services/bills-payment/bills-payment-biller-form-screen');
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                        children: [
                                          avatar,
                                          Container(
                                            padding: EdgeInsets.only(top: 10),
                                            width: 75,
                                            child: Center(
                                              child: Text(
                                                biller.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: COLOR_DARK_GRAY),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })?.toList() ?? [],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(bottom: 25, right: 25, left: 25),
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Biller Categories',
                      style: GoogleFonts.roboto(
                        height: 2,
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        physics: BouncingScrollPhysics(),
                        crossAxisCount: 3,
                        mainAxisSpacing: 50,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 20,
                        children: [
                          CategoryButtonWidget(
                            category: BILLS_PAYMENT_CATEGORIES_SCREEN_AIRLINES_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_AIRLINES.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_AIRLINES_TEXT,
                          ),
                          CategoryButtonWidget(
                            category:
                                BILLS_PAYMENT_CATEGORIES_SCREEN_CABLE_INTERNET_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_CABLE_AND_INTERNET.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_CABLE_INTERNET_TEXT,
                          ),
                          CategoryButtonWidget(
                            category:
                                BILLS_PAYMENT_CATEGORIES_SCREEN_ELECTRICITY_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_ELECTRIC_UTILITIES.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_ELECTRICITY_TEXT,
                          ),
                          CategoryButtonWidget(
                            category: BILLS_PAYMENT_CATEGORIES_SCREEN_INSURANCE_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_INSURANCE.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_INSURANCE_TEXT,
                          ),
                          CategoryButtonWidget(
                            category:
                                BILLS_PAYMENT_CATEGORIES_SCREEN_TRANSPORTATION_TEXT,
                            onPressed: (category) => Get.toNamed(
                                '/services/bills-payment/transportation/transportation-categories-screen'),
                            icon: SvgPicture.asset('assets/svg2/ICONS_TRANSPORTATION.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_TRANSPORTATION_TEXT,
                          ),
                          CategoryButtonWidget(
                            category:
                                BILLS_PAYMENT_CATEGORIES_SCREEN_ONLINE_SHOPPING_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_CREDIT_CARD.svg'),
                            text:
                                BILLS_PAYMENT_CATEGORIES_SCREEN_ONLINE_SHOPPING_TEXT,
                          ),
                          CategoryButtonWidget(
                            category: BILLS_PAYMENT_CATEGORIES_SCREEN_UTILITIES_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_REAL_ESTATE.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_UTILITIES_TEXT,
                          ),
                          CategoryButtonWidget(
                            category: BILLS_PAYMENT_CATEGORIES_SCREEN_WATER_TEXT,
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg2/ICONS_WATER_UTILITIES.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_WATER_TEXT,
                          ),
                          CategoryButtonWidget(
                            category: "Others",
                            onPressed: _handleButtonClick,
                            icon: SvgPicture.asset('assets/svg/services/bills-payment/others.svg'),
                            text: BILLS_PAYMENT_CATEGORIES_SCREEN_OTHERS_TEXT,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          backgroundColor: COLOR_DARK_PURPLE,
          onPressed: () {
            Get.toNamed(
                '/services/bills-payment/bills-payment-biller-list-screen');
          },
          child: Icon(Icons.add, color: Colors.white),
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
