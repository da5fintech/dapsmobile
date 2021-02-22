import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/auto-suggest-model.dart';
import 'package:swipe/services/save-suggestions-services.dart';
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
  bool showSuggestion = false;
  List<BuyLoadSuggest> numbers = [];

  @override
  void initState() {
    super.initState();
    getSavedNumbers();
  }

  Future getSavedNumbers() async {
    numbers = await store.saveSuggestionsServices.onloadNumbers();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Theme(
        data: td,
        child: Scaffold(
          // backgroundColor: Constants.backgroundColor2,
          appBar: SubAppbarWidget(
            title: BUY_LOAD_TITLE_TEXT,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FocusScope(
                                child: Focus(
                                  onFocusChange: (focus) {
                                    showSuggestion = focus;
                                    setState(() {});
                                  },
                                  child: TextFormField(
                                    keyboardType: TextInputType.phone,
                                    validator: (text) {
                                      if (text == null || text.isEmpty) {
                                        return '${BUY_LOAD_MOBILE_TEXT} number is required';
                                      }
                                      return null;
                                    },
                                    onChanged: (text) {
                                      setState(() {
                                        showSuggestion = true;
                                        numbers = controller.text.isEmpty
                                            ? store
                                                .saveSuggestionsServices.saveNumbers
                                            : store
                                                .saveSuggestionsServices.saveNumbers
                                                .where((el) =>
                                                    el.mobileNumber.contains(text))
                                                .toList();
                                      });
                                    },
                                    controller: controller,
                                    decoration: InputDecoration(
                                        prefixIconConstraints:
                                            BoxConstraints(minWidth: 0, minHeight: 0),
                                        labelText:
                                            BUY_LOAD_RECIPIENT_SCREEN_LOAD_FOR_TEXT,
                                        hintText: "639012345678"),
                                  ),
                                ),
                              ),
                              Text(
                                'Add 63 to the recipient e.g 639123456789',
                                style: GoogleFonts.roboto(
                                  color: COLOR_DARK_GRAY.withOpacity(0.5),
                                  fontSize: 12,
                                  height: 2,
                                  fontWeight: FontWeight.w500,
                                )
                              ),
                              if (showSuggestion && numbers.isNotEmpty) ...[
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.20,
                                  width: MediaQuery.of(context).size.width,
                                  child: Card(
                                    child: ListView.separated(
                                      itemCount: numbers.length,
                                      itemBuilder: (_, int index) {
                                        BuyLoadSuggest suggestion =
                                            numbers[index];
                                        return ListTile(
                                          visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                          onTap: () {
                                            controller.text = suggestion.mobileNumber;
                                            showSuggestion = false;
                                            setState(() {});
                                          },
                                          title: Text(suggestion.mobileNumber,
                                              style: GoogleFonts.roboto(
                                                  color: Colors.black)),
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
                                )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
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
                          BUY_LOAD_NEXT_TEXT,
                        ),
                      ),
                    ),
                  )
                ],
              ),
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

  void _handleNext() async {
    bool status = _formKey.currentState.validate();
    if (status == true) {
      store.createTransaction(SwipeServiceOffering.BUY_LOAD, controller.text);
      Get.toNamed('/services/buy-load/buy-load-amount-screen');
    }
  }
}
