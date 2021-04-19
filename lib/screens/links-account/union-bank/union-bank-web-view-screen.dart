import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UnionBankWebView extends StatefulWidget {
  final String uri;

  UnionBankWebView({@required this.uri});

  @override
  _UnionBankWebViewState createState () =>
      _UnionBankWebViewState();

}

class _UnionBankWebViewState extends State<UnionBankWebView> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.uri,
    );
  }
}