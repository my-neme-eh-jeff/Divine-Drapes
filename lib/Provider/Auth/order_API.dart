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
  List<Received> _allOrdersData =[];

  getOrdersData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySW5mbyI6eyJlbWFpbCI6InNhaGlsa2FtYXRoMDEwOEBnbWFpbC5jb20iLCJyb2xlcyI6WzIwMDEsNTE1MF19LCJpYXQiOjE2OTAzOTU2MDQsImV4cCI6MTcyMTk1MzIwNH0.c7DiBEAGKavFwFa3fhkpddhjjdHxslYzj71pjrsFG3E'
    };
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
    var headers = {
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySW5mbyI6eyJlbWFpbCI6InRoZWRpdmluZWRyYXBlc0BnbWFpbC5jb20iLCJyb2xlcyI6WzIwMDEsNTE1MF19LCJpYXQiOjE2OTEzMDAzODEsImV4cCI6MTcyMjg1Nzk4MX0.OFJXelfcoUyuL8yoJNByVZBlU3qofZPIsiGPL3Hyoa0'
    };
    var request = http.Request('GET',
        Uri.parse('https://divine-drapes.onrender.com/user/singleOrder/'+ id));
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
    var request = http.Request('GET', Uri.parse('https://divine-drapes.onrender.com/admin/allOrders'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      print(response.statusCode);
      print("future orders data: ");
      var data = jsonDecode(streamResponse.body);
      print(data);
     //  var getAllOrders = AllOrders.fromJson(data);
     // _allOrdersData = getAllOrders.received;
      return data['received'];

    }
    else {
      print(response.reasonPhrase);
      print(response.statusCode);
    }

  }
}
