import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/constants.dart';
import 'package:quickmart/models/cart_request_model.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/provider/cart_provider.dart';
import 'package:quickmart/provider/loader_provider.dart';
import 'package:quickmart/utils/custom_stepper.dart';
import 'package:quickmart/utils/expand_text.dart';

class ProductDetailWidget extends StatelessWidget {
  //const removed from constructor
  ProductDetailWidget({Key? key, this.data}) : super(key: key);
  final Product? data;
  //int qty = 0;
  CartProducts cartProducts = CartProducts();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            bannerCarousel(context, data),
            productDetails(context, data)
          ],
        ),
      ),
    );
  }

  Widget returnweight(String? data) {
    if (data == null || data.isEmpty) {
      return Text("");
    }
    int weight = int.parse(data);
    if (weight > 1000) {
      return Text(
        (weight / 1000).toString() + " kg",
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      );
    } else {
      return Text(data + " gm",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400));
    }
  }

  Widget bannerCarousel(BuildContext context, Product? data) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(top: 10.0),
        height: 250.0,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              data!.images![index].url.toString(),
              //fit: BoxFit.fill,
            );
          },
          control: data!.images!.length > 1
              ? SwiperControl(color: kOrange)
              : SwiperControl(color: Colors.white),
          itemCount: data.images!.length,
          autoplay: data.images!.length > 1 ? true : false,
          autoplayDelay: 6000,
          pagination: data.images!.length > 1
              ? SwiperPagination(
                  margin: EdgeInsets.only(top: 15.0),
                  builder: SwiperPagination(
                      margin: EdgeInsets.only(top: 15.0),
                      builder: DotSwiperPaginationBuilder(
                          size: 5.0,
                          activeSize: 9.0,
                          space: 4.0,
                          color: kOrange,
                          activeColor: kOrange)))
              : SwiperPagination(
                  margin: EdgeInsets.only(top: 15.0),
                  builder: DotSwiperPaginationBuilder(
                      size: 5.0,
                      activeSize: 9.0,
                      space: 4.0,
                      color: Colors.transparent,
                      activeColor: Colors.transparent)),
          viewportFraction: 0.8,
          scale: 0.8,
        ));
  }

  Widget productDetails(BuildContext context, Product? data) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: BoxDecoration(
                color: kOrange,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12))),
            child: Visibility(
              visible: data!.calculateDiscount() > 0,
              child: Text(
                data.calculateDiscount().toString() + "% OFF",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
              child: Text(data.name.toString(),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(15, 0, 25, 5),
          child: Row(
            mainAxisAlignment: data.weight!.isEmpty
                ? MainAxisAlignment.start
                : MainAxisAlignment.spaceBetween,
            children: [
              returnweight(data.weight),
              Text(
                "₹ " + data.price.toString(),
                style: TextStyle(fontSize: 28),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.only(left: 7.5, top: 10, right: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomStepper(
                  iconSize: 20,
                  lowerLimit: 0,
                  stepValue: 1,
                  upperLimit: 20,
                  value: 0,
                  height: 36,
                  onChanged: (value) {
                    print(value);
                    cartProducts.quantity = value;
                  }),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(width: 160, height: 45),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(kOrange),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                  ),
                  onPressed: () {
                    Provider.of<LoaderProvider>(context, listen: false)
                        .setLoadingStatus(true);
                    var cartProvider =
                        Provider.of<CartProvider>(context, listen: false);
                    cartProducts.productId = data.id;
                    cartProvider.addToCart(cartProducts, (val) {
                      Provider.of<LoaderProvider>(context, listen: false)
                          .setLoadingStatus(false);
                    });
                  },
                  child: Text(
                    "Add to Cart",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 5.0),
        ExpandText(
            labelHeader: "Product Details",
            desc: data.description,
            shortDesc: data.description),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}
