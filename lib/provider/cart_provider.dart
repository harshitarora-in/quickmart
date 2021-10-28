import 'package:flutter/material.dart';
import 'package:quickmart/api_service.dart';
import 'package:quickmart/models/cart_request_model.dart';
import 'package:quickmart/models/cart_response_model.dart';

class CartProvider with ChangeNotifier {
  APIService? _apiService;
  List<CartItem>? _cartItems;
  CartItem _testCartItem = CartItem();
  CartProducts _product = CartProducts();
  List<CartItem>? get cartItems => _cartItems;
  double get totalRecords => _cartItems!.length.toDouble();
  double get totalAmount => _cartItems != null
      ? _cartItems!
          .map<double>((e) => e.lineSubtotal!.toDouble())
          .reduce((value, element) => value + element)
      : 0;

  CartProvider() {
    _apiService = APIService();
    _cartItems = List<CartItem>.empty(growable: true);
  }

  void resetStreams() {
    _apiService = APIService();
    _cartItems = List<CartItem>.empty(growable: true);
  }

  void addToCart(CartProducts? product, Function onCAllBack) async {
    CartRequestModel requestModel = CartRequestModel();
    requestModel.products = List<CartProducts>.empty(growable: true);
    //if(_cartItems==null)
    _cartItems!.forEach((element) {
      requestModel.products?.add(
          CartProducts(productId: element.productId, quantity: element.qty));
    });
    var isProductExist = requestModel.products?.firstWhere(
      (prd) => prd.productId == product?.productId,
      //not added orElse statement VIDEO 8 TIME: 18:.00
      orElse: () => _product,
    );

    if (isProductExist != null) {
      requestModel.products?.remove(isProductExist);
    }
    requestModel.products?.add(product!);

    await _apiService!.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel?.data != null) {
        _cartItems = [];
        _cartItems?.addAll(cartResponseModel!.data!.toList());
      }
      onCAllBack(cartResponseModel);
      notifyListeners();
    });
  }

  fetchCartItems() async {
    if (_cartItems == null) {
      resetStreams();
    }
    await _apiService!.getCartItems().then((cartResponseModel) {
      if (cartResponseModel?.data != null) {
        _cartItems!.addAll(cartResponseModel!.data!.toList());
      }
      notifyListeners();
    });
  }

  void updateQty(int? productId, int? qty) {
    var isProductExist = _cartItems?.firstWhere(
      (prd) => prd.productId == productId,
    );
    //TODO: not working qty in stepper is not increasing
    //orElse: () => _testCartItem
    if (isProductExist != null) {
      isProductExist.qty = qty;
    }
    notifyListeners();
  }

  void updateCart(Function onCallBack) async {
    CartRequestModel requestModel = CartRequestModel();
    requestModel.products = List<CartProducts>.empty(growable: true);
    if (_cartItems == null) resetStreams();
    _cartItems!.forEach((element) {
      requestModel.products?.add(CartProducts(
        productId: element.productId,
        quantity: element.qty,
      ));
    });
    await _apiService!.addtoCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel?.data != null) {
        _cartItems = [];
        _cartItems?.addAll(cartResponseModel!.data!.toList());
      }
      onCallBack(cartResponseModel);
      notifyListeners();
    });
  }

  void removeProduct(int? productId) {
    var isProductExist = _cartItems?.firstWhere(
      (prd) => prd.productId == productId,
    );
    //TODO: not working qty in stepper is not increasing
    //orElse: () => _testCartItem
    if (isProductExist != null) {
      _cartItems!.remove(isProductExist);
    }
    notifyListeners();
  }
}
