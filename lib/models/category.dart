class Category {
  int? categoryId;
  String? categoryName;
  String? categoryDesc;
  int? parent;
  Image? image;

  Category({
    this.categoryId,
    this.categoryDesc,
    this.categoryName,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null
        ? Image.fromJson(json['image'])
        : Image(
            url:
                'http://quickmart.harshitarora.in/wp-content/uploads/2021/09/banner1.webp');
  }
}

class Image {
  String? url;
  Image({this.url});
  Image.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
