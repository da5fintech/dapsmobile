import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class BillsPaymentSelectBillerScreen extends StatefulWidget {
  @override
  _BillsPaymentSelectBillerScreen createState() =>
      _BillsPaymentSelectBillerScreen();
}

class _BillsPaymentSelectBillerScreen extends State<BillsPaymentSelectBillerScreen> {
  List<BillerProduct> billers = store.billers;
  List<BillerProduct> filteredBillers = store.billers;
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) => initBillers());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print("building: ${billers.length} ");
    double width = MediaQuery.of(context).size.width * 0.70;
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          title:
          "${BILLS_PAYMENT_BILLER_SCREEN_ALL_BILLERS_TEXT} (${store.selectedBillerCategory})",
          enableSearch: true,
          onSearch: (text) {
            print("searching ${text}");
            filteredBillers = billers.where((element) {
              return element.name
                  .toLowerCase()
                  .contains(text.toString().toLowerCase());
            }).toList();

            setState(() {});
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(5),
                itemCount: filteredBillers.length,
                itemBuilder: (BuildContext context, int index) {
                  return filteredBillers[index].enabled == false
                      ? Container()
                      : GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withOpacity(.36),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: width,
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filteredBillers[index].name,
                                  style: GoogleFonts.roboto(
                                      color:
                                      Colors.black.withOpacity(.87),
                                      fontSize: SizeConfig.blockSizeVertical * 2,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.black.withOpacity(.54),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      addBiller(filteredBillers[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void addBiller(BillerProduct biller) {
    store.addBillerService.addBiller(biller);
    List<BillerProduct> savedBiller = store.addBillerService.billers;
    store.setNewBiller(savedBiller);
    Navigator.pop(context);
    Navigator.pop(context);
  }
}