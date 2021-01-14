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
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => initTransactions());
    super.initState();
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
            title: "Transactions",
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
              Expanded(
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: filteredTransactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.withOpacity(.36)))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
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
                                            color:
                                                Colors.black.withOpacity(.87),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                        dateformatter.format(
                                            filteredTransactions[index]
                                                .creationDate),
                                        style: GoogleFonts.roboto(
                                            color:
                                                Colors.black.withOpacity(.87),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                      formatter.format(
                                          filteredTransactions[index]
                                                  .totalAmount *
                                              -1),
                                      style: GoogleFonts.roboto(
                                          color: Colors.black.withOpacity(.87),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Details",
                                      style: GoogleFonts.roboto(
                                          color: COLOR_DARK_PURPLE
                                              .withOpacity(.87),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          _handleTap(filteredTransactions[index]);
                        },
                      );
                    }),
              ),
            ],
          )),
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
