import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/models/user-model.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/common/widgets/primary-button.widget.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

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
  var maskFormatter = MaskTextInputFormatter(mask: "##/##/####");
  bool obscureTextPass = true;
  bool obscureTextConPass = true;
  AppUtil _appUtil = AppUtil();
  FocusNode email;
  FocusNode password;
  FocusNode conPassword;

  @override
  void initState() {
    super.initState();
    email = FocusNode();
    password = FocusNode();
    conPassword = FocusNode();
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
                      Text(
                        APP_NAME,
                        style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 15),
                      ),
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
                            autofocus: true,
                            textInputAction: TextInputAction.next,
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
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
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
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
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
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                          ),
                          TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.next,
                            onSaved: (v) {
                              values["birthdate"] = v;
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Birth Date is Required';
                              }
                              final components = value.split("/");
                              if (components.length == 3) {
                                int month = int.parse(components[0]);
                                int day = int.parse(components[1]);
                                int year = int.parse(components[2]);
                                int dayInMonth =
                                    _appUtil.daysInMonth(month, year);
                                if (day != null &&
                                    month != null &&
                                    year != null) {
                                  if (day > dayInMonth) {
                                    return 'Invalid Date Input';
                                  }
                                  return null;
                                }
                              }
                              return "Wrong Format";
                            },
                            decoration: InputDecoration(
                              hintText: "MM/DD/YYYY",
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
                            ),
                            inputFormatters: [maskFormatter],
                          ),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.phone,
                            onFieldSubmitted: (val) {
                              FocusScope.of(context).requestFocus(email);
                            },
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
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
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
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            focusNode: email,
                            onFieldSubmitted: (val) {
                              email.unfocus();
                              FocusScope.of(context).requestFocus(password);
                            },
                            keyboardType: TextInputType.emailAddress,
                            readOnly: store.registrant != null ? true : false,
                            initialValue: store.registrant != null
                                ? store.registrant.email
                                : "",
                            onSaved: (v) {
                              values["email"] = v;
                            },
                            validator: AppUtil().validateEmail,
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: COLOR_GRAY,
                                    fontSize: 12,
                                    height: 0.3),
                                hintText: "Email"),
                          ),
                          TextFormField(
                            autofocus: true,
                            textInputAction: TextInputAction.next,
                            focusNode: password,
                            onFieldSubmitted: (val) {
                              email.unfocus();
                              FocusScope.of(context).requestFocus(conPassword);
                            },
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
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
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
                            focusNode: conPassword,
                            obscureText: obscureTextConPass,
                            onFieldSubmitted: (val) {
                              conPassword.unfocus();
                              _handleNext();
                            },
                            onSaved: (v) {
                              values["confirmPassword"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Confirm ${REGISTER_SCREEN_PASSWORD_TEXT} is required';
                              } else if (text != values['password']) {
                                return 'Confirmation ${REGISTER_SCREEN_PASSWORD_TEXT} not match with ${REGISTER_SCREEN_PASSWORD_TEXT}';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: COLOR_GRAY, fontSize: 12, height: 0.3),
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
                              text: "Next"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(APP_HELP_CENTER),
                            Text(APP_VERSION),
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
    email.dispose();
    password.dispose();
    conPassword.dispose();
  }

  void _handleNext() async {
    bool status = _formKey.currentState.validate();
    _formKey.currentState.save();
    if (status) {
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
