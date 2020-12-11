import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class BillsPaymentBillerFormScreen extends StatefulWidget {
  @override
  _BillsPaymentBillerFormScreenState createState() =>
      _BillsPaymentBillerFormScreenState();
}

class _BillsPaymentBillerFormScreenState
    extends State<BillsPaymentBillerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String selectedRadio = "";
  TextEditingController controller = new TextEditingController();
  ProductModel selectedPromo;
  List<ProductModel> promoProducts = new List<ProductModel>();

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(String code) {
    selectedRadio = code;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    var fields = store.selectedBiller.fields.map((field) {
      print("${field.field}, ${field.fieldType}");
      return TextFormField(
        keyboardType: field.fieldType == BillerFieldType.NUMBER
            ? TextInputType.number
            : TextInputType.number,
        validator: (text) {
          if (!field.isRequired) {
            return null;
          } else {
            if (text == null || text.isEmpty) {
              return 'Mobile number is required';
            }
          }
          return null;
        },
        // controller: controller,
        decoration: InputDecoration(
            prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
            labelText: "${field.label}",
            hintText: ""),
      );
    }).toList();

    return Theme(
      data: td,
      child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            title: "Pay Bills",
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
                              children: fields,
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
                            // _handleNext();
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
}
