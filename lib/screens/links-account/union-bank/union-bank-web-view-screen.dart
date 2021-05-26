import 'dart:async';

import 'package:flutter/material.dart';
import 'package:swipe/common/widgets/sub-app-bar.widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UnionBankWebView extends StatefulWidget {
  final String uri;

  UnionBankWebView({@required this.uri});

  @override
  _UnionBankWebViewState createState () =>
      _UnionBankWebViewState();

}

class _UnionBankWebViewState extends State<UnionBankWebView> {
  WebViewController _controller;

  final Completer<WebViewController> _controllerCompleter =
  Completer<WebViewController>();
  //Make sure this function return Future<bool> otherwise you will get an error
  Future<bool> _onWillPop(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SubAppbarWidget(
        title: "Union Bank",
      ),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _controllerCompleter.future.then((value) => _controller = value);
          _controllerCompleter.complete(webViewController);
        },
        initialUrl: widget.uri,
      ),
    );
  }
}