import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/common/widgets/primary-button.widget.dart';
import 'package:daps/models/auto-suggest-model.dart';
import 'package:daps/models/product-model.dart';
import 'package:daps/store/application-store.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class AutosweepBillerFormScreen extends StatefulWidget {
  @override
  _AutosweepBillerFormScreenState createState() =>
      _AutosweepBillerFormScreenState();
}

class _AutosweepBillerFormScreenState extends State<AutosweepBillerFormScreen> {
  final _formKey = GlobalKey<FormState>();
  bool showResult = false;
  List<AutoSweepSuggest> plateNumbers = new List<AutoSweepSuggest>();

  TextEditingController plateNumber = TextEditingController();
  TextEditingController amount = TextEditingController();

  @override
  void initState() {
    super.initState();
    getPlateNumbers();
  }

  Future getPlateNumbers() async {
    List<AutoSweepSuggest> a =
        await store.saveSuggestionsServices.onloadPlateNumbers();
    plateNumbers = a;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    double width = MediaQuery.of(context).size.width * 0.70;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        setState(() => showResult = false);
      },
      child: Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            elevation: 0,
            title: BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TITLE,
          ),
          body: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(
                    bottom: 15.0,
                    top: 5.0,
                    left: 15.0,
                    right: 5.0,
                  ),
                  color: COLOR_DARK_PURPLE,
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage(
                          "assets/icons/autosweep.jpg",
                        ),
                      ),
                      Container(
                        width: width,
                        margin: EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TEXT,
                              style: GoogleFonts.roboto(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              BILLS_PAYMENT_TRANSPORTATION_POSTED_IMMEDIATELY,
                              style: GoogleFonts.roboto(
                                fontSize: 12.0,
                                color: Colors.white.withOpacity(0.6),
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
                    padding: EdgeInsets.only(left: 25.0, right: 25.0),
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              FocusScope(
                                child: Focus(
                                  onFocusChange: (focus) {
                                    setState(() => showResult = focus);
                                  },
                                  child: TextField(
                                    controller: plateNumber,
                                    onChanged: (value) {
                                      setState(() {
                                        plateNumbers = plateNumber.text.isEmpty
                                            ? store.saveSuggestionsServices
                                                .listPlateNumbers
                                            : store.saveSuggestionsServices
                                                .listPlateNumbers
                                                .where((el) => el.plateNumber
                                                    .contains(value)).toList();
                                      });
                                    },
                                    decoration: InputDecoration(
                                      labelText:
                                          BILLS_PAYMENT_TRANSPORTATION_PLATE_NUMBER_TEXT,
                                    ),
                                  ),
                                ),
                              ),
                              TextField(
                                controller: amount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText:
                                      BILLS_PAYMENT_TRANSPORTATION_AMOUNT_TEXT,
                                ),
                              ),
                            ],
                          ),
                          if (showResult && plateNumbers.isNotEmpty) ...[
                            Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.09),
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                width: MediaQuery.of(context).size.width,
                                child: Card(
                                  elevation: 2,
                                  child: ListView.separated(
                                    itemCount: plateNumbers.length,
                                    itemBuilder: (_, int index) {
                                      AutoSweepSuggest plate =
                                          plateNumbers[index];
                                      return ListTile(
                                        onTap: () {
                                          plateNumber.text = plate.plateNumber;
                                          showResult = false;
                                          setState(() {});
                                        },
                                        visualDensity: VisualDensity(
                                            vertical: -4, horizontal: 0),
                                        title: Text(
                                          plate.plateNumber,
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
                    child: PrimaryButtonWidget(
                      color: Colors.white,
                      onPressed: () => {
                        _handleNext(),
                      },
                      text: BILLS_PAYMENT_NEXT_TEXT,
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
      store.createTransaction(SwipeServiceOffering.AUTOSWEEP, plateNumber.text);
      _formKey.currentState.save();

      store.setTransactionProduct(
        AutosweepProduct(plateNumber: plateNumber.text),
        double.parse(amount.text),
      );

      Get.toNamed("/services/payment/payment-verification-screen");
    } else {
      print("failed to validate autosweep form.");
    }
  }
}
