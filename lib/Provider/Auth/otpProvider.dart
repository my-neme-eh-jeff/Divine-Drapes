import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../screens/Login.dart';

class otpProvider extends ChangeNotifier {
  static const String authTokenKey = 'auth_token';


  Future<bool> verifyOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(authTokenKey);

      var headers = {'Authorization': 'Bearer $token'};

      final uri = Uri.parse('https://divine-drapes.onrender.com/auth/verifyOTP');


      print('verify otp');
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": 'application/json',
          },
          body: json.encode({
            "otp": otp,
            "email": email,
          }));

        //response.headers.addAll(headers);

    
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 ||
          response.statusCode == 202 ||
          response.statusCode == 201) {
        var json = response.body;
        var data = jsonDecode(json);
        print(data);
        
        

        Fluttertoast.showToast(
            msg: "OTP verified",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return true;
        
      } else {
        Fluttertoast.showToast(
            msg: "wrong otp entered",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }

  }
}