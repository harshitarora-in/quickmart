import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/provider/cart_provider.dart';
import 'package:quickmart/provider/loader_provider.dart';
import 'package:quickmart/utils/progressHUD.dart';
import 'package:quickmart/widgets/widget_cart_product.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    var cartItemsList = Provider.of<CartProvider>(context, listen: false);
    cartItemsList.resetStreams();
    cartItemsList.fetchCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoaderProvider>(builder: (context, loaderModel, child) {
      return Scaffold(
          body: ProgressHUD(
        child: _cartItemsList(),
        inAsyncCall: loaderModel.isApiCallProcess,
        opacity: 0.3,
      ));
    });
  }

  Widget _cartItemsList() {
    return Consumer<CartProvider>(builder: (context, cartModel, child) {
      if (cartModel.cartItems != null && cartModel.cartItems!.length > 0) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: cartModel.cartItems!.length,
                  itemBuilder: (context, index) {
                    return CartProduct(data: cartModel.cartItems![index]);
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .setLoadingStatus(true);
                          var cartProvider =
                              Provider.of<CartProvider>(context, listen: false);
                          cartProvider.updateCart((val) {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .setLoadingStatus(false);
                          });
                        },
                        child: Text("Update Cart")),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total"),
                      Text("₹" + cartModel.totalAmount.toString())
                    ],
                  ),
                  ElevatedButton(onPressed: () {}, child: Text("Checkout"))
                ],
              ),
            )
          ],
        );
      }
      //TODO: Recheck here if error occurs
      return Container(
        child: Align(
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        ),
      );
    });
  }
}
