import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/screens/request_money/request-money-screen.dart';
import 'package:swipe/store/application-store.dart';

final store = getIt<ApplicationStore>();

class RequestListScreen extends StatefulWidget {
  @override
  _RequestListScreenState createState() =>
      _RequestListScreenState();
}

class _RequestListScreenState extends State<RequestListScreen> {
  List<NotificationModel> saveRequests = [];

  @override
  void initState() {
    super.initState();
    getSaveRequest();
  }

  getSaveRequest() async {
    saveRequests = await store.requestMoneyService.getSendRequest(store.user);
    print('length ');
    print(saveRequests.length);
    setState(() {});
  }

  Widget _hasSaveRequest() {
    if (saveRequests.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.mark_email_read_rounded,
                size: SizeConfig.blockSizeVertical * 18,
                color: Colors.white),
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
                'Tap the button below to create Invoice request.',
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
            color: Colors.white,
            context: context,
            tiles: saveRequests?.map((res) {
              return ListTile(
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
                        color: Colors.white,
                        fontSize: SizeConfig.blockSizeVertical * 2,
                        fontWeight: FontWeight.bold
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' you request to +${res.receiverMobileNumber} PHP ${res
                            .amount}0',
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: SizeConfig.blockSizeVertical * 1.7,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(
                      top: SizeConfig.blockSizeVertical * 1),
                  child: Row(
                    children: [
                      Container(
                          height: SizeConfig.blockSizeVertical * 3,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: res.status == "Approved" ? COLOR_GREEN : null,
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(20))
                          ),
                          child: Center(
                            child: Text(
                              res.status,
                              style: GoogleFonts.roboto(
                                fontSize: SizeConfig.blockSizeVertical *
                                    1.3,
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
                              fontSize: SizeConfig.blockSizeVertical *
                                  1.5,
                              color: Colors.white
                          )
                      )
                    ],
                  ),
                ),
                trailing: PopupMenuButton(
                  onSelected: (value) {
                    switch(value) {
                      case 'view':
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => RequestMoneyScreen(notification: res),
                            )
                        );
                        break;
                      case 'delete':
                        print('delete');
                        break;
                    }
                  },
                  icon: Icon(Icons.more_vert, color: Colors.white, size: SizeConfig.blockSizeVertical * 2),
                  itemBuilder: (_) => <PopupMenuItem<String>>[
                    new PopupMenuItem<String>(
                      value: 'view',
                      child: Text('View', style: GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 1.7, color: Colors.black)),
                    ),
                    new PopupMenuItem<String>(
                      value: 'delete',
                      child: Text('delete', style: GoogleFonts.roboto(fontSize: SizeConfig.blockSizeVertical * 1.7, color: Colors.black)),
                    ),
                  ],
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
    return Scaffold(
      appBar: SubAppbarWidget(
        elevation: 0,
        title: 'Request Money',
      ),
      body: Container(
        width: SizeConfig.screenWidth,
        child: Column(
          children: [
            _hasSaveRequest(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed('/services/request-money/form');
          },
          child: Icon(Icons.email, color: COLOR_DARK_GRAY)
      ),
    );
  }

}