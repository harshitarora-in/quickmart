class Product {
  int? id;
  String? name;
  String? description;
  String? shortDescription;
  String? sku;
  String? price;
  String? regularPrice;
  String? salePrice;
  String? stockstatus;
  String? weight;
  List<Images>? images;
  List<Categories>? categories;
  //List<Attributes>? attributes;
  Product({
    this.id,
    this.name,
    this.categories,
    this.description,
    this.images,
    this.price,
    this.regularPrice,
    this.salePrice,
    this.shortDescription,
    this.sku,
    this.weight,
    this.stockstatus,
    //this.attributes
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    shortDescription = json['short-description'];
    sku = json['sku'];
    price = json['price'];
    regularPrice = json['regular_price'];
    salePrice = json['sale_price'];
    stockstatus = json['stock_status'];
    weight = json['weight'];

    if (json['images'] != null) {
      images = List<Images>.empty(growable: true);
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = List<Categories>.empty(growable: true);
      json['categories'].forEach((v) {
        categories?.add(Categories.fromJson(v));
      });
    }

    // if (json['attributes'] != null) {
    //   attributes = List<Attributes>.empty(growable: true);
    //   json['attributes'].forEach((v) {
    //     attributes?.add(Attributes.fromJson(v));
    //   });
    // }
  }

  calculateDiscount() {
    var price = double.parse(this.regularPrice == ""
        ? this.price.toString()
        : this.regularPrice.toString());
    var sellingPrice = double.parse(this.salePrice.toString());
    var discount = (((price - sellingPrice) / price) * 100);
    return discount.round();
  }
}

class Categories {
  int? id;
  String? name;

  Categories({this.id, this.name});
  Categories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}

class Images {
  String? url;

  Images(
      {this.url =
          'http://quickmart.harshitarora.in/wp-content/uploads/2021/09/No-image-found.jpg'});
  Images.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}

// class Attributes {
//   int? id;
//   String? name;
//   List<String>? options;

//   Attributes({this.id, this.name, this.options});
//   Attributes.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     options = json['options'].cast<String>();
//   }
// }
