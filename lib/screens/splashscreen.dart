import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:divine_drapes/consts/constants.dart';
// import 'package:flutter_svg/flutter_svg.dart';

import 'Login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return AnimatedSplashScreen(
      // splash: SvgPicture.asset('assets/Ellipse 4.svg'),
      splash: 'assets/Ellipse 4.png',
      centered: true,
      splashIconSize: screenHeight*0.3,
      backgroundColor: whiteColor,
      nextScreen: const Login(),
      duration: 1500,
      splashTransition: SplashTransition.scaleTransition,
    );
  }
}
