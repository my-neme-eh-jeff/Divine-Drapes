import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/SharedPref.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ProductModel.dart' as multiple;

class Products {
  List<multiple.Data> _productsData = [];
  var product;
  static const String authTokenKey = 'auth_token';

  getProductsData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://divine-drapes.onrender.com/product/allProducts'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      //print(token);
      // print(data);
      var getProducts = multiple.AllProducts.fromJson(data);

      _productsData = getProducts.data;
      return _productsData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }

  getProductsDataCategorywise(String Category) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse('https://divine-drapes.onrender.com/product/categoryWise/' +
            Category));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);

      var getProducts = multiple.AllProducts.fromJson(data);
      _productsData = getProducts.data;
      return _productsData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }

  getSpecificProduct(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse('https://divine-drapes.onrender.com/product/viewProduct/' +
            id));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      log("view product");
      return data['data'];
    } else {
      print(token);
      print(response.statusCode);
    }
  }

  getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/user/viewMyCart'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      log("get card data");
      print(token);
      var data = jsonDecode(streamResponse.body);
      //print(token);
      // print(data);
      var getProducts = multiple.AllProducts.fromJson(data);
      _productsData = getProducts.data;
      return _productsData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }


}




