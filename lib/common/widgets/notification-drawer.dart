import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class NotificationDrawer extends StatefulWidget {
  @override
  _NotificationDrawerState createState () =>
      _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  List<NotificationModel> notifications = List<NotificationModel>();

  @override
  void initState () {
    getNotifications();

  }

  Future<void> getNotifications () async {
    notifications = await store.requestMoneyService.getRequest(store.user);
    setState(() {});
  }

  Widget _hasNotifications () {
    if(notifications.length < 0) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notification_important, size: SizeConfig.blockSizeVertical * 18, color: COLOR_DARK_PURPLE),
            Text(
                'Nothing here!',
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                  fontWeight: FontWeight.bold,
                  color: COLOR_DARK_PURPLE,
                )
            ),
            SizedBox(height: 20),
            Text(
                'Tap the notification button below and\ncheck again',
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontSize: SizeConfig.blockSizeVertical * 2.3,
                  fontWeight: FontWeight.w300,
                  color: Colors.grey[500],
                )
            )
          ],
        ),
      );
    } else {
      return Expanded(
        child: ListView(
          children: ListTile.divideTiles(
            context: context,
            tiles: notifications?.map((res) {
              return ListTile(
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: CircleAvatar(
                  backgroundColor: COLOR_ORANGE,
                  child: store.user.photoURL == null
                      ? Text(
                    store.user.getInitials(),
                    style: GoogleFonts.roboto(color: Colors.white),
                  )
                      : ClipOval(
                    child: Image.network(store.user.photoURL),
                  ),
                ),
                title: RichText(
                  text: TextSpan(
                    text: res.senderDisplayName,
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: SizeConfig.blockSizeVertical * 2,
                      height: 1.5,
                      fontWeight: FontWeight.bold
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' was requesting you to send PHP ${res.amount}0',
                        style: GoogleFonts.roboto(
                          color: COLOR_DARK_GRAY,
                          fontSize: SizeConfig.blockSizeVertical * 1.7,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: InkWell(
                  onTap: () {},
                  child: Icon(Icons.send_to_mobile)
                ),
              );
            })?.toList() ?? []
          ).toList()
        )
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight,
      width: SizeConfig.screenWidth,
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Notification',
              style: GoogleFonts.roboto(
                fontSize: SizeConfig.blockSizeVertical * 3,
                fontWeight: FontWeight.w700,
                color: Colors.black
              )
            ),
            trailing: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.close, color: COLOR_DARK_GRAY),
            ),
          ),
          _hasNotifications(),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              color: COLOR_DARK_PURPLE,
              onPressed: () async {
                getNotifications();
              },
              child: Text('Refresh', style: TextStyle(color: Colors.white)),
            )
          )
        ],
      ),
    );
  }
}