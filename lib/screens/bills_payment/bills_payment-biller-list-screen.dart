import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/fixtures.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/product-model.dart';
import 'package:swipe/screens/bills_payment/category-button-widget.dart';
import 'package:get_it/get_it.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class BillsPaymentBillerListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: BILLS_PAYMENT_CATEGORIES_SCREEN_ADD_BILLER_TEXT,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.only(top: 20),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 0,
                    crossAxisSpacing: 20),
                itemCount: billerList.length,
                itemBuilder: (BuildContext context, int i) {
                  return CategoryButtonWidget(
                      onPressed: (category) {
                        store.addBillerService.AddBiller(SavedBiller(
                            title: billerList[i]['title'], imagePath: billerList[i]['imagePath']));
                        Navigator.pop(context);
                      },
                      category: billerList[i]['title'],
                      text: billerList[i]['title'],
                      icon: Image.asset(billerList[i]['imagePath']));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
