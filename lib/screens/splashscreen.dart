import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:divine_drapes/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? username;
  String? password;

  Future<String?> retrieveData() async {
    final prefs = await SharedPreferences.getInstance();

    username = prefs.getString('username');
    password = prefs.getString('password');
    print(username);
    print(password);
    if (username == null) {
      // print('KUCH NHI HUA BHAI');
    }
  }

  @override
  void initState() {
    super.initState();
    retrieveData().then((_) {
      if (username != null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Home()));
      }
      // else {
      //   Navigator.of(context)
      //       .pushReplacement(MaterialPageRoute(builder: (_) => Login()));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      // splash: SvgPicture.asset('assets/Ellipse 4.svg'),
      splash: 'assets/Ellipse 4.png',
      centered: true,
      splashIconSize: screenHeight * 0.3,
      backgroundColor: whiteColor,
      nextScreen: Login(),
      duration: 1500,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
