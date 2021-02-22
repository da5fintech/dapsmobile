import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:swipe/common/constants.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class DirectSendFormScreen extends StatefulWidget {
  @override
  _DirectSendFormScreenState createState () =>
      _DirectSendFormScreenState();

}

class _DirectSendFormScreenState extends State<DirectSendFormScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ThemeData td = createThemePurpleOnWhite(context);
    return Theme(
      data: td,
      child: Scaffold(
        appBar: SubAppbarWidget(
          title: DIRECT_SEND_SCREEN_DIRECT_SEND_TEXT,
        ),
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        validator: (text) {
                          if (text.isEmpty) {
                            return '${DIRECT_SEND_FORM_SCREEN_MOBILE} is required';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: COLOR_DANGER, fontSize: 12, height: 1),
                          labelText: DIRECT_SEND_FORM_SCREEN_MOBILE,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          prefix: Container(
                            padding: EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 0.5,
                                ),
                              ),
                            ),
                            child: Text(
                              '+63',
                              style:
                              GoogleFonts.roboto(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        DIRECT_SEND_FORM_NOTE_MOBILE,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          color: COLOR_DARK_GRAY.withOpacity(0.52),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (val) {
                        },
                        onSaved: (v) {
                        },
                        validator: (text) {
                          if(text.isEmpty) {
                            return "${DIRECT_SEND_FORM_SCREEN_AMOUNT} is Required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: COLOR_DANGER, fontSize: 12),
                          labelText: DIRECT_SEND_FORM_SCREEN_AMOUNT,
                          floatingLabelBehavior:
                          FloatingLabelBehavior.always,
                        ),
                      ),
                      TextFormField(
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (val) {
                        },
                        onSaved: (v) {
                        },
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          labelText: DIRECT_SEND_FORM_SCREEN_MESSAGE,
                          floatingLabelBehavior:
                          FloatingLabelBehavior.always,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        DIRECT_SEND_FORM_SCREEN_MESSAGE_OPTIONAL,
                        textAlign: TextAlign.start,
                        style: GoogleFonts.roboto(
                          color: COLOR_DARK_GRAY.withOpacity(0.52),
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  // shape: ,
                  onPressed: () {
                    _handleNext();
                  },
                  child: Text(
                    DIRECT_SEND_FORM_SCREEN_NEXT,
                  ),
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  void _handleNext () {
    bool status = _formKey.currentState.validate();
    if(status) {
      print('proceed');
    }
  }

}