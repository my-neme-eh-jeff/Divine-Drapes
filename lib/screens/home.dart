import 'package:divine_drapes/screens/Cart.dart';
import 'package:divine_drapes/screens/HomePage.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:flutter/material.dart';

import 'Account.dart';
import 'Items.dart';

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
    MyAccount()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  size: height * 0.05,
                ),
                label: "",
                backgroundColor: cream),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart,
                  size: height * 0.05,
                ),
                label: "",
                backgroundColor: cream),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: height * 0.05,
              ),
              label: "",
              backgroundColor: cream,
            ),
          ],
          type: BottomNavigationBarType.shifting,
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          // iconSize: 30,
          onTap: _onItemTapped,
          elevation: 5),
    );
  }
}
