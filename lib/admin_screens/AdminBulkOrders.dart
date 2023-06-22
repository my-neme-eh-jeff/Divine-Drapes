import 'package:flutter/material.dart';

class AdminBulkOrders extends StatefulWidget {
  const AdminBulkOrders({Key? key}) : super(key: key);

  @override
  State<AdminBulkOrders> createState() => _AdminBulkOrdersState();
}

class _AdminBulkOrdersState extends State<AdminBulkOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Bulk Orders"),
      ),
    );
  }
}
