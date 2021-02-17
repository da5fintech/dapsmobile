import 'package:flutter/material.dart';
import 'package:swipe/common/size.config.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';

class DirectSendViaQrScreen extends StatefulWidget {
  @override
  _DirectSendViaQrScreen createState () =>
      _DirectSendViaQrScreen();
}

class _DirectSendViaQrScreen extends State<DirectSendViaQrScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: SubAppbarWidget(
        title: 'Send Via Qr',
      ),
    );
  }
}