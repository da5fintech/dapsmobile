import 'package:flutter/material.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/constants.dart';

class AmountMasking extends StatefulWidget {
  TextEditingController controller;
  Function onChanged;
  String type;
  bool hasError;
  bool noUnderline;
  bool readOnly;

  AmountMasking({
    @required this.controller,
    @required this.onChanged,
    @required this.type,
    @required this.hasError = false,
    this.noUnderline = false,
    this.readOnly = false,
  });

  @override
  _AmountMaskingState createState () => _AmountMaskingState();

}

class _AmountMaskingState extends State<AmountMasking> {
  AppUtil _appUtil = AppUtil();

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      textInputAction: TextInputAction.next,
      textAlign: TextAlign.start,
      keyboardType: TextInputType.numberWithOptions(),
      controller: widget.controller,
      onChanged: (string) {
        widget.onChanged(string);
        string = '${_appUtil.formatNumber(string.replaceAll(',', ''))}';
        widget.controller.value = TextEditingValue(
          text: string,
          selection: TextSelection.collapsed(offset: string.length),
        );
      },
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.withOpacity(.6))),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 2)),
        // border: widget.noUnderline ? InputBorder.none : null,
        // focusedBorder: widget.noUnderline ? InputBorder.none : null,
        // enabledBorder: widget.noUnderline ? InputBorder.none : null,
        // errorBorder: widget.noUnderline ? InputBorder.none : null,
        // disabledBorder: widget.noUnderline ? InputBorder.none : null,
        labelText: widget.type,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: widget.hasError ? '${widget.type} is required' : null,
        focusColor: COLOR_DARK_PURPLE,
      ),
    );
  }


}