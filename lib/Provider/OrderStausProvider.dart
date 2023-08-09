import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderStatusProvider extends ChangeNotifier {

  static const String authTokenKey = 'auth_token';
  Map<String, bool> _placedProducts = {};
  Map<String, bool> get placedProducts => _placedProducts;



  Future<String> placeOrder(String pID,String Custtext,String CustColor) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var jsonData = {
      "pID": pID,
      "isCustPhoto": true,
      "isCustText": true,
      "text": Custtext,
      "isCustColor": false,
      "color":[CustColor],
      "paymentStatus": "pending",
      "paymentType": "cod"
    };

    var request = http.Request('POST', Uri.parse('https://divine-drapes.onrender.com/user/order'));
    request.body = json.encode(jsonData);
    request.headers.addAll(headers);

    // Show circular progress indicator while waiting for the response
    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (BuildContext context) {
    //     return Center(
    //       child: CircularProgressIndicator(
    //         valueColor: AlwaysStoppedAnimation<Color>(cream),
    //       ),
    //     );
    //   },
    // );

    http.StreamedResponse response = await request.send();

   // Navigator.of(context).pop();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      Map<String, dynamic> jsonMap = json.decode(jsonResponse);
      String id = jsonMap['data']['_id']; // Access the _id from the response
      print("Order ID: $id");

      Fluttertoast.showToast(
        msg: "Order Placed Successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      _placedProducts[pID] = true;
      notifyListeners();
      // Save the 'placed' status in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setBool(pID, true);
      return id;
    } else
    {
      print(response.reasonPhrase);

      Fluttertoast.showToast(
        msg: "Failed to place the order",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return response.reasonPhrase.toString();
    }
  }

  Future<void> checkOrderStatus(String pID) async {
    final prefs = await SharedPreferences.getInstance();
    final placedStatus = prefs.getBool(pID) ?? false;
    _placedProducts[pID] = placedStatus;
    notifyListeners();
  }
}
