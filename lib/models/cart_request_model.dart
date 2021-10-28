class CartRequestModel {
  int? userId;
  List<CartProducts>? products;
  CartRequestModel({this.userId, this.products});

  CartRequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    if (json['products'] != null) {
      products = List<CartProducts>.empty(growable: true);
      json['products'].forEach((v) {
        products!.add(CartProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.tojson()).toList();
    }
    return data;
  }
}

class CartProducts {
  int? productId;
  int? quantity;

  CartProducts({this.productId, this.quantity});

  CartProducts.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> tojson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
