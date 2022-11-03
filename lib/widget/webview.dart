import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {super.key,
      required this.url,
      required this.statusBarColor,
      required this.title,
      required this.hideAppBar,
      required this.backForbid});

  @override
  _WebViewSate createState() => _WebViewSate();
}

class _WebViewSate extends State<WebView> {
  final webviewReference = new FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChanged;
  late StreamSubscription<WebViewStateChanged> _onStateChanged;
  late StreamSubscription<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.shouldStart:
          break;
        case WebViewState.startLoad:
          break;
        case WebViewState.finishLoad:
          break;
        case WebViewState.abortLoad:
          break;
      }
    });
    _onHttpError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {});
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onHttpError.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: [
          _appBar(
            Color(int.parse('0xff' + statusBarColorStr)),
            backButtonColor,
          ),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                color: Colors.white,
                child: Center(
                  child: Text('Waiting...'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        height: 30,
        color: backgroundColor,
      );
    }
    return Container(
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: [
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColor,
                  size: 26,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  widget.title ?? "",
                  style: TextStyle(color: backButtonColor, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
