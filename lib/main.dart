
import 'package:divine_drapes/Provider/Auth/AuthProvider.dart';
import 'package:divine_drapes/screens/home.dart';
import 'package:divine_drapes/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'admin_screens/AdminBottomNav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> AuthProvider()),
      ],
      child:  MaterialApp(

          debugShowCheckedModeBanner: false,
          title: 'Divine Drapes',
        home: SplashScreen(),
        routes: {
          '/admin_bottom_nav': (context) => AdminBottomNav(),
          '/home': (context) => Home(),
        },
      ),
    );
    // home:
  }
}
