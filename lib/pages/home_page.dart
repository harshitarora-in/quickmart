import 'package:flutter/material.dart';
import 'package:quickmart/constants.dart';
import 'package:quickmart/pages/dashboard_page.dart';
import 'package:quickmart/pages/my_account_page.dart';
import 'package:quickmart/pages/webview_cartpage.dart';
import 'package:quickmart/pages/wishlist_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> _widgetList = [
    DashboardPage(),
    WebviewCart(),
    WishlistPage(),
    MyAccountPage(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined), label: 'My Account')
        ],
        selectedItemColor: kOrange,
        unselectedItemColor: Colors.black,
        type: BottomNavigationBarType.shifting,
        currentIndex: _index,
        onTap: (index) {
          setState(() {
            _index = index;
          });
        },
      ),
      body: _widgetList[_index],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      //brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: kOrange,
      automaticallyImplyLeading: false,
      title: Text("Grocery App", style: TextStyle(color: Colors.white)),
      actions: [
        Icon(Icons.notifications_none, color: Colors.white),
        //SizedBox(width: 15),
        // Icon(Icons.shopping_basket, color: Colors.white),
        SizedBox(
          width: 20,
        )
      ],
    );
  }
}
