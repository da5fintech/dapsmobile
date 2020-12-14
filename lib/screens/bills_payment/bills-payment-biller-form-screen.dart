import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
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
  Map<String, dynamic> values = Map<String, dynamic>();

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
        initialValue: "${field.defaultValue}",
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
            labelText: "${field.label}",
            hintText: ""),
      );
    }).toList();

    double width = MediaQuery.of(context).size.width * 0.70;
    double height = MediaQuery.of(context).size.height * 0.70;
    var avatar = store.selectedBiller.logo != null
        ? CircleAvatar(
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
            title: "Pay Bills",
          ),
          body: Form(
            key: _formKey,
            child: Container(
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
                                Text("${store.selectedBiller.name}",
                                    style: GoogleFonts.roboto(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500)),
                                Text("Payment will be posted immediately",
                                    style: GoogleFonts.roboto(
                                        fontSize: 12,
                                        color: Colors.white.withOpacity(.6))),
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                      height: height,
                      padding: EdgeInsets.only(left: 25, right: 25),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: fields,
                        ),
                      )),
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
      store.createTransaction(SwipeServiceOffering.BILLS_PAYMENT, "");
      _formKey.currentState.save();

      values.forEach((key, value) {
        store.selectedBiller.setFieldValue(key, value);
      });

      store.setTransactionProduct(store.selectedBiller);
      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed validation");
    }
  }
}
