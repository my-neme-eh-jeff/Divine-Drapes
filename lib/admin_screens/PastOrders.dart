import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PastOrders extends StatefulWidget {
  const PastOrders({Key? key}) : super(key: key);

  @override
  State<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Past Orders"),
    );
  }
}
