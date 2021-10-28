import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:quickmart/config.dart';
import 'package:quickmart/models/cart_response_model.dart';
import 'package:quickmart/models/category.dart';
import 'package:quickmart/models/customermodel.dart';
import 'package:quickmart/models/login_model.dart';
import 'package:quickmart/models/product.dart';

import 'models/cart_request_model.dart';

class APIService {
  Future<bool> createCustomer(CustomerModel? model) async {
    var authToken =
        base64.encode(utf8.encode(Config.key + ":" + Config.secret));
    bool ret = false;
    try {
      var response = await Dio().post(Config.url + Config.customerUrl,
          data: model?.toJson(),
          options: new Options(headers: {
            HttpHeaders.authorizationHeader: 'Basic $authToken',
            HttpHeaders.contentTypeHeader: "application/json"
          }));
      if (response.statusCode == 201) {
        ret = true;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 404) {
        ret = false;
      } else {
        ret = false;
      }
    }
    return ret;
  }

  Future<LoginResponseModel?> loginCustomer(
      String? username, String? password) async {
    LoginResponseModel? model;
    try {
      var response = await Dio().post(Config.tokenUrl,
          data: {
            "username": username,
            "password": password,
          },
          options: Options(headers: {
            HttpHeaders.contentTypeHeader: "application/x-www-form-urlencoded",
          }));
      if (response.statusCode == 200) {
        model = LoginResponseModel.fromJson(response.extra);
      }
    } on DioError catch (e) {
      print(e.message);
    }
    return model;
  }

  Future<List<Category>> getCategories() async {
    List<Category> data = List<Category>.empty(growable: true);

    try {
      String url = Config.url +
          Config.categoriesURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));

      if (response.statusCode == 200) {
        data =
            (response.data as List).map((i) => Category.fromJson(i)).toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  Future<List<Product>> getProducts({
    int pageNumber = 1,
    int pageSize = 100,
    //String strsearch = '',
    //String sortBy = 'price',
    String tagName = '',
    String categoryId = '',
    //String sortOrder = 'asc'
  }) async {
    List<Product> data = List<Product>.empty(growable: true);

    try {
      String parameter = "";
      //parameter += "&order=$sortOrder";
      parameter += "&tag=$tagName";
      parameter += "&page=$pageNumber";
      parameter += "&category=$categoryId";
      print(parameter);

      String url = Config.url +
          Config.productURL +
          "?consumer_key=${Config.key}&consumer_secret=${Config.secret}$parameter";
      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        data = (response.data as List).map((i) => Product.fromJson(i)).toList();
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return data;
  }

  Future<CartResponseModel?> addtoCart(CartRequestModel model) async {
    model.userId = int.parse(Config.userID);

    CartResponseModel? responseModel;
    try {
      var response = await Dio().post(Config.url + Config.addtoCartURL,
          data: model.toJson(),
          options: Options(
              headers: {HttpHeaders.connectionHeader: "application/json"}));

      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e.response!.statusCode);
      } else {
        print(e.message);
        print(e.response);
      }
    }
    return responseModel;
  }

  Future<CartResponseModel?> getCartItems() async {
    CartResponseModel? responseModel;

    try {
      String url = Config.url +
          Config.cartURL +
          "?user_id=${Config.userID}&consumer_key=${Config.key}&consumer_secret=${Config.secret}";

      var response = await Dio().get(url,
          options: Options(
              headers: {HttpHeaders.contentTypeHeader: "application/json"}));
      if (response.statusCode == 200) {
        responseModel = CartResponseModel.fromJson(response.data);
      }
    } on DioError catch (e) {
      print(e.response);
    }
    return responseModel;
  }
}
