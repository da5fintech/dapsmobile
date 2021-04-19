import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/greet-dialog.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/screens/links-account/union-bank/union-bank-login-screen.dart';
import 'package:swipe/screens/links-account/union-bank/union-bank-web-view-screen.dart';

class LinksAccountScreen extends StatefulWidget {
  @override
  _LinksAccountScreenState createState() => _LinksAccountScreenState();
}

class _LinksAccountScreenState extends State<LinksAccountScreen> {
  String isSelected;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    OverlayScreen().saveScreens({
      'enroll': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: SwipeDialog(
            title: "Enroll your ${isSelected == 'union'
                ? "Union Bank"
                : "BPI"} Account",
            contentMessage: "It seems that you have not yet enrolled your ${isSelected ==
                'union'
                ? "Union Bank"
                : "BPI"} Account. To proceed with cash-in, please enroll your ${isSelected ==
                'union' ? "Union Bank" : "BPI"} account.",
            cancelBtn: true,
            cancel: () {
              setState(() {
                isSelected = "";
              });
            },
            onOk: () {
              if (isSelected == 'union') {
                OverlayScreen().pop();
                String url =
                    "${UNION_BANK_ENDPOINT}"
                    "/authorize?client_id=${UNION_BANK_CLIENT_ID}&"
                    "response_type=${UNION_BANK_RESPONSE_TYPE}&"
                    "scope=${UNION_BANK_SCOPE}&"
                    "redirect_uri=${UNION_BANK_REDIRECT_URI}&"
                    "state=${UNION_BANK_STATE}&"
                    "type=${UNION_BANK_LINKING}&"
                    "partnerId=${UNION_BANK_PARTNER_ID}";

                Navigator.push(context, MaterialPageRoute(
                    builder: (_) => UnionBankWebView(uri: url)));
              }
              return null;
            },
          )
      ),
    });

    return Theme(
        data: td,
        child: Scaffold(
            appBar: SubAppbarWidget(
              title: LINKS_ACCOUNT_SCREEN_TITLE,
            ),
            body: ListView(
              children: [
                ListTile(
                    onTap: () {
                      setState(() {
                        isSelected = "bpi";
                      });
                      OverlayScreen().show(
                          context,
                          identifier: 'enroll'
                      );
                    },
                    visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                    title: Transform(
                      transform: Matrix4.translationValues(-20, 0.0, 0),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16,
                        color: Colors.black.withOpacity(.54)),
                    leading: ImageIcon(
                      AssetImage('assets/icons/links-accounts/bpi.png'),
                      size: 50,
                    )
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 0.5,
                ),
                ListTile(
                    onTap: () {
                      setState(() {
                        isSelected = "union";
                      });
                      OverlayScreen().show(
                          context,
                          identifier: 'enroll'
                      );
                    },
                    visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                    title: Transform(
                      transform: Matrix4.translationValues(-20, 0.0, 0),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16,
                        color: Colors.black.withOpacity(.54)),
                    leading: ImageIcon(
                      AssetImage('assets/icons/links-accounts/unionbank.png'),
                      size: 50,
                    )
                ),
                Divider(
                  color: Colors.grey.withOpacity(0.5),
                  thickness: 0.5,
                ),
              ],
            )
        )
    );
  }
}