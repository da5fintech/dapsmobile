import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/widgets/amount-masking.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/common/widgets/swipe-dialog.dart';
import 'package:swipe/main.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/screens/payment/processing-failed-dialog.dart';
import 'package:swipe/screens/request_money/request-form-screen.dart';
import 'package:intl/intl.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/models/notification-model.dart';
import 'package:swipe/models/transaction-model.dart';

final store = getIt<ApplicationStore>();

class RequestMoneyScreen extends StatefulWidget {
  NotificationModel notification;

  RequestMoneyScreen({this.notification = null});

  @override
  _RequestMoneyScreenState createState () =>
      _RequestMoneyScreenState();

}

class _RequestMoneyScreenState extends State<RequestMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  bool hasError = false;
  String currentDate;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  AppUtil _appUtil = AppUtil();
  TextEditingController amount = TextEditingController(text: "100");
  TextEditingController subjectRequest = TextEditingController();
  TextEditingController messageRequest = TextEditingController();
  TextEditingController purposeRequest = TextEditingController();
  TextEditingController receiver = TextEditingController();

  @override
  void initState () {
    var outputDate = DateFormat('MM/dd/yyyy');
    var date = outputDate.format(DateTime.now());
    currentDate = date;

    if(widget.notification != null) {
      currentDate = widget.notification.createdAt;
      amount.text = widget.notification.amount.toString();
      subjectRequest.text = widget.notification.subject;
      messageRequest.text = widget.notification.subject;
      purposeRequest.text = widget.notification.purpose;
      receiver.text = _appUtil.removeCountryCodeNumber(widget.notification.receiverMobileNumber);
    }

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);

    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 10.0),
            Text(
              "Loading...",
              style: GoogleFonts.roboto(color: Colors.white),
            ),
          ],
        ),
      ),
      'success': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: SwipeDialog(
          title: "Request Sent!",
          contentMessage: "Your request has been sent!",
          cancelBtn: false,
          onOk: () {
            OverlayScreen().pop();
            Navigator.pop(context);
            Navigator.pop(context);
          },
        ),
      ),
      'processing-failed': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: ProcessingFailedDialog(
          onOk: () {
            OverlayScreen().pop();
          },
        ),
      ),
    });

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: SubAppbarWidget(
          elevation: 0,
          title: 'Request Money',
        ),
        body: Column(
          children: [
            Hero(
              tag: 'request',
              child: Container(
                height: SizeConfig.blockSizeVertical * 35,
                child: Stack(
                  children: [
                    Container(
                      width: SizeConfig.screenWidth,
                      margin: EdgeInsets.all(20),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                            ListTile(
                              visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                              onTap: () {
                                _navigateToForm();
                              },
                              title: Text(
                                subjectRequest.text == "" ? 'Subject For request' : subjectRequest.text,
                                style: GoogleFonts.roboto(
                                  color: Colors.black,
                                  fontSize: SizeConfig.blockSizeVertical * 1.7
                                )
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
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
                          '₱ ${amount.text}',
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
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: SizeConfig.screenWidth * 0.40),
                      child: AmountMasking(
                        noUnderline: true,
                        controller: amount,
                        onChanged: (string) {
                          amount.value = TextEditingValue(
                            text: string,
                            selection: TextSelection.collapsed(offset: string.length),
                          );
                          setState(() {});
                        },
                        type: 'Amount',
                        hasError: hasError,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                      title: TextFormField(
                        controller: purposeRequest,
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(color: Colors.white),
                        validator: (text) {
                          if(text.isEmpty) {
                            return "Purpose for this request is required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          labelStyle: TextStyle(color: Colors.white),
                          hintText: "e.g. Bills payment",
                          errorStyle: TextStyle(
                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          labelText: 'Purpose for this Request.',
                          floatingLabelBehavior:
                          FloatingLabelBehavior.always,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -4, horizontal: 0),
                      title: Row(
                        children: [
                          Text(
                            'Fee',
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              height: 2,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                          Spacer(),
                          Text(
                            "It's free!",
                            style: GoogleFonts.roboto(
                              fontSize: SizeConfig.blockSizeVertical * 2,
                              height: 2,
                              fontWeight: FontWeight.bold,
                            )
                          ),
                        ],
                      ),
                      subtitle: RichText(
                        text: TextSpan(
                          text: 'You pay no fee when requesting money domestically with your bank or balance. ',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: SizeConfig.blockSizeVertical * 1.7,
                            height: 1.5,
                          ),
                          children: [
                            TextSpan(
                              recognizer: new TapGestureRecognizer()
                                ..onTap = () {
                                },
                              text: 'Learn More',
                              style: GoogleFonts.roboto(
                                color: Colors.white,
                                height: 1.5,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ]
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: TextFormField(
                        autofocus: false,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        controller: receiver,
                        onFieldSubmitted: (val) {
                        },
                        onSaved: (v) {
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return '${REGISTER_SCREEN_MOBIILE_TEXT} is required';
                          }
                          return null;
                        },
                        maxLength: 10,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          counterStyle: TextStyle(color: Colors.white),
                          hintText: "904033902",
                          errorStyle: TextStyle(
                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          labelText: 'Sending from',
                          floatingLabelBehavior:
                          FloatingLabelBehavior.always,
                          prefix: Container(
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              '+63',
                              style:
                              GoogleFonts.roboto(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            if(widget.notification == null) ...[
              SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      if(amount.text == "") {
                        hasError = true;
                      } else {
                        hasError = false;
                      }
                      setState(() {});

                      if(subjectRequest.text == "") {
                        _navigateToForm();
                      } else {
                        _handleNext();
                      }
                    },
                    child: Text('Request Now'),
                  )
              )
            ]
          ],
        ),
      ),
    );
  }

  _handleNext() async {
    bool status = _formKey.currentState.validate();
    if(status || hasError) {
      try {
        //find reciever id number
        var notificationModel = new NotificationModel(amount: _appUtil.unFormatAmount(amount.text));
        notificationModel.profilePhoto = store.user.photoURL;
        notificationModel.ownerId = store.user.id;
        notificationModel.senderDisplayName = store.user.displayName;
        notificationModel.senderMobileNumber = store.user.mobileNumber;
        notificationModel.createdAt = currentDate;
        notificationModel.subject = subjectRequest.text;
        notificationModel.purpose = purposeRequest.text;
        notificationModel.content = messageRequest.text;
        notificationModel.receiverMobileNumber = '63${receiver.text}';
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );
       Map<String, dynamic> result = await store.accountService.findMobileUser(notificationModel.receiverMobileNumber);
       if(result['status'] == false) {
         //if failed show error.
         OverlayScreen().pop();
         _scaffoldKey.currentState.showSnackBar(
             SnackBar(content: Text(result['reason']), backgroundColor: COLOR_DANGER));
       } else {
         notificationModel.receiverId = result['queryUser'].id;
         await store.requestMoneyService.notify(result, store.user, notificationModel);
         OverlayScreen().pop();
         await Future.delayed(Duration(seconds: 2));
         OverlayScreen().show(
           context,
           identifier: 'success'
         );
       }
      } catch (err) {
        rethrow;
      }
    }
  }

  _navigateToForm () async {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => RequestFormScreen(
          notification: widget?.notification,
          amount: amount.text,
          date: currentDate,
          subjectRequest: subjectRequest,
          messageRequest: messageRequest,
          onChangeSubject: (string) {
            subjectRequest.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
            setState(() {});
          },
          onChangeMessage: (string) {
            messageRequest.value = TextEditingValue(
              text: string,
              selection: TextSelection.collapsed(offset: string.length),
            );
          },
        ))
    );
  }
}