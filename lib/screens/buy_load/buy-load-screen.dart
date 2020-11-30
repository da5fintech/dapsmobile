import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
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
                Text("or choose denomination below:")
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
