import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/load-promo-products.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/buy_load/amount-button-widget.dart';
import 'package:swipe/services/eloading-service.dart';
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    double width = MediaQuery.of(context).size.width * 0.60;
    double height = MediaQuery.of(context).size.height * 0.70;
    AirtimeProduct product = store.transaction.product;
    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
            // backgroundColor: Constants.backgroundColor2,
            appBar: SubAppbarWidget(
                height: 90.0,
                title: "Buy Load",
                bottom: TabBar(
                  tabs: [
                    Tab(icon: Text("Regular Load")),
                    Tab(icon: Text("Load Promos")),
                  ],
                )),
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
                                              }),
                                          // Text("j"),
                                        ],
                                      ),
                                      TextFormField(
                                        validator: (text) {
                                          if (text == null || text.isEmpty) {
                                            return 'amount is required';
                                          }
                                          return null;
                                        },
                                        controller: controller,
                                        keyboardType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        textAlign: TextAlign.right,
                                        decoration: InputDecoration(
                                            labelText: "Amount",
                                            hintText: "0.00"),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        SizedBox(height: 15),
                        Text("Enter amount between 10-1000"),
                        Text("or choose denomination below:"),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AmountButtonWidget(
                                amount: 10,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 30,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 50,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AmountButtonWidget(
                                amount: 80,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 100,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 150,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 50, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AmountButtonWidget(
                                amount: 300,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 500,
                                onPressed: () {},
                              ),
                              AmountButtonWidget(
                                amount: 1000,
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Spacer(),
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
                                  "NEXT",
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      height: height,
                      child: ListView.builder(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(8),
                          itemCount: promoProducts.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: COLOR_BLUE,
                                    child: Text(
                                      'G',
                                      style: GoogleFonts.roboto(
                                          color: Colors.white),
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    width: width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('${promoProducts[index].name}',
                                            textAlign: TextAlign.left,
                                            style: GoogleFonts.roboto(
                                                color: Colors.black
                                                    .withOpacity(0.87),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500)),
                                        SizedBox(
                                          height: 2,
                                        ),
                                        Text(
                                            '${promoProducts[index].description}',
                                            style: GoogleFonts.roboto(
                                                color: COLOR_DARK_GRAY
                                                    .withOpacity(.87),
                                                fontSize: 10,
                                                fontWeight: FontWeight.w500)),
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
                            );
                          }),
                    ),
                    Spacer(),
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
                              "NEXT",
                            ),
                          ),
                        ))
                  ],
                )
              ],
            )),
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
      ProductModel product = AirtimeProduct(
        amount: double.parse(controller.text),
        code: "REGULAR",
      );
      store.setTransactionProduct(product);
      // Get.toNamed("/services/payment/payment-verification-screen");

      var service = new EloadingService();
      await service.getProducts("639672057407");
    }
  }

  void _handleNextPromo() {
    if (selectedPromo != null) {
      store.setTransactionProduct(selectedPromo);
      Get.toNamed("/services/payment/payment-verification-screen");
    }
  }
}
