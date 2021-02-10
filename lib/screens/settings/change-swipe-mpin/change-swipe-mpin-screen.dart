import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';


final store = getIt<ApplicationStore>();

class ChangeSwipeMpinScreen extends StatefulWidget {
  @override
  _ChangeSwipeMpinScreenState createState() => _ChangeSwipeMpinScreenState();
}

class _ChangeSwipeMpinScreenState extends State<ChangeSwipeMpinScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_CHANGE_MPIN_TEXT,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        size: 45,
                        color: COLOR_DARK_PURPLE,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        SETTINGS_SCREEN_CHANGE_YOUR_PIN,
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: COLOR_DARK_PURPLE,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(SETTINGS_SCREEN_ENTER_NEW_PIN),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: PinCodeTextField(
                          controller: controller,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            print("change ${str}");
                          },
                          appContext: context,
                          length: 6,
                          pinTheme: PinTheme(
                            activeColor: COLOR_DARK_PURPLE,
                            inactiveColor: Colors.black.withOpacity(.30),
                            fieldWidth: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color:
                        controller.text.length != 6 ? Colors.grey[500] : null,
                    onPressed: () {
                      controller.text.length == 6 ? _handleNext() : null;
                    },
                    child: Text(PAYMENT_MPIN_SCREEN_PROCEED_TEXT),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleNext() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ConfirmSwipeMpinScreen(
          prevPin: controller.text,
        ),
      ),
    );
  }
}

class ConfirmSwipeMpinScreen extends StatefulWidget {
  String prevPin;

  ConfirmSwipeMpinScreen({this.prevPin});

  @override
  _ConfirmSwipeMpinScreenState createState() => _ConfirmSwipeMpinScreenState();
}

class _ConfirmSwipeMpinScreenState extends State<ConfirmSwipeMpinScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    OverlayScreen().saveScreens({
      'progress': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'updated-pin': CustomOverlayScreen(
        backgroundColor: Colors.white.withOpacity(.2),
        content: AlertDialog(
          actionsPadding: EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          contentPadding: EdgeInsets.only(top: 30, left: 20, right: 30),
          title: Row(
            children: [
              Icon(Icons.check, color: COLOR_GREEN),
              SizedBox(
                width: 5,
              ),
              Text(
                SETTINGS_SCREEN_MPIN_UPDATED_PIN,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            SETTINGS_SCREEN_MPIN_UPDATED_SUCCESS_PIN,
            style: GoogleFonts.roboto(
              color: Colors.black,
              // fontSize: normalizeSize(15),
            ),
            textAlign: TextAlign.left,
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: FlatButton(
                child: Text(
                  SOON_RELEASED_SCREEN_OK_TEXT,
                  style: GoogleFonts.roboto(color: COLOR_DARK_PURPLE, fontSize: 14),
                ),
                onPressed: () {
                  OverlayScreen().pop();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      )
    });


    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_CONFIRM_PIN_TITLE,
        ),
        body: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.mobile_friendly,
                        size: 45,
                        color: COLOR_DARK_PURPLE,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        SETTINGS_SCREEN_CONFIRM_PIN_BANNER_TITLE,
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: COLOR_DARK_PURPLE,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(SETTINGS_SCREEN_RE_CONFIRM_PIN_BANNER_TITLE),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: PinCodeTextField(
                          controller: controller,
                          obscureText: true,
                          keyboardType: TextInputType.number,
                          onChanged: (str) {
                            print("change ${str}");
                          },
                          appContext: context,
                          length: 6,
                          pinTheme: PinTheme(
                            activeColor: COLOR_DARK_PURPLE,
                            inactiveColor: Colors.black.withOpacity(.30),
                            fieldWidth: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    color: controller.text.length != 6 ? Colors.grey[500] : null,
                    onPressed: () async {
                      if(controller.text.length == 6) {
                        if(controller.text == widget.prevPin) {
                          try {
                            OverlayScreen().show(
                              context,
                              identifier: 'progress',
                            );
                            await Future.delayed(Duration(seconds: 5));
                            OverlayScreen().pop();
                            await store.accountService.updatePin(store.user.id, controller.text);
                            store.user.mpin = controller.text;
                            OverlayScreen().show(
                              context,
                              identifier: 'updated-pin',
                            );
                          } catch (onErr) {
                            OverlayScreen().pop();
                            throw onErr;
                          }
                        } else {
                          print('Not Matched');
                        }
                      }
                      return null;
                    },
                    child: Text(
                      PAYMENT_MPIN_SCREEN_PROCEED_TEXT,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
