import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/buy_load/amount-button-widget.dart';
import 'package:swipe/screens/buy_load/promo-circle-amount-widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class BuyLoadAmountScreen extends StatefulWidget {
  @override
  _BuyLoadAmountScreenState createState() => _BuyLoadAmountScreenState();
}

class _BuyLoadAmountScreenState extends State<BuyLoadAmountScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedRadio = "";
  TextEditingController controller = new TextEditingController();
  ProductModel selectedPromo;
  List<ProductModel> promoProducts = new List<ProductModel>();
  AirtimeProduct chosenRegularPromo;

  @override
  void initState() {
    super.initState();

    store.eloadingService
        .getProducts(store.transaction.recipient)
        .then((value) {
      setState(() {
        promoProducts = value;
      });
    });
  }

  setSelectedRadio(String code) {
    selectedRadio = code;
    setState(() {});
  }

  Widget createAmountsTable() {
    // collect all amounts

    int perRow = 3;

    List<ProductModel> promos = promoProducts.where((element) {
      return element.code == 'AMAX' || element.code == "SMARTLOAD";
    }).toList();

    var column = Column(
      children: [],
    );

    for (int i = 0; i < (promos.length / perRow).ceil(); i++) {
      List<Widget> list = [];

      for (int x = 0; x < perRow; x++) {
        var idx = x + (i * perRow);
        if (idx < promos.length) {
          list.add(AmountButtonWidget(
            promo: promos[idx],
            selectedPromo: chosenRegularPromo,
            onPressed: (amt) {
              _useAmount(amt);
            },
          ));
        }
      }

      var row = Padding(
        padding: EdgeInsets.only(left: 50, right: 50),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: list,
        ),
      );

      column.children.add(row);
    }
    return column;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width * 0.60;
    double height = MediaQuery.of(context).size.height * 0.70;
    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            height: 90.0,
            title: BUY_LOAD_TITLE_TEXT,
            bottom: TabBar(
              tabs: [
                Tab(icon: Text(BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_1)),
                Tab(icon: Text(BUY_LOAD_AMOUNT_SCREEN_TAB_OPTION_2)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Form(
                key: _formKey,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(store.transaction.recipient),
                                      Spacer(),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: COLOR_DARK_PURPLE,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                      ),
                                      // Text("j"),
                                    ],
                                  ),
                                  // TextFormField(
                                  //   validator: (text) {
                                  //     if (text == null || text.isEmpty) {
                                  //       return '${BUY_LOAD_AMOUNT_SCREEN_AMOUNT_TEXT} is required';
                                  //     }
                                  //     return null;
                                  //   },
                                  //   controller: controller,
                                  //   keyboardType:
                                  //       TextInputType.numberWithOptions(
                                  //           decimal: true),
                                  //   textAlign: TextAlign.right,
                                  //   decoration: InputDecoration(
                                  //       labelText:
                                  //           BUY_LOAD_AMOUNT_SCREEN_AMOUNT_TEXT,
                                  //       hintText: "0.00"),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION),
                      Text(BUY_LOAD_AMOUNT_ENTER_AMOUNT_OPTION_OR),
                      SizedBox(height: 25),
                      Expanded(
                        child: SingleChildScrollView(
                          child: createAmountsTable(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: SizedBox(
                          width: double.infinity,
                          child: RaisedButton(
                            // shape: ,
                            onPressed: () {
                              _handleNextRegular();
                            },
                            child: Text(
                              BUY_LOAD_NEXT_TEXT,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      itemCount: promoProducts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(.36),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                PromoCircleAmountWidget(
                                  promo: promoProducts[index],
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${promoProducts[index].name}',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.roboto(
                                            color:
                                                Colors.black.withOpacity(0.87),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Radio(
                                    onChanged: (value) {
                                      setSelectedRadio(value);
                                      selectedPromo = promoProducts[index];
                                    },
                                    groupValue: selectedRadio,
                                    value: promoProducts[index].code)
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        // shape: ,
                        onPressed: () {
                          _handleNextPromo();
                        },
                        child: Text(
                          BUY_LOAD_NEXT_TEXT,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNextRegular() async {
    bool status = _formKey.currentState.validate();
    if (status) {
      store.setTransactionProduct(
          chosenRegularPromo, chosenRegularPromo.amount);
      Get.toNamed("/services/payment/payment-verification-screen");
    }
  }

  void _handleNextPromo() {
    if (selectedPromo != null) {
      store.setTransactionProduct(selectedPromo, selectedPromo.amount);
      Get.toNamed("/services/payment/payment-verification-screen");
    }
  }

  void _useAmount(AirtimeProduct promo) {
    print("using amount ${promo.code}");
    chosenRegularPromo = promo;
    controller.text = "${promo.amount}";
    setState(() {});
  }
}
