import 'package:flutter/material.dart';
import 'package:quickmart/models/product.dart';
import 'package:quickmart/pages/base_page.dart';
import 'package:quickmart/widgets/widget_product_detail.dart';

class ProductDetail extends TempBasePage {
  ProductDetail({Key? key, this.product}) : super(key: key);

  final Product? product;
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends TempBasePageState<ProductDetail> {
  @override
  Widget tempPageUI() {
    return ProductDetailWidget(
      data: this.widget.product,
    );
  }
}
