import 'package:divine_drapes/screens/Account.dart';
import 'package:divine_drapes/screens/Cart.dart';
import 'package:divine_drapes/screens/HomePage.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Cart(),
    // Text('Profile Page',
    //     style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    MyAccount(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   title: Text('Divine Drapes',
      //   style: TextStyle(color: darkPurple),
      //   ),
      //     backgroundColor: whiteColor
      // ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: "Home", backgroundColor: cream),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart_outlined),
                label: "Cart",
                backgroundColor: cream),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline_outlined),
              label: "User",
              backgroundColor: cream,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
