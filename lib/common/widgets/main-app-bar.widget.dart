import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/main.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize; // default is 56.0
  final double elevation;
  final Function onPressed;
  AppUtil _appUtil = AppUtil();
  double queryData;

  MainAppBarWidget({Key key, this.elevation, this.onPressed, this.queryData})
      : preferredSize = Size.fromHeight(queryData * 25),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: elevation,
      centerTitle: true,
      leading: IconButton(
          icon: Icon(Icons.list, size: queryData * 12),
          onPressed: () {
            onPressed('drawer');
          }),
      title: Text(APP_NAME,
          style: GoogleFonts.roboto(
              fontSize: queryData * 6, fontWeight: FontWeight.w800, letterSpacing: 15)),
      actions: [
        Container(
          width: SizeConfig.blockSizeVertical * 8,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    onPressed('notification');
                  },
                  child: Icon(
                    Icons.notifications,
                    size: SizeConfig.blockSizeVertical * 3.5,
                  ),
                ),
              ),
              if(_appUtil.countUnseenNotifications(store.notifications) > 0) ...[
                Observer(
                  builder: (_) => Positioned(
                    top: SizeConfig.blockSizeVertical * 4.5,
                    right: SizeConfig.blockSizeVertical * 0.5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                      alignment: Alignment.bottomCenter,
                      child: Text(_appUtil.countUnseenNotifications(store.notifications).toString()),
                    ),
                  ),
                )
              ]

            ],
          ),
        ),
        SizedBox(
          width: queryData * 5,
        )
      ],
    );
  }
}
