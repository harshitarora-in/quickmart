class CartResponseModel {
  bool? status;
  List<CartItem>? data;

  CartResponseModel({this.data, this.status});

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = List<CartItem>.empty(growable: true);
      json['data'].forEach((v) {
        data!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => toJson()).toList();
    }
    return data;
  }
}

class CartItem {
  int? productId;
  String? productName;
  String? productRegularPrice;
  String? productSalePrice;
  String? thumbnail;
  int? qty;
  double? lineSubtotal;
  double? lineTotal;

  CartItem(
      {this.lineSubtotal,
      this.lineTotal,
      this.productId,
      this.productName,
      this.productRegularPrice,
      this.productSalePrice,
      this.qty,
      this.thumbnail});

  CartItem.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productName = json['product_name'];
    productRegularPrice = json['product_regular_price'];
    productSalePrice = json['productSalePrice'];
    thumbnail = json['thumbnail'];
    qty = json['qty'];
    lineSubtotal = double.parse(json['line_subtotal'].toString());
    lineTotal = double.parse(json['line_total'].toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['product_regular_price'] = this.productRegularPrice;
    data['product_sale_price'] = this.productSalePrice;
    data['thumbnail'] = this.thumbnail;
    data['qty'] = this.qty;
    data['line_subtotal'] = this.lineSubtotal;
    data['line_total'] = this.lineTotal;
    return data;
  }
}
