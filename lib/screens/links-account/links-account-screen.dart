import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class LinksAccountScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Links Account',
        ),
        body: ListView(
          children: [
            ListTile(
              visualDensity: VisualDensity(vertical: -4, horizontal: 0),
              title: Transform(
                transform: Matrix4.translationValues(-20, 0.0, 0),
              ),
              trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black.withOpacity(.54)),
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
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.black.withOpacity(.54)),
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