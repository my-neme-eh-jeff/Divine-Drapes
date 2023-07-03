import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesFile {

  void setToken(String token) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('token', token);
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token').toString();
  }

  // setIsAdmin(bool isAdmin) async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setBool('isAdmin', isAdmin);
  // }
  //
  // checkIsAdmin() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   return sharedPreferences.getBool('isAdmin');
  // }
  //
  // deleteUser() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.remove('isAdmin');
  //   sharedPreferences.remove('token');
  // }

}