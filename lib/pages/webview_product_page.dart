import 'package:flutter/material.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';

class WebviewProductPage extends StatefulWidget {
  WebviewProductPage({Key? key, this.productName}) : super(key: key);
  final String? productName;

  @override
  _WebviewProductPageState createState() => _WebviewProductPageState();
}

@override
class _WebviewProductPageState extends State<WebviewProductPage> {
  WebViewController? _controller;
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        child: ProgressHUD(
          inAsyncCall: _show,
          child: WebView(
            initialUrl:
                "https://quickmart.harshitarora.in/product/${this.widget.productName.toString().replaceAll(' ', '-').toLowerCase()}",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finished) {
              setState(() {
                _show = false;
              });
            },
            onWebViewCreated: (WebViewController webViewController) {
              _controller = webViewController;
            },
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      //brightness: Brightness.dark,
      elevation: 0,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: kOrange,
      title: Text("Grocery App", style: TextStyle(color: Colors.white)),
      actions: [
        Icon(Icons.notifications_none, color: Colors.white),
        SizedBox(width: 15),
        Icon(Icons.shopping_basket, color: Colors.white),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
