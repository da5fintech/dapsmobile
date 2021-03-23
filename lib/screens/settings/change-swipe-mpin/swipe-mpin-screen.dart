import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_screen/overlay_screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:swipe/screens/settings/change-swipe-mpin/change-swipe-mpin-screen.dart';
import 'package:swipe/store/application-store.dart';
import 'package:swipe/main.dart';

final store = getIt<ApplicationStore>();

class SwipeMpinScreen extends StatefulWidget {
  @override
  _SwipeMpinScreenState createState() => _SwipeMpinScreenState();
}

class _SwipeMpinScreenState extends State<SwipeMpinScreen> {
  TextEditingController controller = new TextEditingController();
  bool incorrectPin = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);


    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: SETTINGS_SCREEN_CHANGE_PIN_TITLE,
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
                      Text(PAYMENT_MPIN_SCREEN_GREET,
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: COLOR_DARK_PURPLE,
                              fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(PAYMENT_MPIN_SCREEN_DIGIT_LIMIT),
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
                      if (incorrectPin) ...[
                        Text(
                          SETTINGS_SCREEN_INCORRECT_PIN_TITLE,
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: COLOR_DANGER,
                          ),
                        )
                      ]
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      if (store.user.mpin == controller.text) {
                        setState(() => incorrectPin = false);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChangeSwipeMpinScreen()));
                      } else {
                        setState(() => incorrectPin = true);
                      }
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
