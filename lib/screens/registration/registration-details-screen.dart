import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';

import '../../main.dart';

final store = getIt<ApplicationStore>();

class RegistrationDetailsScreen extends StatefulWidget {
  @override
  _RegistrationDetailsScreenState createState() =>
      _RegistrationDetailsScreenState();
}

class _RegistrationDetailsScreenState extends State<RegistrationDetailsScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> values = Map<String, dynamic>();
  bool obscureTextPass = true;
  bool obscureTextConPass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double scrollHeight = MediaQuery.of(context).size.height * 0.75;

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
                  ),
                ),
              ),
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return;
                },
                child: SingleChildScrollView(
                  child: Align(
                    // alignment: Alignment.topLeft,
                    child: Container(
                      height: scrollHeight,
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFormField(
                            onSaved: (v) {
                              values["firstName"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_FIRSTNAME_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: REGISTER_SCREEN_FIRSTNAME_TEXT,
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            onSaved: (v) {
                              values["lastName"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_LASTNAME_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: REGISTER_SCREEN_LASTNAME_TEXT,
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            onSaved: (v) {
                              values["address"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_ADDRESS_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: REGISTER_SCREEN_ADDRESS_TEXT,
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (v) {
                              values["birthdate"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_BIRTHDAY_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: REGISTER_SCREEN_BIRTHDAY_TEXT,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              hintText: REGISTER_SCREEN_BIRTHDAY_FORMAT,
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onSaved: (v) {
                              values["mobileNumber"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_MOBIILE_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                              labelText: REGISTER_SCREEN_MOBIILE_TEXT,
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
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            readOnly: store.registrant != null ? true : false,
                            initialValue: store.registrant != null
                                ? store.registrant.email
                                : "",
                            onSaved: (v) {
                              values["email"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_EMAIL_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                errorStyle:
                                    TextStyle(fontSize: 12, height: 0.3),
                                hintText: "Email"),
                          ),
                          TextFormField(
                            obscureText: obscureTextPass,
                            onSaved: (v) {
                              values["password"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return '${REGISTER_SCREEN_PASSWORD_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                              hintText:
                                  "Create ${REGISTER_SCREEN_PASSWORD_TEXT}",
                              suffixIcon: IconButton(
                                onPressed: () => setState(
                                    () => obscureTextPass = !obscureTextPass),
                                icon: obscureTextPass
                                    ? Icon(Icons.visibility_off,
                                        color: Colors.white.withOpacity(.6))
                                    : Icon(Icons.visibility,
                                        color: Colors.white.withOpacity(.6)),
                              ),
                            ),
                          ),
                          TextFormField(
                            obscureText: obscureTextConPass,
                            onSaved: (v) {
                              values["confirmPassword"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Confirm ${REGISTER_SCREEN_PASSWORD_TEXT} is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(fontSize: 12, height: 0.3),
                              hintText:
                                  "Confirm ${REGISTER_SCREEN_PASSWORD_TEXT}",
                              suffixIcon: IconButton(
                                onPressed: () => setState(() =>
                                    obscureTextConPass = !obscureTextConPass),
                                icon: obscureTextConPass
                                    ? Icon(
                                        Icons.visibility_off,
                                        color: Colors.white.withOpacity(0.6),
                                      )
                                    : Icon(
                                        Icons.visibility,
                                        color: Colors.white.withOpacity(0.6),
                                      ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
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
                                  _handleNext();
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

  @override
  void dispose() {
    super.dispose();
  }

  void _handleNext() async {
    bool status = _formKey.currentState.validate();
    if (status) {
      _formKey.currentState.save();

      if (store.registrant == null) {
        store.registrant = UserModel(
            isNew: true,
            email: values["email"],
            displayName: "${values["firstName"]} ${values["lastName"]}");
      }

      store.registrant.firstName = values["firstName"];
      store.registrant.lastName = values["lastName"];
      store.registrant.birthdate = values["birthdate"];
      store.registrant.mobileNumber = values["mobileNumber"];
      store.registrant.password = values["password"];
      Get.toNamed("/registration/registration-create-mpin-screen");
    }
  }
}
