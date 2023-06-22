import 'package:divine_drapes/admin_screens/AdminBulkOrders.dart';
import 'package:divine_drapes/admin_screens/AdminOrders.dart';
import 'package:divine_drapes/admin_screens/NewOrders.dart';
import 'package:divine_drapes/admin_screens/PastOrders.dart';
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this,);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
          elevation: 0.0,
        ),
      body:  Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
              child: TabBar(
                isScrollable: true,
                controller: _controller,
                tabs: const [
                  Tab(text: 'New Orders'),
                  Tab(text: 'Past Orders'),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelStyle: GoogleFonts.notoSans(fontSize: 18,fontWeight: FontWeight.w700),
                unselectedLabelStyle: GoogleFonts.notoSans(fontSize: 18,fontWeight: FontWeight.w700),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: const <Widget>[
                        NewOrders(),
                        PastOrders(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
