// ignore_for_file: unused_import
import 'dart:convert';
import 'dart:developer';
import 'package:divine_drapes/screens/Account.dart';
import 'package:divine_drapes/screens/MyOrderInfo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:divine_drapes/models/OrderModel.dart' as data;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:divine_drapes/Provider/Auth/products_API.dart';
import 'package:divine_drapes/Provider/Auth/order_API.dart';

import '../consts/constants.dart';
import '../widgets/shimmer_widget.dart';
import 'home.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  bool isLoading = false;
  TextEditingController search = TextEditingController();
  List<data.Data?> orders = [];
  List<data.Data?> filteredOrders = [];

  String? searchData;
  List<String> productName = [];
  List<String> productDesc = [];
  List<String> productCost = [];

  Future<void> getViewOrder() async {
    setState(() {
      isLoading = true;
    });
    productCost = [];
    productDesc = [];
    productName = [];
    try {
      orders = await Order().getOrdersData();
      // print(orders.map((e) => e?.product));
      log("hi");
      print(orders[0]);
      // var product = await Products().getSpecificProduct(orders[0]!.product);
      // print(product['name']);
      for (int i = 0; i < orders.length; i++) {
        var product = await Products().getSpecificProduct(orders[i]!.product);
        productName.add(product['name']);
        productDesc.add(product['description']);
        productCost.add(product['cost']['value'].toString());
      }

      filteredOrders = List.from(orders);

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }

    // print("future products category wise:");
    // print(orders.length);
  }
  // void _performSearch(String query) {
  //   setState(() {
  //     filteredOrders = orders
  //         .where((product) =>
  //             product?.toLowerCase().contains(query.toLowerCase()) ??
  //             false)
  //         .toList();
  //   });
  // }

  @override
  void initState() {
    getViewOrder();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Column(
            children: [
              ShimmerWidget.rectangular(
                  width: screenWidth * 0.9, height: screenHeight * 0.055),
              SizedBox(
                height: screenHeight * 0.022,
              ),
              Transform.translate(
                  offset: Offset(-screenWidth * 0.3, 0),
                  child: ShimmerWidget.rectangular(width: 100, height: 20)),
              Divider(
                thickness: 2,
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
                              width: screenWidth * 0.3,
                              height: screenHeight * 0.12,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ShimmerWidget.rectangular(
                                        width: screenWidth * 0.38, height: 20),
                                    SizedBox(
                                      width: screenWidth * 0.1,
                                    ),
                                    ShimmerWidget.rectangular(
                                        width: screenWidth * 0.1, height: 18),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ShimmerWidget.rectangular(
                                    width: screenWidth * 0.6, height: 30),
                                SizedBox(
                                  height: 10,
                                ),
                                ShimmerWidget.rectangular(
                                    width: screenWidth * 0.3,
                                    height: screenHeight * 0.04),
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
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.w700)),
          elevation: 0.0,
        ),
        body: isLoading
            ? buildShimmer()
            : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Padding(
                    padding: const EdgeInsets.only(right: 4, bottom: 10),
                    child: StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                // margin: EdgeInsets.all(5),
                                width: screenWidth * 0.9,
                                height: screenHeight * 0.06,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.black),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextField(
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide.none),
                                    hintText: 'Search',
                                    contentPadding: EdgeInsets.zero,
                                    hintStyle: TextStyle(
                                        color: Colors.grey,
                                        fontSize: screenWidth * 0.05),
                                    prefixIcon: Icon(
                                      Icons.search,
                                      color: darkPurple,
                                    ),
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  InkWell(
                                      onTap: () {
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //     builder: (context) => const Home()));
                                        Navigator.of(context).pop();
                                      },
                                      child: Icon(Icons.arrow_back)),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "My Orders",
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: screenWidth * 0.044,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Divider(
                                thickness: 2,
                              )
                            ],
                          ),
                          Container(
                            height: screenHeight * 0.75,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: orders.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    MyOrderInfo(
                                                      id: orders[index]!.id,
                                                      name: productName[index],
                                                      date: orders[index]!
                                                          .createdAt,
                                                    )));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 0),
                                        child: Container(
                                          height: screenHeight * 0.14,
                                          width: screenWidth,
                                          child: ListTile(
                                            leading: FractionallySizedBox(
                                              //widthFactor: 0.25,
                                              //heightFactor: 1.6,// Adjust the width factor as needed
                                              heightFactor:
                                                  screenHeight * 0.0024,
                                              child: AspectRatio(
                                                aspectRatio: 1,
                                                child: (orders[index]!
                                                        .photo
                                                        .picture
                                                        .isEmpty)
                                                    ? Image.asset(
                                                        'assets/Vector.png',
                                                        // height: screenHeight*0.05,
                                                        fit: BoxFit.fill,
                                                      )
                                                    : Image.network(
                                                        orders[index]!
                                                            .photo
                                                            .picture[0],
                                                        fit: BoxFit.fill,
                                                      ),
                                              ),
                                            ),
                                            title: Transform.translate(
                                              offset: Offset(
                                                  0.0, -screenWidth * 0.05),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      children: [
                                                        Text(
                                                          productName[index],
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      screenWidth *
                                                                          0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                        Spacer(),
                                                        Text(
                                                          productCost[index] +
                                                              " Rs",
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      screenWidth *
                                                                          0.035,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                        productDesc[index],
                                                        style: GoogleFonts
                                                            .notoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.036,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400)),
                                                  ),
                                                  // SizedBox(
                                                  //   height: screenHeight * 0.0078,
                                                  // ),
                                                  Expanded(
                                                    flex: 3,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Spacer(),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                color: cream,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5)),
                                                            child:
                                                                GestureDetector(
                                                              onTap:
                                                                  () async {},
                                                              child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(5),
                                                                  child: Text(
                                                                    "Add Comments",
                                                                    style: GoogleFonts
                                                                        .notoSans(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          screenWidth *
                                                                              0.038,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600,
                                                                    ),
                                                                  )),
                                                            )),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                      child: Divider(
                                        thickness: 1,
                                      ),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    })),
              ));
  }
}
