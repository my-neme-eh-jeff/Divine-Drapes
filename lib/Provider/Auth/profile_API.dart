import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/screens/YourAddress.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ProfileModel.dart';

class Profiles {
  Data? _profileData;
  static const String authTokenKey = 'auth_token';
  AddressList? _address;

  editProfileData(String? fname, String? lname, String? number, String? dob,
      String? password) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT',
        Uri.parse('https://divine-drapes.onrender.com/user/editUserInfo'));
    request.body = json.encode({
      "fName": "$fname",
      "lName": "$lname",
      "number": "$number",
      "DOB": "$dob",
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.statusCode);
    }
  }

  manageAddress(String? addressOf, String? houseNo, String? bldg,
      String? street, String? city, String? state, String? country) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('PUT',
        Uri.parse('https://divine-drapes.onrender.com/user/editUserInfo'));
    request.body = json.encode({
      "addressList": {
        "addressOf": "$addressOf",
        "houseNumber": "$houseNo",
        "building": "$bldg",
        "street": "$street",
        "city": "$city",
        "state": "$state",
        "country": "$country"
      }
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.statusCode);
    }
  }

  getProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/user/profile'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      // print(response.statusCode);
      // print(token);
      // print(data);
      // log(response.statusCode.toString());
      var getProfile = User.fromJson(data);
      _profileData = getProfile.data;
      return _profileData;
    } else {
      // print(token);
      // print(response.statusCode);
    }
  }

  // getAddressData() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(authTokenKey);
  //   var headers = {'Authorization': 'Bearer $token'};
  //   var request = http.Request(
  //       'GET', Uri.parse('https://divine-drapes.onrender.com/user/profile'));
  //   request.body = '''''';
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   http.Response streamResponse = await http.Response.fromStream(response);

  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(streamResponse.body);
  //     print(response.statusCode);
  //     log('BHAI');

  //     var addressData = data["data"]["addressList"];

  //     var getAddress = AddressList.fromJson(addressData);
  //     _address = getAddress;
  //     return _address;
  //   } else {
  //     print(token);
  //     print(response.statusCode);
  //     // Return an appropriate value or handle the error case
  //   }
  // }

  getAddressData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('https://divine-drapes.onrender.com/user/profile'));
    request.body = '''''';
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    http.Response streamResponse = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      var data = jsonDecode(streamResponse.body);
      print(response.statusCode);
      log('BHAI');

      var addressDataList = data["data"]["addressList"];

      List<AddressList> addresses = [];
      for (var addressData in addressDataList) {
        AddressList address = AddressList.fromJson(addressData);
        addresses.add(address);
      }

      return addresses;
    } else {
      print(token);
      print(response.statusCode);
      // Return an appropriate value or handle the error case
    }
  }
}
