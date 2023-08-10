import 'package:divine_drapes/admin_screens/AdminProductsView.dart';
import 'package:divine_drapes/admin_screens/NewOrders.dart';
import 'package:divine_drapes/admin_screens/PastOrders.dart';
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth/AuthProvider.dart';
import '../consts/constants.dart';

class AdminOrders extends StatefulWidget {
  const AdminOrders({Key? key}) : super(key: key);

  @override
  State<AdminOrders> createState() => _AdminOrdersState();
}

class _AdminOrdersState extends State<AdminOrders>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
  }

  Widget build(BuildContext context) {
    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: Column(
              children: [
                SizedBox(
                  height: 50, // Set the desired height
                  width: 200, // Set the desired width
                  child: InkWell(
                    onTap: () {
                      logoutProvider.Logout(context: context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: whiteColor,
                        border: Border.all(width: 2, color: Colors.black),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 0.5,
                            spreadRadius: 0.5,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(
                              "Log out",
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.logout,
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: whiteColor,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.w700)),
          elevation: 0.0,
        ),
        body:
            // Padding(
            //   padding: const EdgeInsets.all(20.0),
            //   child: Column(
            //     children: [
            //       SizedBox(
            //         height: 50,
            //         width: double.infinity,
            //         child: TabBar(
            //           isScrollable: true,
            //           controller: _controller,
            //           tabs: const [
            //             Tab(text: 'New Orders'),
            //             Tab(text: 'Past Orders'),
            //           ],
            //           labelColor: Colors.black,
            //           unselectedLabelColor: Colors.black,
            //           labelStyle: GoogleFonts.notoSans(
            //               fontSize: 18, fontWeight: FontWeight.w700),
            //           unselectedLabelStyle: GoogleFonts.notoSans(
            //               fontSize: 18, fontWeight: FontWeight.w700),
            //           indicator: BoxDecoration(
            //             border: Border(
            //               bottom: BorderSide(
            //                 color: Colors.black,
            //                 width: 3.0,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         child: TabBarView(
            //           controller: _controller,
            //           children: const <Widget>[
            //             NewOrders(),
            //             PastOrders(),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Column(
            children: [
              TabBar(
                isScrollable: true,
                controller: _controller,
                tabs: const [
                  Tab(text: '       New Orders       '),
                  Tab(text: '       Past Orders      '),
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                labelStyle: GoogleFonts.notoSans(
                    fontSize: 18, fontWeight: FontWeight.w700),
                unselectedLabelStyle: GoogleFonts.notoSans(
                    fontSize: 18, fontWeight: FontWeight.w700),
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
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
        ));
  }
}
