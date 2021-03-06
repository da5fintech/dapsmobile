import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/util.dart';
import 'package:daps/common/widgets/amount-masking.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/models/auto-suggest-model.dart';
import 'package:daps/models/notification-model.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/models/user-model.dart';
import 'package:daps/screens/payment/processing-failed-dialog.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/main.dart';

final store = getIt<ApplicationStore>();

class DirectSendFormScreen extends StatefulWidget {
  NotificationModel notification;

  DirectSendFormScreen({this.notification});

  @override
  _DirectSendFormScreenState createState() =>
      _DirectSendFormScreenState();

}

class _DirectSendFormScreenState extends State<DirectSendFormScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  AppUtil _appUtil = AppUtil();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController message = TextEditingController();
  List<String> numbers = new List<String>();
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if(widget.notification != null) {
      mobileNumber.text = _appUtil.removeCountryCodeNumber(widget.notification.senderMobileNumber);
      amount.text = widget.notification.amount.toString();
    }
    onLoadNumbers();
  }

  Future onLoadNumbers () async {
    final nums = await store.saveSuggestionsServices.onloadNumbers();
    nums.forEach((n) {
      numbers.add(_appUtil.removeCountryExtension(n.mobileNumber));
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'processing-failed': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: ProcessingFailedDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            title: DIRECT_SEND_SCREEN_DIRECT_SEND_TEXT,
          ),
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: [
                        Text(
                          DIRECT_SEND_FORM_NOTE_MOBILE,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            color: COLOR_DARK_GRAY.withOpacity(0.52),
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SimpleAutoCompleteTextField(
                          key: key,
                          suggestions: numbers,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          controller: mobileNumber,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
                            focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: COLOR_DAPS, width: 2)),
                            errorText: hasError ? "Mobile number is required" : null,
                            errorStyle: TextStyle(
                                color: COLOR_DANGER, fontSize: 12, height: 1),
                            labelText: DIRECT_SEND_FORM_SCREEN_MOBILE,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            prefix: Container(
                              padding: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(
                                    color: Colors.black,
                                    width: 0.5,
                                  ),
                                ),
                              ),
                              child: Text(
                                '+63',
                                style:
                                GoogleFonts.roboto(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                        AmountMasking(
                            controller: amount,
                            onChanged: (string) {
                              string = '${_appUtil.formatNumber(string.replaceAll(',', ''))}';
                              amount.value = TextEditingValue(
                                text: string,
                                selection: TextSelection.collapsed(offset: string.length),
                              );
                            },
                            type: 'Amount',
                            hasError: hasError
                        ),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {},
                          onSaved: (v) {},
                          controller: message,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
                            disabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
                            focusedBorder:
                            UnderlineInputBorder(borderSide: BorderSide(color: COLOR_DAPS, width: 2)),
                            errorStyle: TextStyle(
                                color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            labelText: DIRECT_SEND_FORM_SCREEN_MESSAGE,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.always,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          DIRECT_SEND_FORM_SCREEN_MESSAGE_OPTIONAL,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.roboto(
                            color: COLOR_DARK_GRAY.withOpacity(0.52),
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            fontWeight: FontWeight.w500,
                          ),
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
                      DIRECT_SEND_FORM_SCREEN_NEXT,
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  void _handleNext() async {
    if(mobileNumber.text.length <= 0 || amount.text.length <= 0) {
      hasError = true;
      setState(() {});
    } else {
      try {
        hasError = false;
        modalHudLoad(context);
        // OverlayScreen().show(
        //   context,
        //   identifier: "progress",
        // );
        final a = await store.directPayService.getFees(
            amount.text, mobileNumber.text);
        if(!a.status) {
          // OverlayScreen().pop();
          Navigator.pop(context);
          OverlayScreen().show(
            context,
            identifier: 'processing-failed',
          );
          return null;
        }

        store.createTransaction(SwipeServiceOffering.DIRECT_SEND, "");
        store.setTransactionProduct(DirectPayProduct(
            name: '', mobileNumber: '63${mobileNumber.text}', message: message.text, fee: a.fee, amount: double.tryParse(a.amount), notification: widget.notification),
            double.parse(a.amount));
        // OverlayScreen().pop();
        Navigator.pop(context);
        Get.toNamed("/services/payment/payment-verification-screen");
      } catch(err) {}
    }
  }

}