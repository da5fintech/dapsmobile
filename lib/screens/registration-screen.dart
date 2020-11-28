import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/widgets/primary-button.widget.dart';
import 'package:swipe/widgets/secondary-button.widget.dart';

import '../main.dart';

final store = getIt<ApplicationStore>();

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      // backgroundColor: Constants.backgroundColor2,
      body: Container(
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
              child: Align(
                // alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: "First Name"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Last Name"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "MM/DD/YY"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: "Mobile Number", hintText: "63"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email"),
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                              hintText: "Create Password",
                              suffixIcon: Icon(Icons.visibility_off,
                                  color: Colors.white.withOpacity(.6))),
                        ),
                        TextFormField(
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

  _handleRegister() {}

  @override
  void dispose() {
    super.dispose();
  }
}
