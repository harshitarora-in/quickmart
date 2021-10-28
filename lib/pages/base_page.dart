import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/pages/product_detail.dart';
import 'package:quickmart/pages/product_page.dart';
import 'package:quickmart/provider/loader_provider.dart';
//import 'package:quickmart/pages/product_page.dart';
import 'package:quickmart/utils/progressHUD.dart';

class BasePage extends StatefulWidget {
  const BasePage({Key? key, this.categoryId}) : super(key: key);

  //Object? get categoryId => null;
  // final Product? data;
  final String? categoryId;
  @override
  BasePageState createState() => BasePageState();
}

//TODO: fix base page
class BasePageState<T extends ProductPage> extends State<T> {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: ProgressHUD(
          child: pageUI(),
          inAsyncCall: loaderModel.isApiCallProcess,
          opacity: 0.3,
        ),
      );
    });
  }

  Widget pageUI() {
    return widget;
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      // brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.orange,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
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

class TempBasePage extends StatefulWidget {
  const TempBasePage({Key? key, this.data}) : super(key: key);
  final Product? data;
  @override
  TempBasePageState createState() => TempBasePageState();
}

class TempBasePageState<T extends ProductDetail> extends State<ProductDetail> {
  bool isApiCallProcess = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: ProgressHUD(
        child: tempPageUI(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget tempPageUI() {
    return widget;
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      //brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.orange,
      automaticallyImplyLeading: true,
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
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
