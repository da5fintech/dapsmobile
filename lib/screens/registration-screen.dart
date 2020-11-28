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
        // decoration: BoxDecoration(
        //   color: Colors.deepPurple,
        // ),
        child: Column(
          children: <Widget>[
            Expanded(
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
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 40, right: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Registration Screen"),
                        Row(
                          children: [
                            Text("Registration"),
                            Text("v1.1.1"),
                          ],
                        ),
                        SizedBox(
                          height: 5,
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

  _handleLogin() {}

  _handleRegister() {}

  @override
  void dispose() {
    super.dispose();
  }
}
