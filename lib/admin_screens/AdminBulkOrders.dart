import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth/AuthProvider.dart';
import '../consts/constants.dart';

class AdminBulkOrders extends StatefulWidget {
  const AdminBulkOrders({Key? key}) : super(key: key);

  @override
  State<AdminBulkOrders> createState() => _AdminBulkOrdersState();
}

class _AdminBulkOrdersState extends State<AdminBulkOrders> {
  @override
  Widget build(BuildContext context) {
    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Bulk Orders"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            logoutProvider.Logout(context: context);
          },
          child: Container(
            decoration: BoxDecoration(
                color: whiteColor,
                border:
                Border.all(width: 2, color: Colors.black),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 0.5,
                    spreadRadius: 0.5,
                    offset: Offset(2, 2),
                  )
                ]),
            height: screenHeight * 0.05,
            width: screenWidth * 0.7,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Log out",
                    style: GoogleFonts.notoSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  ),
                  Spacer(),
                  Icon(
                    Icons.logout,
                    color: Colors.red,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
