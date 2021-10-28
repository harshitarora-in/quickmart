import 'package:flutter/cupertino.dart';
import 'package:quickmart/api_service.dart';
import 'package:quickmart/models/product.dart';

class SortBy {
  String? value;
  String? text;
  String? sortOrder;

  SortBy(this.sortOrder, this.text, this.value);
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class ProductProvider with ChangeNotifier {
  late APIService _apiService;
  late List<Product> _productList;
  late SortBy _sortBy;
  int pageSize = 10;
  List<Product> get allProducts => _productList;
  double get totalRecords => _productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  ProductProvider() {
    resetStreams();
    _sortBy = SortBy("modified", "Latest", "asc");
  }

  void resetStreams() {
    _apiService = APIService();
    _productList = List<Product>.empty(growable: true);
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setLoadingMethod(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
  }

  fetchProducts(
    pageNumber, {
    String? strSearch,
    String? tagName = '',
    String? categoryId,
    String? sortBy,
    //String? sortOrder='asc'
  }) async {
    List<Product> itemModel = await _apiService.getProducts(
      pageNumber: pageNumber,
      pageSize: this.pageSize,
      categoryId: categoryId.toString(),
      //sortBy: this._sortBy.value.toString(),
      //sortOrder: this._sortBy.sortOrder.toString(),
      tagName: tagName.toString(),
    );

    if (itemModel.length > 0) {
      _productList.addAll(itemModel);
    }
    setLoadingState(LoadMoreStatus.STABLE);
    notifyListeners();
  }
}
