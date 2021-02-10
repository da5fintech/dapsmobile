import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class ChangeSwipeMpinScreen extends StatefulWidget {
  @override
  _ChangeSwipeMpinScreenState createState() => _ChangeSwipeMpinScreenState();
}

class _ChangeSwipeMpinScreenState extends State<ChangeSwipeMpinScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: 'Change MPIN',
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
                        'Change your MPIN',
                        style: GoogleFonts.roboto(
                            fontSize: 16,
                            color: COLOR_DARK_PURPLE,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text('Please enter your new 6-digit MPIN'),
                      Form(
                        key: _formKey,
                        child: Container(
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
                    // shape: ,
                    onPressed: () {},
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
