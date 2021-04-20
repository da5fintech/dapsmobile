import 'package:flutter/material.dart';
import 'package:swipe/common/util.dart';
import 'package:swipe/common/constants.dart';

class AmountMasking extends StatefulWidget {
  TextEditingController controller;
  Function onChanged;
  String type;
  bool hasError;

  AmountMasking({
    @required this.controller,
    @required this.onChanged,
    @required this.type,
    @required this.hasError = false,
  });

  @override
  _AmountMaskingState createState () => _AmountMaskingState();

}

class _AmountMaskingState extends State<AmountMasking> {
  AppUtil _appUtil = AppUtil();

  @override
  Widget build(BuildContext context) {
    return TextField(
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
        labelText: widget.type,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        errorText: widget.hasError ? '${widget.type} is required' : null,
        focusColor: COLOR_DARK_PURPLE,
      ),
    );
  }


}