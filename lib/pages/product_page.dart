import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickmart/models/product.dart' as productModel;
import 'package:quickmart/pages/base_page.dart';
import 'package:quickmart/provider/products_provider.dart';
import 'package:quickmart/widgets/widget_product_card.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key, this.categoryId}) : super(key: key);
  final String? categoryId;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  int _page = 1;

  // final _sortByOptions = [
  //   SortBy("popularity", "popularity", "acs"),
  //   SortBy("modified", "Latest", "acs"),
  //   SortBy("price", "Price: High to Low", "desc"),
  //   SortBy("price", "Price: Low to High", "acs"),
  // ];
  @override
  void initState() {
    print("product page");
    print(this.widget.categoryId);
    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    //productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.setLoadingMethod(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page, categoryId: this.widget.categoryId);
    super.initState();
  }

  @override
  Widget pageUI() {
    return _productList();
  }

  Widget _productList() {
    return new Consumer<ProductProvider>(
      builder: (context, productModel, child) {
        if ((productModel.allProducts.length > 0) &&
            (productModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL)) {
          return _buildProductList(productModel.allProducts);
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildProductList(List<productModel.Product>? product) {
    return Column(
      children: [
        //_productFilter(),
        Flexible(
          child: Container(
              padding: EdgeInsets.only(top: 10),
              height: MediaQuery.of(context).size.height,
              color: Colors.grey.shade100,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: (1 / 1.3), //height & width for the GridTile
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: product!.map((productModel.Product product) {
                  return Center(
                    child: Container(
                      child: ProductCard(
                        data: product,
                      ),
                    ),
                  );
                }).toList(),
              )),
        )
      ],
    );
  }

//TODO: search bar and product filter
  // Widget _productFilter() {
  //   return Container(
  //     height: 51,
  //     margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
  //     child: Row(
  //       children: [
  //         Flexible(
  //             child: TextField(
  //           decoration: InputDecoration(
  //               prefixIcon: Icon(Icons.search),
  //               hintText: "Search",
  //               border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(15.0),
  //                   borderSide: BorderSide.none),
  //               fillColor: Color(0xffe6e6ec),
  //               filled: true),
  //         )),
  //         SizedBox(
  //           width: 15,
  //         ),
  //         Container(
  //           decoration: BoxDecoration(
  //               color: Color(0xffe6e6ec),
  //               borderRadius: BorderRadius.circular(9.0)),
  //           child: PopupMenuButton(
  //             onSelected: (sortBy) {},
  //             itemBuilder: (BuildContext context) {
  //               return _sortByOptions.map((item) {
  //                 return PopupMenuItem(
  //                     value: item, child: Text(item.text.toString()));
  //               }).toList();
  //             },
  //             icon: Icon(Icons.tune),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }
}
