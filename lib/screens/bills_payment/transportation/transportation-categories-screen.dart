import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/store/application-store.dart';

import '../../../main.dart';

final store = getIt<ApplicationStore>();

class TransportationCategoriesScreen extends StatefulWidget {
  @override
  _TransportationCategoriesScreenState createState() =>
      _TransportationCategoriesScreenState();
}

class _TransportationCategoriesScreenState
    extends State<TransportationCategoriesScreen> {
  List<String> categories = [
    BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_1,
    BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_2,
    BILLS_PAYMENT_TRANSPORTATION_CATEGORIES_OPTION_3
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppbarWidget(
        title: BILLS_PAYMENT_TRANSPORTATION_AUTOSWEEP_TITLE,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: categories.length,
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
                          height: 40.0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                categories[index],
                                style: GoogleFonts.roboto(
                                  color: Colors.black.withOpacity(.87),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black.withOpacity(.54),
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    String category = categories[index];
                    _handleTap(category);
                    print(category);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _handleTap(String category) {
    if (category == 'Autosweep') {
      Get.toNamed(
          '/services/bills-payment/transportation/autosweep-biller-form-screen');
    }
  }
}
