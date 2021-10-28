import 'package:flutter/material.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';

class WebviewCart extends StatefulWidget {
  const WebviewCart({Key? key}) : super(key: key);

  @override
  _WebviewCartState createState() => _WebviewCartState();
}

class _WebviewCartState extends State<WebviewCart> {
  WebViewController? _controller;
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProgressHUD(
        inAsyncCall: _show,
        child: WebView(
          initialUrl: "https://quickmart.harshitarora.in/cart/",
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
          onPageFinished: (finished) {
            setState(() {
              _show = false;
            });
          },
        ),
      ),
    );
  }
}
