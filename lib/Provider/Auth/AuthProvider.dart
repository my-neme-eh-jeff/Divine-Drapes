import 'dart:convert';
import 'package:divine_drapes/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../SharedPref.dart';
import '../../screens/Login.dart';

class AuthProvider extends ChangeNotifier {
  Future<void> UserSignUp(
      {
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
      final uri =
          Uri.parse('https://divine-drapes.onrender.com/auth/signup');
      print('Here');
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": 'application/json',
          },
          body: json.encode({
            "fName": fName,
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
        token1 = data['token'];
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

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  })
  // async {
  //   try {
  //     var headers = {'Content-Type': 'application/json'};
  //     var request = http.Request('POST',
  //         Uri.parse('https://divine-drapes.onrender.com/auth/applogin'));
  //     request.body = json.encode({"email": email, "password": password});
  //     request.headers.addAll(headers);
  //
  //     http.StreamedResponse response = await request.send();
  //
  //     if (response.statusCode == 200) {
  //       print(await response.stream.bytesToString());
  //       print(response.statusCode);
  //
  //       Fluttertoast.showToast(
  //           msg: "Logged in successfully!",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //       // return true;
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => Home()),
  //       );
  //     } else {
  //       print(response.reasonPhrase);
  //       Fluttertoast.showToast(
  //           msg: "Something went wrong",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.BOTTOM,
  //           timeInSecForIosWeb: 1,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   } catch (error) {
  //     print(error);
  //     //return false;
  //   }
  // }
  async {
    String? token1;
    try {
      final uri =
      Uri.parse('https://divine-drapes.onrender.com/auth/applogin');
      print('Here');
      http.Response response = await http.post(uri,
          headers: {
            "Content-Type": 'application/json',
          },
          body: json.encode({
            "email": email,
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
        token1 = data['token'];
        print(token1);
        SharedPreferencesFile().setToken(data['token']);
        // SharedPreferencesFile().setIsAdmin(false);

        Fluttertoast.showToast(
            msg: "Logged in Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        // return true;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Home(token: token1.toString(),)),
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
  void Logout({
    required String? token,
    required BuildContext context,
  }) async
  {
    print(token);
    var headers = {
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('https://divine-drapes.onrender.com/auth/logout'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode==204)
    {
      print(await response.stream.bytesToString());
      print("Logged out succesfully");
      print(response.statusCode);

      Fluttertoast.showToast(
          msg: "Logged out successfully!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );

    }
    else {
      print(response.reasonPhrase);
    }

  }

}
