import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                            validator: (text) {
                              if (text == null || text.isEmpty) {
                                return 'Birthdate is required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(hintText: "MM/DD/YY"),
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
                                suffixIcon: Icon(Icons.visibility_off,
                                    color: Colors.white.withOpacity(.6))),
                          ),
                          TextFormField(
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
                                suffixIcon: Icon(
                                  Icons.visibility_off,
                                  color: Colors.white.withOpacity(0.6),
                                )),
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
