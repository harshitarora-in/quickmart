import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/pages/base_page.dart';
import 'package:quickmart/pages/cart_page.dart';
import 'package:quickmart/pages/home_page.dart';
import 'package:quickmart/pages/product_page.dart';
import 'package:quickmart/provider/cart_provider.dart';
import 'package:quickmart/provider/loader_provider.dart';
import 'package:quickmart/provider/products_provider.dart';
import 'package:quickmart/widgets/widget_product_detail.dart';

//TODO: App card shows error on each category page when sale price is not entered
//TODO: Flutter doctor 1 issue
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ProductProvider(),
            child: ProductPage(),
          ),
          ChangeNotifierProvider(
            create: (context) => LoaderProvider(),
            child: BasePage(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
            child: ProductDetailWidget(),
          ),
          ChangeNotifierProvider(
            create: (context) => CartProvider(),
            child: CartPage(),
          ),
        ],
        child: MaterialApp(
          title: "Flutter",
          theme: ThemeData(primarySwatch: Colors.orange),
          home: MyHomePage(),
        ));
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //appBar: AppBar(title: Text("Main Page")),
        body: HomePage()

        // Center(
        //   child: Column(
        //     children: [
        //       ElevatedButton(
        //           onPressed: () {
        //             Navigator.push(context, MaterialPageRoute(builder: (context) {
        //               return SignupPage();
        //             }));
        //           },
        //           child: Text("Sign up")),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return LoginPage();
        //       }));
        //     },
        //     child: Text("login")),
        // ElevatedButton(
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context) {
        //         return HomePage();
        //       }));
        //     },
        //     child: Text("Home")),
        // ],
        );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(
//             create: (context) => ProductProvider(),
//             child: ProductPage(),
//           )
//         ],
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(widget.title),
//           ),
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'You have pushed the button this many times:',
//                 ),
//                 Text(
//                   '$_counter',
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return SignupPage();
//                       }));
//                     },
//                     child: Text("Sign up")),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return LoginPage();
//                       }));
//                     },
//                     child: Text("login")),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (context) {
//                         return HomePage();
//                       }));
//                     },
//                     child: Text("home"))
//               ],
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             onPressed: _incrementCounter,
//             tooltip: 'Increment',
//             child: Icon(Icons.add),
//           ), // This trailing comma makes auto-formatting nicer for build methods.
//         ));
//   }
// }

//TODO: main issue is in api file multiple parameter not working properly
