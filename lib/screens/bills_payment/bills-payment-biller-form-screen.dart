import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/bills_payment/bills-payment-scanner.dart';
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
  Map<String, dynamic> values = Map<String, dynamic>();

  @override
  void initState() {
    super.initState();
  }

  setSelectedRadio(String code) {
    selectedRadio = code;
    setState(() {});
  }

  Widget createTextField(BillerField field) {
    return TextFormField(
      initialValue: field.defaultValue == null ? "" : "${field.defaultValue}",
      onSaved: (v) {
        values[field.field] = v;
      },
      keyboardType: field.fieldType == BillerFieldType.NUMBER
          ? TextInputType.number
          : TextInputType.text,
      validator: (text) {
        if (!field.isRequired) {
          return null;
        } else {
          if (text == null || text.isEmpty) {
            return '${field.label} is required';
          }
        }
        return null;
      },
      // controller: controller,
      decoration: InputDecoration(
          prefixIconConstraints: BoxConstraints(minWidth: 0, minHeight: 0),
          labelText: "${field.label}", suffixIcon: field.label == "Meralco Reference No / Account Number" ? IconButton(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await Future.delayed(Duration(seconds: 1));
              Navigator.push(context, MaterialPageRoute(builder: (_) => BillPaymentScanner()));
            },
            icon: Icon(Icons.qr_code_scanner, color: COLOR_DARK_PURPLE),
          ) : null,
          hintText: ""),
    );
  }

  Widget createDropdownField(BillerField field) {
    // // print("options length ${field.options.length}");
    var dropdownItems = field.options.map((opt) {
      // print("value ${opt.key} ${opt.value}");
      return DropdownMenuItem(
        child: Text(opt.key),
        value: opt.value,
      );
    }).toList();

    dynamic value =
        field.defaultValue == "" ? field.options[0].value : field.defaultValue;

    if (values[field.field] != null) {
      value = values[field.field];
    }

    if (value == null) {
      value = field.options[0].value;
    }

    values[field.field] = value;

    var dd = DropdownButton(
      isExpanded: true,
      value: value,
      items: dropdownItems,
      onChanged: (str) {
        values[field.field] = str;
        setState(() {});
      },
    );
    return dd;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    var fields = store.selectedBiller.fields.map((field) {
      // print("${field.field}, ${field.fieldType}");
      if (field.fieldType == BillerFieldType.DROPDOWN) {
        return createDropdownField(field);
      } else {
        return createTextField(field);
      }
    }).toList();

    double width = MediaQuery.of(context).size.width * 0.70;
    double height = MediaQuery.of(context).size.height * 0.70;
    var avatar = store.selectedBiller.logo != null
        ? CircleAvatar(
            radius: SizeConfig.blockSizeVertical * 3,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(store.selectedBiller.logo),
          )
        : CircleAvatar(
            child:
                Text("${store.selectedBiller.name.characters.characterAt(0)}"),
          );

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          elevation: 0,
          title: BILLS_PAYMENT_TITLE_TEXT,
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  bottom: 15,
                  top: 5,
                  left: 5,
                  right: 5,
                ),
                color: COLOR_DARK_PURPLE,
                child: Row(
                  children: [
                    avatar,
                    Container(
                      width: width,
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${store.selectedBiller.name}",
                            style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical * 2.2,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            BILLS_PAYMENT_SCREEN_IMMEDIATE_POST_TEXT,
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 1.7,
                              color: Colors.white.withOpacity(.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: fields,
                    ),
                  ),
                ),
              ),
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
                      BILLS_PAYMENT_NEXT_TEXT,
                    ),
                  ),
                ),
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

  void _handleNext() {
    bool status = _formKey.currentState.validate();
    if (status == true) {
      store.createTransaction(SwipeServiceOffering.BILLS_PAYMENT, "");
      _formKey.currentState.save();

      values.forEach((key, value) {
        print("setting field ${key} ${value}");
        store.selectedBiller.setFieldValue(key, value);
      });

      double amount =
          double.parse(store.selectedBiller.getFieldValue('amount')) +
              store.selectedBiller.fee;
      store.setTransactionProduct(store.selectedBiller, amount);
      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed validation");
    }
  }
}
