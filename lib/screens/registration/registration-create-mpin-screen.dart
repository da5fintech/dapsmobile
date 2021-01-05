import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
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
                            decoration: InputDecoration(
                                hintText: "Create your MPIN",
                                suffixIcon: Icon(Icons.visibility_off,
                                    color: Colors.white.withOpacity(.6))),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Verify MPIN",
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
