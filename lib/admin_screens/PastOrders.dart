import 'dart:developer';

import 'package:divine_drapes/Provider/Auth/order_API.dart';
import 'package:divine_drapes/admin_screens/orderInfo.dart';
import 'package:divine_drapes/widgets/shimmer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PastOrders extends StatefulWidget {
  const PastOrders({Key? key}) : super(key: key);

  @override
  State<PastOrders> createState() => _PastOrdersState();
}

class _PastOrdersState extends State<PastOrders> {
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ));

  

  String? value1;
  String ItemName = "";

  bool isLoading = true;
  bool isFiltering = false;
  List<String> list1 = [];


  // List<data.Received?> allOrders = [];
  // var allOrders;
  List<Map<String, dynamic>> allOrders = [];

  List<Map<String, dynamic>> filteredOrders = [];
  Future AllOrdersData() async {
    var PastOrders = [];
    var i;
    try {
      print("future orders data: ");
      allOrders = await Order().getPastOrders();
      list1 = allOrders.map((e) => e['product']['category'].toString()).toList();
      list1 = list1.toSet().toList();
      log(allOrders.length.toString());

      // setState(() {
      //   isLoading = false;
      // });
      // print(filteredOrders);
      return allOrders;
    } catch (e) {
      print(e);
      return false;
    }
  }

  // @override
  // void initState() {
  //   AllOrdersData();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Transform.translate(
                offset: Offset(screenWidth * 0.27, 0),
                child: ShimmerWidget.rectangular(
                    width: screenWidth * 0.35, height: screenHeight * 0.032),
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            ShimmerWidget.rectangular(
                              width: screenWidth * 0.25,
                              height: screenHeight * 0.12,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ShimmerWidget.rectangular(
                                        width: screenWidth * 0.34, height: 12),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    ShimmerWidget.rectangular(
                                        width: screenWidth * 0.07, height: 12),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ShimmerWidget.rectangular(
                                    width: screenWidth * 0.45, height: 15),
                                SizedBox(
                                  height: 10,
                                ),
                                ShimmerWidget.rectangular(
                                    width: screenWidth * 0.3, height: 15),
                              ],
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ],
          ),
        );

    return Scaffold(
      body: FutureBuilder(
          future: AllOrdersData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Spacer(),
                        Container(
                          width: screenWidth * 0.36,
                          height: 30,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text("Select Item:"),
                              value: value1,
                              isExpanded: true,
                              items: list1.map(buildMenuItem).toList(),
                              // onChanged: (value) {
                              //   setState(() {
                              //     this.value1 = value;
                              //     ItemName = value!;
                              //   });
                              // },
                              onChanged: (value) {
                                setState(() {
                                  this.value1 = value;
                                  ItemName = value!;

                                  // Update the flag and filter the received items if a value is selected
                                  if (ItemName.isNotEmpty) {
                                    isFiltering = true;
                                    filteredOrders = allOrders
                                        .where((item) =>
                                            item['product']['category'] ==
                                            ItemName)
                                        .toList();
                                  } else {
                                    isFiltering = false;
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      // height: screenHeight * 0.65,
                      child: isFiltering
                          ? ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: filteredOrders.length,
                              itemBuilder: (context, position) {
                                return filteredOrders.isEmpty
                                    ? Center(
                                        child: Text('No results found'),
                                      )
                                    : Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                                    builder:
                                                        (context) => OrderInfo(
                                                              name: (filteredOrders[
                                                                              position][
                                                                          'product'] ==
                                                                      null)
                                                                  ? "---"
                                                                  : filteredOrders[
                                                                              position][
                                                                          'product']
                                                                      ['name'],
                                                              image: (filteredOrders[
                                                                              position][
                                                                          'product'] ==
                                                                      null)
                                                                  ? 'assets/Vector.png'
                                                                  : (filteredOrders[position]['product']['photo']
                                                                              [
                                                                              'picture']
                                                                          .isEmpty)
                                                                      ? 'assets/Vector.png'
                                                                      : filteredOrders[
                                                                              position]['product']['photo']
                                                                          [
                                                                          'picture'][0],
                                                              userName: filteredOrders[
                                                                      position][
                                                                  'user']['fname'],
                                                              contatct: filteredOrders[
                                                                              position][
                                                                          'user']
                                                                      ['number']
                                                                  .toString(),
                                                              email: filteredOrders[
                                                                      position][
                                                                  'user']['email'],
                                                              paymentMode:
                                                                  filteredOrders[
                                                                          position][
                                                                      'paymentType'],
                                                              paymentStatus:
                                                                  filteredOrders[
                                                                          position][
                                                                      'paymentStatus'],
                                                              address: filteredOrders[
                                                                          position][
                                                                      'user'][
                                                                  'addressList'],
                                                            )));
                                          },
                                          child: ListTile(
                                            leading: FractionallySizedBox(
                                              widthFactor: 0.27,
                                              heightFactor:
                                                  screenHeight * 0.0019,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: (filteredOrders[
                                                                position]![
                                                            'product'] ==
                                                        null)
                                                    ? Image.asset(
                                                        'assets/Vector.png',
                                                        // height: screenHeight*0.05,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : (filteredOrders[position]![
                                                                        'product']
                                                                    ['photo']
                                                                ['picture']
                                                            .isEmpty)
                                                        ? Image.asset(
                                                            'assets/Vector.png',
                                                            // height: screenHeight*0.05,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            filteredOrders[position]![
                                                                        'product']
                                                                    ['photo']
                                                                ['picture'][0],
                                                            fit: BoxFit.fill,
                                                          ),
                                              ),
                                            ),
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      (filteredOrders[position]![
                                                                  'product'] ==
                                                              null)
                                                          ? "---"
                                                          : filteredOrders[
                                                                  position]![
                                                              'product']['name'],
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.036,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                    Spacer(),
                                                    Text(
                                                      (filteredOrders[position]['product']== null)
                                                ? "--"
                                                : (filteredOrders[position]['product']['cost']['value']*filteredOrders[position]['product']['quantity']).toString() + " Rs",
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  screenWidth *
                                                                      0.031,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                    ),
                                                  ],
                                                ),
                                                Text("photo attached",
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500)),
                                                SizedBox(
                                                  height: 7,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(6.0),
                                                  child: Text(
                                                    "Payment: " +
                                                        filteredOrders[
                                                                position]![
                                                            'paymentType'],
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                              },
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: allOrders.length,
                              itemBuilder: (context, position) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => OrderInfo(
                                                    name: (allOrders[position]![
                                                                'product'] ==
                                                            null)
                                                        ? "---"
                                                        : allOrders[position]![
                                                            'product']['name'],
                                                    image: (allOrders[
                                                                    position]![
                                                                'product'] ==
                                                            null)
                                                        ? 'assets/Vector.png'
                                                        : (allOrders[position]![
                                                                            'product']
                                                                        [
                                                                        'photo']
                                                                    ['picture']
                                                                .isEmpty)
                                                            ? 'assets/Vector.png'
                                                            : allOrders[position]![
                                                                        'product']
                                                                    ['photo']
                                                                ['picture'][0],
                                                    userName: allOrders[
                                                            position]!['user']
                                                        ['fname'],
                                                    contatct:
                                                        allOrders[position]![
                                                                    'user']
                                                                ['number']
                                                            .toString(),
                                                    email: allOrders[position]![
                                                        'user']['email'],
                                                    paymentMode:
                                                        allOrders[position]![
                                                            'paymentType'],
                                                    paymentStatus:
                                                        allOrders[position]![
                                                            'paymentStatus'],
                                                    address: allOrders[
                                                            position]!['user']
                                                        ['addressList'],
                                                  )));
                                    },
                                    child: ListTile(
                                      leading: FractionallySizedBox(
                                        widthFactor: 0.27,
                                        heightFactor: screenHeight * 0.0019,
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: (allOrders[position]![
                                                      'product'] ==
                                                  null)
                                              ? Image.asset(
                                                  'assets/Vector.png',
                                                  // height: screenHeight*0.05,
                                                  fit: BoxFit.fill,
                                                )
                                              : (allOrders[position]!['product']
                                                          ['photo']['picture']
                                                      .isEmpty)
                                                  ? Image.asset(
                                                      'assets/Vector.png',
                                                      // height: screenHeight*0.05,
                                                      fit: BoxFit.fill,
                                                    )
                                                  : Image.network(
                                                      allOrders[position]![
                                                                  'product']
                                                              ['photo']
                                                          ['picture'][0],
                                                      fit: BoxFit.fill,
                                                    ),
                                        ),
                                      ),
                                      title: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                (allOrders[position][
                                                            'product'] ==
                                                        null)
                                                    ? "---"
                                                    : allOrders[position][
                                                        'product']['name'],
                                                style: GoogleFonts.notoSans(
                                                    color: Colors.black,
                                                    fontSize:
                                                        screenWidth * 0.036,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                              Spacer(),
                                              Text(
                                               (allOrders[position]['product']== null)
                                                ? "--"
                                                : (allOrders[position]['product']['cost']['value']*allOrders[position]['product']['quantity']).toString() + " Rs",
                                                style: GoogleFonts.notoSans(
                                                    color: Colors.black,
                                                    fontSize:
                                                        screenWidth * 0.031,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          Text("photo attached",
                                              style: GoogleFonts.notoSans(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(6.0),
                                            child: Text(
                                              "Payment: " +
                                                  allOrders[position]![
                                                      'paymentType'],
                                              style: GoogleFonts.notoSans(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}
