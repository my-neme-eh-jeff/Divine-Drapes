import 'dart:convert';
import 'package:divine_drapes/admin_screens/AdminBottomNav.dart';
import 'package:divine_drapes/admin_screens/AdminOrders.dart';
import 'package:divine_drapes/models/login_model.dart' as user;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../SharedPref.dart';
import '../../screens/Login.dart';
import '../../screens/home.dart';

class AuthProvider extends ChangeNotifier {
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

  static const String authTokenKey = 'auth_token';
  user.Login? currentUser;

  Future<bool> login(String email, String password,BuildContext context,) async {
    final url = Uri.parse('https://divine-drapes.onrender.com/auth/applogin');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final token = json.decode(response.body)['token'];
      await saveAuthToken(token);
      print(response.statusCode);
      getAuthToken();
      var json1 = response.body;

      Map<String, dynamic> parsedResponse = json.decode(json1);
      int? adminData = parsedResponse['data']['roles']['Admin'];
      print('Admin data: $adminData');
      if(adminData == 5150)
        {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/admin_bottom_nav', // Replace this with the actual name of the AdminBottomNav route.
                (route) => false, // Remove all the previous routes from the stack.
          );

          Fluttertoast.showToast(
              msg: "Logged in as Admin!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);

        }
      else
        {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/home', // Replace this with the actual name of the AdminBottomNav route.
                (route) => false, // Remove all the previous routes from the stack.
          );
          Fluttertoast.showToast(
              msg: "Logged in as user!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        }

      return true;
    }
    else
    {
      print(response.statusCode);
      return false;
    }
  }

  Future<String> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    if (token != null) {
      print(token);
    }
    print(token ?? 'no_token');
    return token ?? 'no_token';
  }

  Future<void> saveAuthToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(authTokenKey, token);
  }

  Future<void> deleteAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(authTokenKey);
  }

  void Logout({
    required BuildContext context,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    print(token);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse('https://divine-drapes.onrender.com/auth/logout'));
    request.body = '''''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200 || response.statusCode == 204) {
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
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<bool> editUserPassword({
    required String password,
  }) async {
    print('edit user password');
    print(password);
    try {
      final url =
          Uri.parse('https://divine-drapes.onrender.com/user/editUserInfo');

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(authTokenKey);
      print(token);

      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json'
        },
        body: json.encode({'password': password}),
      );

      print(response.statusCode);
      if (response.statusCode == 200 ||
          response.statusCode == 202 ||
          response.statusCode == 201) {
        var json = response.body;
        var data = jsonDecode(json);
        print(data);

        print("password changed succesfully");

        Fluttertoast.showToast(
            msg: "Password Updated",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16.0);
        return true;
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong.",
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