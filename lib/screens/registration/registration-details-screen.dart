import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
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
  var maskFormatter = MaskTextInputFormatter(mask: "##/##/##");
  bool obscureTextPass = true;
  bool obscureTextConPass = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                        children: [
                          TextFormField(
                            onSaved: (v) {
                              values["firstName"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'First Name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(hintText: "First Name"),
                          ),
                          TextFormField(
                            onSaved: (v) {
                              values["lastName"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Last Name is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(hintText: "Last Name"),
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            onSaved: (v) {
                              values["birthdate"] = v;
                            },
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Birth Date is Required';
                                }
                                final components = value.split("/");
                                if (components.length == 3) {
                                  final day = int.tryParse(components[0]);
                                  final month = int.tryParse(components[1]);
                                  final year = int.tryParse(components[2]);
                                  if (day != null && month != null && year != null) {
                                    final date = DateTime(year, month, day);
                                    if (date.year == year && date.month == month && date.day == day) {
                                      return null;
                                    }
                                  }
                                }
                                return "Wrong Date Format";
                              },
                            decoration: InputDecoration(hintText: "MM/DD/YY"),
                            inputFormatters: [maskFormatter],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            onSaved: (v) {
                              values["mobileNumber"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Mobile number is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Mobile Number", hintText: "63"),
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
                                return 'email is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(labelText: "Email"),
                          ),
                          TextFormField(
                            obscureText: obscureTextPass,
                            onSaved: (v) {
                              values["password"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Create Password",
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        obscureTextPass = !obscureTextPass),
                                    icon: obscureTextPass
                                        ? Icon(Icons.visibility_off,
                                            color: Colors.white.withOpacity(.6))
                                        : Icon(Icons.visibility,
                                            color:
                                                Colors.white.withOpacity(.6)))),
                          ),
                          TextFormField(
                            obscureText: obscureTextConPass,
                            onSaved: (v) {
                              values["confirmPassword"] = v;
                            },
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Confirm Password is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                suffixIcon: IconButton(
                                    onPressed: () => setState(() =>
                                        obscureTextConPass =
                                            !obscureTextConPass),
                                    icon: obscureTextConPass
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
