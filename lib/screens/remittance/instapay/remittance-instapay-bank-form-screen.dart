import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class RemittanceInstapayBankFormScreen extends StatefulWidget {
  @override
  _RemittanceInstapayBankFormScreenState createState() =>
      _RemittanceInstapayBankFormScreenState();
}

class _RemittanceInstapayBankFormScreenState
    extends State<RemittanceInstapayBankFormScreen> {
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

  Widget createDropdownField(BillerField field) {
    print("options length ${field.options.length}");
    var dropdownItems = field.options.map((opt) {
      print("value ${opt.key} ${opt.value}");
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

    double width = MediaQuery.of(context).size.width * 0.70;
    double height = MediaQuery.of(context).size.height * 0.70;
    var avatar = CircleAvatar(
      child:
          Text("${store.selectedInstapayBank.name.characters.characterAt(0)}"),
    );

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          elevation: 0,
          title: REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_SEND_TEXT,
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
                            "${store.selectedInstapayBank.name}",
                            style: GoogleFonts.roboto(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_PAYMENT_POSTED_TEXT,
                            style: GoogleFonts.roboto(
                              fontSize: 12,
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        TextFormField(
                          // initialValue: "${field.defaultValue}",
                          onSaved: (v) {
                            values['amount'] = v;
                          },
                          keyboardType: TextInputType.number,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT} is required';
                            }
                            return null;
                          },
                          // controller: controller,
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              labelText:
                                  REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT,
                              hintText: ""),
                        ),
                        TextFormField(
                          // initialValue: "${field.defaultValue}",
                          onSaved: (v) {
                            values['accountNumber'] = v;
                          },
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT} number is required';
                            }
                            return null;
                          },
                          // controller: controller,
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              labelText:
                                  "${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT} number",
                              hintText: ""),
                        ),
                        TextFormField(
                          // initialValue: "${field.defaultValue}",
                          onSaved: (v) {
                            values["recipientName"] = v;
                          },
                          keyboardType: TextInputType.text,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT} is required';
                            }
                            return null;
                          },
                          // controller: controller,
                          decoration: InputDecoration(
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 0, minHeight: 0),
                              labelText:
                                  "${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT}'s name",
                              hintText: ""),
                        ),
                      ],
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
                      REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_NEXT_TEXT,
                    ),
                  ),
                ),
              ),
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
      store.createTransaction(SwipeServiceOffering.REMITTANCE_INSTAPAY, "");
      _formKey.currentState.save();

      // store.selectedInstapayBank.accountNumber = values["accountNumber"];
      // store.selectedIns
      store.selectedInstapayBank.accountNumber = values["accountNumber"];
      store.selectedInstapayBank.recipientName = values["recipientName"];
      store.setTransactionProduct(
          store.selectedInstapayBank, double.parse(values["amount"]));
      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed validation");
    }
  }
}
