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
import 'home.dart';

class MyOrders extends StatefulWidget {
  const MyOrders({Key? key}) : super(key: key);

  @override
  State<MyOrders> createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  TextEditingController search = TextEditingController();
  List<data.Data?> orders = [];
  String? searchData;
  List<String> productName = [];
  List<String> productDesc = [];
  List<String> productCost = [];

  Future getViewOrder() async {
    productCost = [];
    productDesc = [];
    productName = [];
    try {
      orders = await Order().getOrdersData();
      // print(orders.map((e) => e?.product));
      // print("product....");
      // var product = await Products().getSpecificProduct(orders[0]!.product);
      // print(product['name']);

      for (int i = 0; i < orders.length; i++) {
        var product = await Products().getSpecificProduct(orders[i]!.product);
        productName.add(product['name']);
        productDesc.add(product['description']);
        productCost.add(product['cost']['value'].toString());
        
      }

    } catch (e) {
      print(e);
    }
    // print("future products category wise:");
    // print(orders.length);
  }

@override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("Divine Drapes",
            style: GoogleFonts.notoSans(
                color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
        elevation: 0.0,
      ),
      body: FutureBuilder(
          future: getViewOrder(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: CircularProgressIndicator(
                      color: cream,
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              return SingleChildScrollView(
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
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => MyOrderInfo(
                                              id: orders[index]!.id,
                                              name: productName[index],
                                              date: orders[index]!.createdAt,
                                                )));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 10),
                                    child: Container(
                                      height: screenHeight * 0.14,
                                      width: screenWidth,
                                      child: ListTile(
                                        leading: FractionallySizedBox(
                                          //widthFactor: 0.25,
                                          //heightFactor: 1.6,// Adjust the width factor as needed
                                          heightFactor: screenHeight * 0.0024,
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
                                          offset:
                                              Offset(0.0, -screenWidth * 0.05),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    productName[index],
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize:
                                                            screenWidth * 0.04,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    productCost[index]+" Rs",
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize:
                                                            screenWidth * 0.039,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              Text(productDesc[index],
                                                  style: GoogleFonts.notoSans(
                                                      color: Colors.black,
                                                      fontSize:
                                                          screenWidth * 0.035,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                              SizedBox(
                                                height: screenHeight * 0.0078,
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                      decoration: BoxDecoration(
                                                          color: cream,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5)),
                                                      child: GestureDetector(
                                                        onTap: () async {},
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Text(
                                                              "Add Comments",
                                                              style: GoogleFonts
                                                                  .notoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                              ),
                                                            )),
                                                      )),
                                                  Spacer(),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    })),
              );
            }
          }),
    );
  }
}
