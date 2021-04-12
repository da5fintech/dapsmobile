import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/screens/payment/processing-failed-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class DirectSendFormScreen extends StatefulWidget {
  @override
  _DirectSendFormScreenState createState() =>
      _DirectSendFormScreenState();

}

class _DirectSendFormScreenState extends State<DirectSendFormScreen> {
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();
  final _formKey = GlobalKey<FormState>();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController message = TextEditingController();
  List<String> numbers = new List<String>();

  @override
  void initState() {
    super.initState();
    getSavedNumbers();
  }

  Future getSavedNumbers() async {
    List<String> a = [];
    var loadedNumbers = await store.saveSuggestionsServices.onloadNumbers();
    loadedNumbers.forEach((num) {
      print(num.mobileNumber);
      a.add(num.mobileNumber);
    });

    numbers = a;

    setState(() {});
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
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SimpleAutoCompleteTextField(
                          key: key,
                          suggestions: numbers,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          minLength: 10,
                          controller: mobileNumber,
                          decoration: InputDecoration(
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
                        // TextFormField(
                        //   autofocus: true,
                        //   textInputAction: TextInputAction.next,
                        //   keyboardType: TextInputType.phone,
                        //   maxLength: 10,
                        //   validator: (text) {
                        //     if (text.isEmpty) {
                        //       return '${DIRECT_SEND_FORM_SCREEN_MOBILE} is required';
                        //     }
                        //     return null;
                        //   },
                        //   controller: mobileNumber,
                        //   decoration: InputDecoration(
                        //     errorStyle: TextStyle(
                        //         color: COLOR_DANGER, fontSize: 12, height: 1),
                        //     labelText: DIRECT_SEND_FORM_SCREEN_MOBILE,
                        //     floatingLabelBehavior: FloatingLabelBehavior.always,
                        //     prefix: Container(
                        //       padding: EdgeInsets.only(right: 10),
                        //       decoration: BoxDecoration(
                        //         border: Border(
                        //           right: BorderSide(
                        //             color: Colors.black,
                        //             width: 0.5,
                        //           ),
                        //         ),
                        //       ),
                        //       child: Text(
                        //         '+63',
                        //         style:
                        //         GoogleFonts.roboto(color: Colors.black),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.phone,
                          onFieldSubmitted: (val) {},
                          onSaved: (v) {},
                          validator: (text) {
                            if (text.isEmpty) {
                              return "${DIRECT_SEND_FORM_SCREEN_AMOUNT} is Required!";
                            }
                            return null;
                          },
                          controller: amount,
                          decoration: InputDecoration(
                            errorStyle: TextStyle(
                                color: COLOR_DANGER, fontSize: 12),
                            labelText: DIRECT_SEND_FORM_SCREEN_AMOUNT,
                            floatingLabelBehavior:
                            FloatingLabelBehavior.always,
                          ),
                        ),
                        TextFormField(
                          autofocus: true,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (val) {},
                          onSaved: (v) {},
                          controller: message,
                          decoration: InputDecoration(
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
                            fontSize: 12,
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
    bool status = _formKey.currentState.validate();
    if(status) {
      try {
        OverlayScreen().show(
          context,
          identifier: "progress",
        );
        final a = await store.directPayService.getFees(
            amount.text, mobileNumber.text);
        if(!a.status) {
          OverlayScreen().pop();
          OverlayScreen().show(
            context,
            identifier: 'processing-failed',
          );
          return null;
        }

        store.createTransaction(SwipeServiceOffering.DIRECT_SEND, "");
        store.setTransactionProduct(DirectPayProduct(
            name: '', mobileNumber: '63${mobileNumber.text}', message: message.text, fee: a.fee, amount: double.tryParse(a.amount)),
            double.parse(a.amount));
        OverlayScreen().pop();
        Get.toNamed("/services/payment/payment-verification-screen");
      } catch(err) {}
    }
  }

}