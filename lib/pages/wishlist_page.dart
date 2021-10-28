import 'package:flutter/material.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  _WishlistPageState createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  WebViewController? _controller;
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ProgressHUD(
        inAsyncCall: _show,
        child: WebView(
          initialUrl: "https://quickmart.harshitarora.in/wishlist/",
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
