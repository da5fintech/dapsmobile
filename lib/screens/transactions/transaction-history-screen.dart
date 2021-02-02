import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/models/transaction-model.dart';
import 'package:swipe/store/application-store.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class TransactionHistoryScreen extends StatefulWidget {
  @override
  _BillsPaymentBillersScreenState createState() =>
      _BillsPaymentBillersScreenState();
}

class _BillsPaymentBillersScreenState extends State<TransactionHistoryScreen> {
  List<TransactionRecordModel> transactions = [];
  List<TransactionRecordModel> filteredTransactions = [];
  TextEditingController searchController = TextEditingController();
  bool isSearch = false;
  String activeButton = TRANSACTION_HISTORY_SCREEN_BUTTON_ALL_TEXT;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initTransactions());
    super.initState();
  }

  Widget _button(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      child: ButtonTheme(
        minWidth: 20,
        height: 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: COLOR_DARK_PURPLE,
          ),
        ),
        child: RaisedButton(
          elevation: 0,
          onPressed: () => setState(() => activeButton = text),
          textColor: activeButton == text ? Colors.white : COLOR_DARK_PURPLE,
          color: activeButton == text ? COLOR_DARK_PURPLE : Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text,
            style:
                GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    print("building: ${transactions.length} ");
    ThemeData td = createThemePurpleOnWhite(context);

    return Theme(
      data: td,
      child: Scaffold(
        // backgroundColor: Constants.backgroundColor2,
        appBar: SubAppbarWidget(
          title: TRANSACTION_HISTORY_SCREEN_TITLE_TEXT,
          enableSearch: true,
          onSearch: (text) {
            print("searching ${text}");
            // filteredBillers = transactions.where((element) {
            //   return element.name
            //       .toLowerCase()
            //       .contains(text.toString().toLowerCase());
            // }).toList();

            setState(() {});
          },
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Row(
                children: [
                  _button(TRANSACTION_HISTORY_SCREEN_BUTTON_ALL_TEXT),
                  _button(TRANSACTION_HISTORY_SCREEN_BUTTON_RECEIVED_TEXT),
                  _button(TRANSACTION_HISTORY_SCREEN_BUTTON_SENT_TEXT),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: filteredTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(.36),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    filteredTransactions[index]
                                        .transactionTypePretty,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black.withOpacity(.87),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    dateformatter.format(
                                        filteredTransactions[index]
                                            .creationDate),
                                    style: GoogleFonts.roboto(
                                        color: Colors.black.withOpacity(.87),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  formatter.format(
                                      filteredTransactions[index].totalAmount *
                                          -1),
                                  style: GoogleFonts.roboto(
                                      color: Colors.black.withOpacity(.87),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  TRANSACTION_HISTORY_SCREEN_DETAILS_TEXT,
                                  style: GoogleFonts.roboto(
                                      color: COLOR_DARK_PURPLE.withOpacity(.87),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () {
                      _handleTap(filteredTransactions[index]);
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

  void _handleTap(TransactionRecordModel biller) {}

  initTransactions() async {
    transactions =
        await store.accountService.getTransactionRecords(store.user.id);
    filteredTransactions = transactions;

    setState(() {});
  }
}
