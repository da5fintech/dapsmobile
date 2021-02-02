import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/store/application-store.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class RemittanceInstapayBanksScreen extends StatefulWidget {
  @override
  _RemittanceInstapayBanksScreenState createState() =>
      _RemittanceInstapayBanksScreenState();
}

class _RemittanceInstapayBanksScreenState
    extends State<RemittanceInstapayBanksScreen> {
  List<InstapayBankProduct> banks = store.instapayBanks;
  List<InstapayBankProduct> filteredBanks = store.instapayBanks;
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
    print("building: ${banks.length} ");
    double width = MediaQuery.of(context).size.width * 0.70;
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          title: REMITTANCE_INSTAPAY_BANK_SCREEN_SELECT_BANK_TEXT,
          enableSearch: true,
          onSearch: (text) {
            print("searching ${text}");
            filteredBanks = banks.where((element) {
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
                itemCount: filteredBanks.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(.36),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 35,
                            width: width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  filteredBanks[index].name,
                                  style: GoogleFonts.roboto(
                                      color: Colors.black.withOpacity(.87),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.chevron_right,
                              color: Colors.black.withOpacity(.54),
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _handleTap(filteredBanks[index]);
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

  void _handleTap(InstapayBankProduct bank) {
    store.selectedInstapayBank = bank;
    Get.toNamed(
        '/services/remittance/instapay/remittance-instapay-bank-form-screen');
  }
}
