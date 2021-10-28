import 'package:flutter/material.dart';
import 'package:quickmart/api_service.dart';
import 'package:quickmart/models/product.dart' as productModel;
import 'package:quickmart/pages/product_detail.dart';
import 'package:quickmart/pages/webview_product_page.dart';

import '../constants.dart';

class WidgetTagProducts extends StatefulWidget {
  const WidgetTagProducts({Key? key, this.labelName, this.tagId})
      : super(key: key);
  final String? labelName;
  final String? tagId;
  @override
  _WidgetTagProductsState createState() => _WidgetTagProductsState();
}

class _WidgetTagProductsState extends State<WidgetTagProducts> {
  APIService? apiService;
  @override
  void initState() {
    apiService = APIService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(12, 12, 14, 20),
      padding: EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 15.0, bottom: 5),
                child: Text(
                  this.widget.labelName.toString(),
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.0, top: 15.0, bottom: 5),
                child: Text(
                  "See all",
                  style: TextStyle(
                      color: kOrange,
                      fontSize: 13.0,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 6),
            child: Divider(color: Colors.grey.shade300, thickness: 1),
          ),
          _productList()
        ],
      ),
    );
  }

  Widget _productList() {
    return FutureBuilder(
      future: apiService?.getProducts(tagName: this.widget.tagId.toString()),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<productModel.Product>> model,
      ) {
        if (model.hasData) {
          return _buildProductList(model.data);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildProductList(List<productModel.Product>? tagProduct) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
          alignment: Alignment.centerLeft,
          height: 145,
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: (tagProduct!.length),
            itemBuilder: (context, index) {
              var data = tagProduct[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WebviewProductPage(
                                productName: data.name,
                              )));
                  // MaterialPageRoute(
                  //     builder: (context) => ProductDetail(
                  //           product: data,
                  //         )));
                },
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      width: 78,
                      height: 78,
                      alignment: Alignment.center,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          data.images![0].url.toString(),
                          height: 70,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75,
                      child: Text(
                        data.name.toString(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 72,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 4.0, right: 6.0),
                            child: Text(
                              data.regularPrice == ""
                                  ? '₹ ${data.price.toString()}'
                                  : '₹ ${data.regularPrice.toString()}',
                              style: TextStyle(
                                decoration: data.salePrice == ""
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
                              data.salePrice == ""
                                  ? ""
                                  : '₹' + data.salePrice.toString(),
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
              );
            },
          )),
    );
  }
}
