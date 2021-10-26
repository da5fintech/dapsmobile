import 'package:flutter/material.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';

class PayQrUploadScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);

    return DefaultTabController(
      length: 2,
      child: Theme(
        data: td,
        child: Scaffold(
          appBar: SubAppbarWidget(
            enableSearch: true,
            height: 90.0,
            title: PAYQR_UPLOAD_SCREEN_TITLE,
            bottom: TabBar(
              indicatorColor: COLOR_ORANGE,
              tabs: [
                Tab(icon: Text(PAYQR_UPLOAD_TAB_1)),
                Tab(icon: Text(PAYQR_UPLOAD_TAB_2)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                shrinkWrap: true,
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 1,
                    crossAxisSpacing: 1),
                itemBuilder: (BuildContext context, int i) {
                  return Container(
                    height: 100,
                    width: 100,
                    color: COLOR_DARK_PURPLE.withOpacity(.3),
                    child: Center(
                      child: FlutterLogo(size: 100),
                    ),
                  );
                },
              ),
              Text('ALBUM')
            ],
          ),
        ),
      ),
    );
  }
}
