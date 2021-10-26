import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:daps/common/constants.dart';
import 'package:daps/common/widgets/sub-app-bar.widget.dart';
import 'package:daps/store/application-store.dart';
import 'package:daps/main.dart';
import 'package:webview_flutter/webview_flutter.dart';

final store = getIt<ApplicationStore>();

class BpiBankMainScreen extends StatefulWidget {
  String uri;

  BpiBankMainScreen({Key key, @required this.uri}) : super(key: key);

  @override
  _BpiBankMainScreenState createState() => _BpiBankMainScreenState();
}

class _BpiBankMainScreenState extends State<BpiBankMainScreen> {
  WebViewController _controller;
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  StreamSubscription _onDestroy;
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;

  String token;
  String _url;

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.close();

    // Add a listener to on destroy WebView, so you can make came actions.
    _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {
      print("destroy");
    });

    _onStateChanged =
        flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
          print("onStateChanged: ${state.type} ${state.url}");
          var a = Uri.parse(state.url);
          print('query params');
          print(a.queryParameters);

        });

    // Add a listener to on url changed
    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (mounted) {
        setState(() {
          print("URL changed: $url");
          if (url.startsWith(BPI_MAIN_ENDPOINT)) {
            setState(() {
              _url = url;
            });
            store.bpiAccessToken = _url.split('=')[1];
            Navigator.pop(context);
          }
        });
      }
    });

  }

  @override
  void dispose() {
    // Every listener should be canceled, the same should be done with this stream.
    _onDestroy.cancel();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    flutterWebviewPlugin.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: SubAppbarWidget(
      //   title: "BPI Bank",
      // ),
      body: WebviewScaffold(
        appBar: SubAppbarWidget(
          title: "BPI Bank",
        ),
        url: widget.uri,
      ),
      // body: WebView(
      //   onWebViewCreated: (WebViewController webViewController) {
      //     _controllerCompleter.future.then((value) async {
      //       _controller = value;
      //       print(await value.currentUrl());
      //     });
      //     _controllerCompleter.complete(webViewController);
      //   },
      //   initialUrl: widget.uri,
      // ),
    );
  }
}
