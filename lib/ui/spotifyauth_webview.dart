import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyAuthWebView extends StatefulWidget {
  SpotifyAuthWebView({
    Key key,
    this.initalUrl,
    this.redirectUri,
  }) : super(key: key);

  final String initalUrl;
  final String redirectUri;

  @override
  _SpotifyAuthWebViewState createState() => _SpotifyAuthWebViewState();
}

class _SpotifyAuthWebViewState extends State<SpotifyAuthWebView> {

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid)
      WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      javascriptMode: JavascriptMode.unrestricted,
      initialUrl: widget.initalUrl,
      navigationDelegate: (navRequest) {
        if (navRequest.url.startsWith(widget.redirectUri)) {
          Navigator.pop(context, navRequest.url);
          return NavigationDecision.prevent;
        }

        return NavigationDecision.navigate;
      },
    );
  }
}