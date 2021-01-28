import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/screens/registration/registration-success-dialog.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class RegistrationCreateMpinScreen extends StatefulWidget {
  @override
  _RegistrationCreateMpinScreenState createState() =>
      _RegistrationCreateMpinScreenState();
}

class _RegistrationCreateMpinScreenState
    extends State<RegistrationCreateMpinScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> values = Map<String, dynamic>();
  TextEditingController mpin = TextEditingController();
  TextEditingController confirmMpin = TextEditingController();
  bool obscurePin = true;
  bool obscureVerifyPin = true;

  @override
  void initState() {
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
              valueColor: new AlwaysStoppedAnimation<Color>(COLOR_ORANGE),
            ),
            SizedBox(height: 10.0),
            Text("Processing...",
                style: GoogleFonts.roboto(color: Colors.white)),
          ],
        ),
      ),
      'registration-success': CustomOverlayScreen(
          backgroundColor: Colors.white.withOpacity(.2),
          content: RegistrationSuccessDialog(
            onOk: () {
              _handleOk();
            },
          )),
    });

    return Scaffold(
      // backgroundColor: Constants.backgroundColor2,
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Container(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('SWIPE',
                            style: GoogleFonts.roboto(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 15)),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Align(
                  // alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "Set you Mobile Pin",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.roboto(
                                  fontSize: 20, fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            child: Text(
                              "MPIN is a 6 digit security codes used to authenticate"
                              "\nlogin request and transactions."
                              "\n\nNote: Please avoid using weak MPINs like your"
                              "\nBirthdate, 123456, 888888.",
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                                height: 1.5,
                                color: Colors.white.withOpacity(.87),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            obscureText: obscurePin,
                            controller: mpin,
                            onSaved: (v) {
                              values["mpin"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'MPIN is required';
                              }

                              if (text.length != 6) {
                                return 'MPIN must be 6 digits';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Create your MPIN",
                                counterStyle: GoogleFonts.roboto(color: Colors.white),
                                suffixIcon: Icon(Icons.visibility_off,
                                    color: Colors.white.withOpacity(.6))),
                          ),
                          TextFormField(
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            obscureText: obscureVerifyPin,
                            controller: confirmMpin,
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Confirm MPIN is required';
                              }

                              if (mpin.text != confirmMpin.text) {
                                return "MPINs must match";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Verify MPIN",
                                counterStyle: GoogleFonts.roboto(color: Colors.white),
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() => obscureVerifyPin = !obscureVerifyPin),
                                    icon: obscureVerifyPin
                                        ? Icon(
                                            Icons.visibility_off,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          )
                                        : Icon(
                                            Icons.visibility,
                                            color:
                                                Colors.white.withOpacity(0.6),
                                          ))),
                          )
                        ],
                      )),
                ),
              ),
            ),
            Container(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40, bottom: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            width: double.infinity,
                            child: PrimaryButtonWidget(
                                onPressed: () {
                                  _handleRegister();
                                },
                                text: "Next")),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Help Center"),
                            Text("v1.1.1"),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handleRegister() async {
    bool status = _formKey.currentState.validate();
    if (status) {
      try {
        _formKey.currentState.save();
        store.registrant.mpin = values["mpin"];
        OverlayScreen().show(
          context,
          identifier: 'progress',
        );
        await Future.delayed(Duration(seconds: 5));
        OverlayScreen().pop();

        if (store.registrant.isNew) {
          User creds = await store.authService.createAuth(
              email: store.registrant.email,
              password: store.registrant.password);
          store.registrant.id = creds.uid;
        }

        await store.accountService.create(store.registrant);
        store.setUser(store.registrant);
        OverlayScreen().show(
          context,
          identifier: 'registration-success',
        );
      } catch (e) {}
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleOk() {
    OverlayScreen().pop();
    Get.toNamed("/login/login-mpin-screen");
  }
}
