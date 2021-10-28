import 'package:flutter/material.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MyAccountPage extends StatefulWidget {
  const MyAccountPage({Key? key}) : super(key: key);

  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<MyAccountPage> {
  WebViewController? _controller;
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProgressHUD(
        inAsyncCall: _show,
        child: WebView(
          initialUrl: "https://quickmart.harshitarora.in/my-account/",
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
