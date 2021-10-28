import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/models/cart_response_model.dart';
import 'package:quickmart/provider/cart_provider.dart';
import 'package:quickmart/provider/loader_provider.dart';
import 'package:quickmart/utils/custom_stepper.dart';

class CartProduct extends StatelessWidget {
  CartProduct({Key? key, this.data}) : super(key: key);
  CartItem? data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.white),
        child: makeListTitle(context),
      ),
    );
  }

  ListTile makeListTitle(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        leading: Container(
            width: 50.0,
            height: 150.0,
            alignment: Alignment.center,
            child: Image.network(
              data!.thumbnail.toString(),
              height: 150.0,
            )),
        title: Padding(
          padding: EdgeInsets.all(5),
          child: Text(data!.productName.toString()),
        ),
        subtitle: Padding(
          padding: EdgeInsets.all(5.0),
          child: Wrap(
            direction: Axis.vertical,
            children: [
              Text("₹" + data!.productRegularPrice.toString()),
              ElevatedButton(
                child: Text("Remove"),
                onPressed: () {
                  Provider.of<LoaderProvider>(context, listen: false)
                      .setLoadingStatus(true);
                  var cartProvider =
                      Provider.of<CartProvider>(context, listen: false)
                          .removeProduct(data?.productId);
                  Provider.of<LoaderProvider>(context, listen: false)
                      .setLoadingStatus(false);
                },
              )
            ],
          ),
        ),
        trailing: Text(data!.qty!.toString()),
        //TODO: Stepper not woking so removing as of now.

        // trailing: Container(
        //     width: 120.0,
        //     child: CustomStepper(
        //         iconSize: 18,
        //         height: 40,
        //         lowerLimit: 0,
        //         stepValue: 1,
        //         upperLimit: 20,
        //         value: data?.qty,
        //         onChanged: (value) {
        //           Provider.of<CartProvider>(context, listen: false)
        //               .updateQty(data?.productId!.toInt(), data?.qty!.toInt());
        //         })),
      );
}
