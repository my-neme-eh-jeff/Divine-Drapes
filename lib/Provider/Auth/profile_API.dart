import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/SharedPref.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/ProfileModel.dart';

class Profiles {
  Data? _profileData;
  static const String authTokenKey = 'auth_token';

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
      print(response.statusCode);
      print(token);
      print(data);
      log(response.statusCode.toString());
      var getProfile = User.fromJson(data);
      _profileData = getProfile.data;
      return _profileData;
    } else {
      print(token);
      print(response.statusCode);
    }
  }
}
