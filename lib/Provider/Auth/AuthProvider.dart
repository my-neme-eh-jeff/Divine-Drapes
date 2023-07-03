import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../SharedPref.dart';
import '../../screens/Login.dart';
class AuthProvider extends ChangeNotifier{

  Future<void> UserSignUp({
    required String fName,
    required String lName,
    required String DOB,
    required String email,
    required String number,
    required String password,
    required BuildContext context,
  }) async {
    String? token1;
    try {
      final uri = Uri.parse('https://divine-drapes.onrender.com/auth/signup');
      print('Here');
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": 'application/json',
          },
          body: json.encode(
              {"fName": fName,
            "lName": lName,
            "DOB": DOB,
            "email": email,
            "number": number,
            "password": password
          }));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 ||
          response.statusCode == 202 ||
          response.statusCode == 201) {
        var json = response.body;
        var data = jsonDecode(json);
        print(data);
        token1= data['token'];
        print(token1);
        SharedPreferencesFile().setToken(data['token']);
        // SharedPreferencesFile().setIsAdmin(false);

        Fluttertoast.showToast(
            msg: "Account Created Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // return true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );

      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        //return false;
      }
    } catch (error) {
      print(error);
      //return false;
    }
  }

}