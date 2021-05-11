import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/main.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/models/notification-model.dart';

final store = getIt<ApplicationStore>();

class RequestFormScreen extends StatefulWidget {
  NotificationModel notification;
  String amount;
  String date;
  TextEditingController subjectRequest;
  TextEditingController messageRequest;
  Function onChangeSubject;
  Function onChangeMessage;

  RequestFormScreen({
    this.notification = null,
    this.amount,
    this.date,
    this.subjectRequest,
    this.messageRequest,
    this.onChangeSubject,
    this.onChangeMessage,
  });
  @override
  _RequestFormScreenState createState () =>
      _RequestFormScreenState();
}

class _RequestFormScreenState extends State<RequestFormScreen> {
  TextEditingController subjectRequest = TextEditingController();
  TextEditingController messageRequest = TextEditingController();
  String converted;

  @override
  void initState () {
    subjectRequest.text = widget.subjectRequest.text;
    messageRequest.text = widget.messageRequest.text;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: SubAppbarWidget(
        elevation: 0,
        title: 'Request Money',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: 'request',
              child: Container(
                child: Stack(
                  children: [
                    Container(
                      height: SizeConfig.blockSizeVertical * 80,
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.all(20),
                      child: Card(
                          child: Column(
                            children: [
                              SizedBox(height: SizeConfig.blockSizeVertical * 10),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                                leading: CircleAvatar(
                                  radius: SizeConfig.blockSizeVertical * 3,
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
                                title: Text(
                                    widget.notification == null ? store.user.displayName : widget.notification.senderDisplayName,
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                                subtitle: Text(
                                    widget.notification == null ? '+${store.user.mobileNumber}' : '+${widget.notification.senderMobileNumber}',
                                    style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: SizeConfig.blockSizeVertical * 2,
                                        fontWeight: FontWeight.w500
                                    )
                                ),
                              ),
                              Divider(
                                thickness: 1.5,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        readOnly: widget.notification != null ? true : false,
                                        controller: subjectRequest,
                                        autofocus: false,
                                        textInputAction: TextInputAction.next,
                                        style: TextStyle(color: Colors.black),
                                        onChanged: (string) {
                                          widget.onChangeSubject(string);
                                        },
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: TextStyle(color: Colors.black),
                                          errorStyle: TextStyle(
                                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                                          labelText: 'Subject for request:',
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Expanded(
                                      flex: 1,
                                      child: TextFormField(
                                        initialValue: widget.date,
                                        readOnly: true,
                                        autofocus: false,
                                        style: TextStyle(color: Colors.black),
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.black),
                                          ),
                                          errorStyle: TextStyle(
                                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                                          labelStyle: TextStyle(color: Colors.black),
                                          labelText: 'Date:',
                                          floatingLabelBehavior:
                                          FloatingLabelBehavior.always,
                                        ),
                                      ),
                                    )
                                 ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  child: TextFormField(
                                    readOnly: widget.notification != null ? true : false,
                                    controller: messageRequest,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 100,
                                    autofocus: false,
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (string) {
                                      widget.onChangeMessage(string);
                                    },
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black),
                                      ),
                                      errorStyle: TextStyle(
                                          color: COLOR_GRAY, fontSize: 12, height: 0.3),
                                      labelStyle: TextStyle(color: Colors.black),
                                      hintStyle: TextStyle(color: Colors.grey[500]),
                                      hintText:
                                        "E.g Good day Mr/Mrs. Dela Cruz\n\n"
                                        "How are you?\n"
                                        "----------------------\n"
                                        "content of the message\n"
                                        "-----------------------\n",
                                      labelText: 'Invoice Message: (optional)',
                                      floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                          backgroundColor: COLOR_DARK_ORANGE,
                          radius: SizeConfig.blockSizeVertical * 5.5,
                          child: Text(
                              '₱ ${widget.amount}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                  color: Colors.white,
                                  fontSize: SizeConfig.blockSizeVertical * 2.5,
                                  fontWeight: FontWeight.bold
                              )
                          )
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}