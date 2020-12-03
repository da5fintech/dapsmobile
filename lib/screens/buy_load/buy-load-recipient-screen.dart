import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class BuyLoadRecipientScreen extends StatefulWidget {
  @override
  _BuyLoadRecipientScreenState createState() => _BuyLoadRecipientScreenState();
}

class _BuyLoadRecipientScreenState extends State<BuyLoadRecipientScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = new TextEditingController();
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
          appBar: SubAppbarWidget(
            title: "Buy Load",
          ),
          body: Form(
            key: _formKey,
            child: Container(
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(25),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  validator: (text) {
                                    if (text == null || text.isEmpty) {
                                      return 'Mobile number is required';
                                    }
                                    return null;
                                  },
                                  controller: controller,
                                  decoration: InputDecoration(
                                      prefixIconConstraints: BoxConstraints(
                                          minWidth: 0, minHeight: 0),
                                      labelText: "Buy load for",
                                      hintText: ""),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Spacer(),
                  Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: SizedBox(
                        width: double.infinity,
                        child: RaisedButton(
                          // shape: ,
                          onPressed: () {
                            _handleNext();
                          },
                          child: Text(
                            "NEXT",
                          ),
                        ),
                      ))
                ],
              ),
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNext() {
    bool status = _formKey.currentState.validate();
    if (status == true) {
      store.createTransaction(SwipeServiceOffering.BUY_LOAD, controller.text);
      Get.toNamed('/services/buy-load/buy-load-amount-screen');
    }
  }
}
