import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class RemittancePesonetBankFormScreen extends StatefulWidget {
  @override
  _RemittancePesonetBankFormScreenState createState() =>
      _RemittancePesonetBankFormScreenState();
}

class _RemittancePesonetBankFormScreenState
    extends State<RemittancePesonetBankFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;

  String selectedRadio = "";
  ProductModel selectedPromo;
  List<ProductModel> promoProducts = new List<ProductModel>();
  List<AccountRecipient> savedRecipients = new List<AccountRecipient>();
  Map<String, dynamic> values = Map<String, dynamic>();
  TextEditingController amountController = TextEditingController();
  TextEditingController accountNumController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSavedAccountDetails();
  }

  Future getSavedAccountDetails() async {
    savedRecipients =
    await store.saveSuggestionsServices.onloadAccountDetails();
    setState(() {});
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
      radius: SizeConfig.blockSizeVertical * 3,
      child:
      Text("${store.selectedPesonetBank.name.characters.characterAt(0)}"),
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Theme(
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
                  color: COLOR_DAPS,
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
                              "${store.selectedPesonetBank.name}",
                              style: GoogleFonts.roboto(
                                  fontSize: SizeConfig.blockSizeVertical * 2.2,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_PAYMENT_POSTED_TEXT,
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
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              TextFormField(
                                // initialValue: "${field.defaultValue}",
                                keyboardType: TextInputType.number,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT} is required';
                                  }
                                  return null;
                                },
                                controller: amountController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    labelText:
                                    REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_AMOUNT_TEXT,
                                    hintText: ""),
                              ),
                              FocusScope(
                                child: Focus(
                                  onFocusChange: (focus) {
                                    setState(() {
                                      showResult = focus;
                                    });
                                  },
                                  child: TextFormField(
                                    // initialValue: "${field.defaultValue}",
                                    keyboardType: TextInputType.text,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT} number is required';
                                      }
                                      return null;
                                    },
                                    controller: accountNumController,
                                    onChanged: (text) {
                                      setState(() {
                                        savedRecipients = accountNumController
                                            .text.isEmpty
                                            ? store.saveSuggestionsServices
                                            .listAccountNumbers
                                            : store.saveSuggestionsServices
                                            .listAccountNumbers
                                            .where((el) => el.accountNumber
                                            .contains(text)).toList();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(.6),
                                          ),
                                        ),
                                        disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.withOpacity(.6),
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey, width: 2),
                                        ),
                                        prefixIconConstraints: BoxConstraints(
                                            minWidth: 0, minHeight: 0),
                                        labelText:
                                        "${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_ACCOUNT_TEXT} number",
                                        hintText: ""),
                                  ),
                                ),
                              ),
                              TextFormField(
                                // initialValue: "${field.defaultValue}",
                                keyboardType: TextInputType.text,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return '${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT} is required';
                                  }
                                  return null;
                                },
                                controller: fullnameController,
                                decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                    disabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.grey.withOpacity(.6),
                                      ),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey, width: 2),
                                    ),
                                    prefixIconConstraints: BoxConstraints(
                                        minWidth: 0, minHeight: 0),
                                    labelText:
                                    "${REMITTANCE_INSTAPAY_BANK_FORM_SCREEN_RECIPIENT_TEXT}'s name",
                                    hintText: ""),
                              ),
                            ],
                          ),
                          if (showResult && savedRecipients.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.17),
                                height:
                                MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 2,
                                  child: ListView.separated(
                                    itemCount: savedRecipients.length,
                                    itemBuilder: (_, int index) {
                                      AccountRecipient user =
                                      savedRecipients[index];
                                      return ListTile(
                                        onTap: () {
                                          accountNumController.text =
                                              user.accountNumber;
                                          fullnameController.text =
                                              user.fullname;
                                          showResult = false;
                                          setState(() {});
                                        },
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: 0),
                                        title: Text(
                                          user.accountNumber,
                                          style: GoogleFonts.roboto(
                                            color: COLOR_DARK_GRAY,
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder: (_, int index) {
                                      return Divider(
                                        color: Colors.black,
                                        thickness: 0.5,
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
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
      store.createTransaction(SwipeServiceOffering.REMITTANCE_PESONET, "");
      store.selectedPesonetBank.accountNumber = accountNumController.text;
      store.selectedPesonetBank.recipientName = fullnameController.text;
      store.setTransactionProduct(
          store.selectedPesonetBank, double.parse(amountController.text));
      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed validation");
    }
  }
}
