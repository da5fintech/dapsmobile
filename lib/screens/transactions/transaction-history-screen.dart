import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
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
  List<TransactionRecordModel> searchResults = [];
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
            setState(() {
              filteredTransactions = text == ""
                  ? transactions
                  : transactions
                      .where((el) => el.product
                          .toLowerCase()
                          .contains(text.toString().toLowerCase()))
                      .toList();
            });
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
                child: ListView(
              children: filteredTransactions?.map((transaction) {
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
                                      '${transaction.transactionTypePretty} (${transaction.product})',
                                      style: GoogleFonts.roboto(
                                          color: Colors.black.withOpacity(.87),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      dateformatter
                                          .format(transaction.creationDate),
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
                                    formatter
                                        .format(transaction.totalAmount * -1),
                                    style: GoogleFonts.roboto(
                                        color: Colors.black.withOpacity(.87),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showDetails(transaction);
                                    },
                                    child: Text(
                                      TRANSACTION_HISTORY_SCREEN_DETAILS_TEXT,
                                      style: GoogleFonts.roboto(
                                          color: COLOR_DARK_PURPLE
                                              .withOpacity(.87),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
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
                        _handleTap(transaction);
                      },
                    );
                  })?.toList() ??
                  [],
            )),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void showDetails(TransactionRecordModel transaction) {
    OverlayScreen().saveScreens({
      'details': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: AlertDialog(
          actionsPadding: EdgeInsets.only(top: 10, bottom: 10),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          title: Text(
            TRANSACTION_HISTORY_SCREEN_DETAILS_TEXT,
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
          ),
          content: Container(
            height: MediaQuery.of(context).size.height * 0.10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TRANSACTION_HISTORY_SENT_TEXT,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: COLOR_DARK_GRAY),
                    ),
                    Text(
                      transaction.product,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TRANSACTION_HISTORY_AMOUNT_TEXT,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: COLOR_DARK_GRAY),
                    ),
                    Text(
                      transaction.amount.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TRANSACTION_HISTORY_END_BALANCE_TEXT,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: COLOR_DARK_GRAY),
                    ),
                    Text(
                      store.user.balance.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TRANSACTION_HISTORY_DATE_TIME_TEXT,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: COLOR_DARK_GRAY),
                    ),
                    Text(
                      transaction.creationDate.toString(),
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      TRANSACTION_HISTORY_REFERENCE_TEXT,
                      style: GoogleFonts.roboto(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: COLOR_DARK_GRAY),
                    ),
                    Text(
                      transaction.reference,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                child: Text(
                  SOON_RELEASED_SCREEN_OK_TEXT,
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.w500,
                      color: COLOR_DARK_PURPLE,
                      fontSize: 14),
                ),
                onTap: () {
                  OverlayScreen().pop();
                },
              ),
            ),
          ],
        ),
      )
    });
    OverlayScreen().show(
      context,
      identifier: 'details',
    );
  }

  void _handleTap(TransactionRecordModel biller) {}

  initTransactions() async {
    transactions =
        await store.accountService.getTransactionRecords(store.user.id);
    filteredTransactions = transactions;

    setState(() {});
  }
}
