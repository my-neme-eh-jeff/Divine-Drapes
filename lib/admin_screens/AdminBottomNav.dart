import 'package:divine_drapes/admin_screens/AddProducts.dart';
import 'package:divine_drapes/admin_screens/AdminProductsView.dart';
import 'package:divine_drapes/admin_screens/AdminOrders.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _selectedIndex = 0;
  static  List<Widget> _widgetOptions = <Widget>[
    AdminProductsView(),
    AddProductPage(),
    AdminOrders(),
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
      drawer: Drawer(

      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Text("View Products",style: GoogleFonts.notoSans(fontSize: 14,fontWeight: FontWeight.w700),),
                label: "", backgroundColor: cream),
            BottomNavigationBarItem(
                icon: Text("Add Products",style: GoogleFonts.notoSans(fontSize: 14,fontWeight: FontWeight.w700),),
                label: "",
                backgroundColor: cream),
            BottomNavigationBarItem(
                icon: Text("Orders",style: GoogleFonts.notoSans(fontSize: 14,fontWeight: FontWeight.w700),),
                label: "",
                backgroundColor: cream),
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
