import 'package:flutter/material.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/size.config.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';

class DirectRequestFormScreen extends StatefulWidget {
  final Function onSave;

  DirectRequestFormScreen({this.onSave});

  @override
  _DirectRequestFormScreenState createState() =>
      _DirectRequestFormScreenState();
}

class _DirectRequestFormScreenState extends State<DirectRequestFormScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nicknameText = TextEditingController();
  TextEditingController amountText = TextEditingController();

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
            title: DIRECT_REQUEST_FORM_SCREEN_TITLE,
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      SizedBox(height: 20),
                      TextFormField(
                        controller: nicknameText,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              color: COLOR_GRAY, fontSize: 12, height: 0.3),
                          labelText: DIRECT_REQUEST_FORM_SCREEN_NICKNAME,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.6))),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.6))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: COLOR_DAPS, width: 2)),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: amountText,
                        autofocus: true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        onFieldSubmitted: (val) {},
                        onSaved: (v) {},
                        validator: (text) {
                          if (text.isEmpty) {
                            return "Amount is Required!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          errorStyle:
                              TextStyle(color: COLOR_DANGER, fontSize: 12),
                          labelText: DIRECT_SEND_FORM_SCREEN_AMOUNT,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.6))),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.grey.withOpacity(.6))),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: COLOR_DAPS, width: 2)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
              Padding(
                padding: EdgeInsets.only(left: 25, right: 25),
                child: SizedBox(
                  width: double.infinity,
                  child: RaisedButton(
                    // shape: ,
                    onPressed: _handleSave,
                    child: Text(
                      DIRECT_REQUEST_FORM_SCREEN_SAVE,
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  void _handleSave() {
    bool status = _formKey.currentState.validate();
    if (status) {
      widget.onSave(nicknameText.text, amountText.text);
      Navigator.pop(context);
    }
  }
}
