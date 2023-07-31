import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/SharedPref.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ProductModel.dart';

class Products {
  List<Data> _productsData = [];
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
      var getProducts = AllProducts.fromJson(data);
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
      
      var getProducts = AllProducts.fromJson(data);
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
    var request = http.Request('Get',
        Uri.parse('https://divine-drapes.onrender.com/product/viewProduct'));
    request.body = await json.encode({"productID": id});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    print(id);
    print(jsonDecode(streamResponse.body));

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      print(response.statusCode);
      //print(token);
      log("get specific product api");
      print(data);
      log(response.statusCode.toString());
      var getProducts = AllProducts.fromJson(data);
      product = getProducts.data;
      return product;
    } else {
      print(response.statusCode);
    }
  }

  getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySW5mbyI6eyJlbWFpbCI6ImRkdXNlckBnbWFpbC5jb20iLCJyb2xlcyI6WzIwMDFdfSwiaWF0IjoxNjkwODEwMTA4LCJleHAiOjE3MjIzNjc3MDh9.iFZJAkjbJgv644RuH1yet10ubDMRKEWkSKIR5YZMC9k'};
    var request = http.Request('GET',
        Uri.parse('https://divine-drapes.onrender.com/user/viewMyCart'));
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
      var getProducts = AllProducts.fromJson(data);
      _productsData = getProducts.data;
      return _productsData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }
}
