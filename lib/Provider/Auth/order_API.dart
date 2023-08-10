import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/SharedPref.dart';
import 'package:divine_drapes/models/AllOrders.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/OrderModel.dart';

class Order {
  static const String authTokenKey = 'auth_token';
  List<Data> _ordersData = [];
  List<Received> _allOrdersData = [];

  getOrdersData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/user/viewOrder'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      var getOrders = OrderModel.fromJson(data);

      _ordersData = getOrders.data;
      return _ordersData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }

  getSingleOrderData(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request('GET',
        Uri.parse('https://divine-drapes.onrender.com/user/singleOrder/' + id));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      // var getOrders = OrderModel.fromJson(data);
      log("single order");
      // _ordersData = getOrders.data;
      return data['data'];
    } else {
      // print(token);
      print(response.statusCode);
    }
  }

  getAllOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/admin/allOrders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("future orders data: ");
      var data = jsonDecode(streamResponse.body);
      // print(data);

      return data['received'];
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);

      return false;
    }
  }

  getPastOrders() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/admin/allOrders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("future orders data: ");
      var data = jsonDecode(streamResponse.body);
      List<Map<String, dynamic>> completedOrders =
          List<Map<String, dynamic>>.from(
        data['received'].where((item) => item['paymentStatus'] == 'completed'),
      );

      return completedOrders;
    } else {
      print(response.reasonPhrase);
      print(response.statusCode);

      return false;
    }
  }
}
