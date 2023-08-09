import 'package:divine_drapes/screens/Cart.dart';
import 'package:divine_drapes/screens/EditProfile.dart';
import 'package:divine_drapes/screens/HomePage.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:flutter/material.dart';

import 'Account.dart';

class Home extends StatefulWidget {
  final int? initial;
  Home({this.initial, Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late int _selectedIndex;
  late List<Widget> _widgetOptions;

  @override
  void initState() {
    _selectedIndex = widget.initial ?? 0;
    super.initState();
    _widgetOptions = <Widget>[HomePage(), Cart(), MyAccount()];
  }

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
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: height * 0.037,
                ),
                label: "",
                backgroundColor: cream),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.shopping_cart_outlined,
                  size: height * 0.037,
                ),
                label: "",
                backgroundColor: cream),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person_outline,
                size: height * 0.037,
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
