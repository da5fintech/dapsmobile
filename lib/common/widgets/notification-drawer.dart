import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/screens/request_money/request-money-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class NotificationDrawer extends StatefulWidget {
  List<NotificationModel> notifications;
  final Function directSend;
  final Function close;

  NotificationDrawer({
    this.notifications,
    this.directSend,
    this.close
  });

  @override
  _NotificationDrawerState createState () =>
      _NotificationDrawerState();
}

class _NotificationDrawerState extends State<NotificationDrawer> {
  List<NotificationModel> notifications = List<NotificationModel>();

  @override
  void initState () {
    notifications = widget.notifications;
  }

  Future<void> getNotifications () async {
    notifications = await store.requestMoneyService.getRequest(store.user);
    setState(() {});
  }

  Widget _hasNotifications () {
    if(notifications.isEmpty) {
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
                  color: COLOR_DAPS,
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
                onLongPress: () async {
                  _deleteNotification(res);
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => RequestMoneyScreen(notification: res))
                  );
                },
                tileColor: !res.isSeen ? COLOR_BLUE.withOpacity(0.2) : null,
                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                leading: CircleAvatar(
                  backgroundColor: COLOR_ORANGE,
                  child: store.user.photoURL == null
                      ? Text(
                    res.senderDisplayName.substring(0, 1).toUpperCase(),
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
                subtitle: Padding(
                  padding: EdgeInsets.only(top: SizeConfig.blockSizeVertical * 1),
                  child: Row(
                    children: [
                      Container(
                          height: SizeConfig.blockSizeVertical * 3,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: COLOR_DAPS,
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: Center(
                            child: Text(
                              res.status,
                              style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical * 1.3,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                      ),
                      Spacer(),
                      Text(
                        res.createdAt,
                        style: GoogleFonts.roboto(
                          fontSize: SizeConfig.blockSizeVertical * 1.5,
                          color: COLOR_DARK_GRAY
                        )
                      )
                    ],
                  ),
                ),
                trailing: InkWell(
                  onTap: () async {
                    if(res.status != 'Closed') {
                      await _confirmationModal(res);
                    }
                  },
                  child: Icon(Icons.send_to_mobile, color: res.status != 'Closed' ? COLOR_DAPS : COLOR_DARK_GRAY)
                ),
              );
            })?.toList() ?? []
          ).toList()
        )
      );
    }
  }

  Future<Widget> _confirmationModal (NotificationModel n) async {
    return showDialog(
        context: context,
        builder: (_) => SwipeDialog(
          title: 'Confirmation',
          contentMessage: '${n.senderDisplayName} was requesting you to send PHP ${n.amount}',
          cancelBtn: true,
          textAlign: TextAlign.center,
          onOk: () {
            widget.directSend(n);
          },
          cancel: () {
            Navigator.pop(context);
          },
        )
    );
  }

  Future<Widget> _deleteNotification (NotificationModel n) async{
    return showDialog(
        context: context,
        builder: (_) => SwipeDialog(
          title: 'Delete this request?',
          contentMessage: "Are you sure you want to delete this request? The Sender will not know you've decline the request",
          cancelBtn: true,
          textAlign: TextAlign.left,
          onOk: () async {
            store.requestMoneyService.deleteRequest(store.user, n);
            store.notifications.remove(n);
            setState(() {});
            Navigator.pop(context);
          },
          cancel: () {
            Navigator.pop(context);
          },
        )
    );
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
              onPressed: () async {
                widget.close();

              },
              icon: Icon(Icons.close, color: COLOR_DARK_GRAY),
            ),
          ),
          _hasNotifications(),
          ButtonTheme(
            minWidth: double.infinity,
            child: RaisedButton(
              color: COLOR_DAPS,
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