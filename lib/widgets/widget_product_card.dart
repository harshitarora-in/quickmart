import 'package:flutter/material.dart';
import 'package:quickmart/constants.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/pages/webview_product_page.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({Key? key, this.data}) : super(key: key);
  final Product? data;
  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WebviewProductPage(
                        productName: this.widget.data?.name,
                      )));

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => ProductDetail(
          //               product: this.widget.data,
          //             )));
        },
        child: Container(
          margin: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                  visible: this.widget.data!.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10),
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 3.5, bottom: 3.5),
                      decoration: BoxDecoration(
                          color: kOrange,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Text(
                        this.widget.data!.calculateDiscount().toString() +
                            "% Off",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  )),
              Image.network(
                this.widget.data!.images!.isEmpty
                    ? 'http://quickmart.harshitarora.in/wp-content/uploads/2021/09/No-image-found.jpg'
                    : this.widget.data!.images![0].url.toString(),
                height: 100,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  child: Text(
                this.widget.data!.name.toString(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              )),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0, right: 6.0),
                      child: Text(
                        this.widget.data!.regularPrice == ""
                            ? '₹ ${this.widget.data!.price.toString()}'
                            : '₹ ${this.widget.data!.regularPrice.toString()}',
                        style: TextStyle(
                          decoration: this.widget.data!.salePrice == ""
                              ? TextDecoration.none
                              : TextDecoration.lineThrough,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        this.widget.data!.salePrice == ""
                            ? ""
                            : '₹' + this.widget.data!.salePrice.toString(),
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w400,
                            color: Colors.green),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
