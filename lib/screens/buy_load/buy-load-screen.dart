import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/buy_load/amount-button-widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class BuyLoadScreen extends StatefulWidget {
  @override
  _BuyLoadScreenState createState() => _BuyLoadScreenState();
}

class _BuyLoadScreenState extends State<BuyLoadScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(title: "Buy Load"),
          body: Container(
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.all(25),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Align(
                            // alignment: Alignment.topLeft,
                            child: Padding(
                                padding: EdgeInsets.only(left: 20, right: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Buy load for",
                                          hintText: "Mobile Number"),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Amount",
                                          hintText: "0.00"),
                                    ),
                                  ],
                                )),
                          ),
                        ),
                      ],
                    )),
                Text("Enter amount between 10- 1000"),
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
                        onPressed: () {},
                        child: Text(
                          "NEXT",
                        ),
                      ),
                    ))
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
