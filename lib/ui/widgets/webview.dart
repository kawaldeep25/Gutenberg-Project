import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  WebViewScreen({Key? key, this.url}) : super(key: key);
  final String? url;
  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: widget.url,
    );
  }
}
