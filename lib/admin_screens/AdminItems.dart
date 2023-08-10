import 'dart:convert';

import 'package:divine_drapes/admin_screens/UpdateProductPage.dart';
import 'package:divine_drapes/screens/itemDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divine_drapes/models/ProductModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/products_API.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/CartProvider.dart';
import '../consts/constants.dart';
import '../widgets/shimmer_widget.dart';
import 'AdminItemDetails.dart';

class AdminItems extends StatefulWidget {
  final String category;

  AdminItems({Key? key, required this.category}) : super(key: key);

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

class _AdminItemsState extends State<AdminItems> {
  TextEditingController search = TextEditingController();
  String? searchData;
  bool liked = false;
  late List<bool> isAdded;
  List<data.Data?> productsCategoryWise = [];
  static const String authTokenKey = 'auth_token';

  // Future<void> _saveCartState() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String> addedProductsIds = productsCategoryWise
  //       .asMap()
  //       .entries
  //       .where((entry) => isAdded[entry.key])
  //       .map((entry) => entry.value!.id)
  //       .toList();
  //   prefs.setStringList('cartItems', addedProductsIds);
  // }

  Future getProductsCategory() async {
    print('products category here');
    try {
      productsCategoryWise =
          await Products().getProductsDataCategorywise(widget.category);
      // print(productsCategoryWise.map((e) => e?.id));
      // print((products[13]!.photo.picture.isEmpty) ? "asset": "network");
      //
      // isAdded = List.filled(productsCategoryWise.length, false);
      // print(isAdded);
    } catch (e) {
      print(e);
    }
    print("future products category wise:");
    print(productsCategoryWise.length);
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _loadCartState(); // Call the method to load cart state
  // }

  // Future<void> _loadCartState() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final List<String> addedProductsIds =
  //       prefs.getStringList('cartItems') ?? []; // Retrieve stored cart items
  //   setState(() {
  //     isAdded = productsCategoryWise
  //         .map((product) => addedProductsIds.contains(product!.id))
  //         .toList();
  //   });
  // }

  // @override
  // void initState() {
  //   getProductsCategory();
  //   super.initState();
  // }

  Future<bool> deleteProduct(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('DELETE',
        Uri.parse('https://divine-drapes.onrender.com/admin/deleteProduct'));
    request.body = json.encode({"productID": productId});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(
        msg: "Item deleted successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
      print(response.statusCode);
      print(response.reasonPhrase);
      Fluttertoast.showToast(
        msg: "Something went Wrong",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Column(
            children: [
              ShimmerWidget.rectangular(
                  width: screenWidth * 0.9, height: screenHeight * 0.058),
              SizedBox(
                height: screenHeight * 0.015,
              ),
              Transform.translate(
                  offset: Offset(-screenWidth * 0.29, 8),
                  child: ShimmerWidget.rectangular(
                      width: 110, height: screenHeight * 0.042)),
              Padding(
                padding: EdgeInsets.only(left: 10, top: 8),
                child: Divider(
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ShimmerWidget.rectangular(
                                  width: screenWidth * 0.28,
                                  height: screenHeight * 0.125,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        ShimmerWidget.rectangular(
                                            width: screenWidth * 0.38,
                                            height: screenHeight * 0.02),
                                        SizedBox(
                                          width: screenWidth * 0.12,
                                        ),
                                        ShimmerWidget.rectangular(
                                            width: screenWidth * 0.1,
                                            height: screenHeight * 0.02),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ShimmerWidget.rectangular(
                                        width: screenWidth * 0.6, height: 22),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        ShimmerWidget.rectangular(
                                            width: screenWidth * 0.25,
                                            height: screenHeight * 0.04),
                                        SizedBox(
                                          width: screenWidth * 0.25,
                                        ),
                                        ShimmerWidget.rectangular(
                                            width: screenWidth * 0.1,
                                            height: screenHeight * 0.04),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 0),
                            child: Divider(
                              thickness: 1,
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        );

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.03625),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenWidth * 0.075),
                Text(
                  'Divine Drapes',
                  style: GoogleFonts.notoSans(
                    // fontSize: height * 0.035,
                    fontSize: screenWidth * 0.075,
                    color: darkPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: FutureBuilder(
          future: getProductsCategory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return buildShimmer();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              isAdded = List.filled(productsCategoryWise.length, false);
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
                                    widget.category,
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
                              itemCount: productsCategoryWise.length,
                              itemBuilder: (context, index) {
                                String productId =
                                    productsCategoryWise[index]!.id;
                                CartProvider cartProvider =
                                    Provider.of<CartProvider>(context);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AdminItemDetails(
                                                  id: productsCategoryWise[
                                                          index]!
                                                      .id,
                                                  image: (productsCategoryWise[
                                                              index]!
                                                          .photo
                                                          .picture
                                                          .isEmpty)
                                                      ? 'assets/Vector.png'
                                                      : productsCategoryWise[
                                                              index]!
                                                          .photo
                                                          .picture[0],
                                                  desc: productsCategoryWise[
                                                          index]!
                                                      .description,
                                                  cost: productsCategoryWise[
                                                          index]!
                                                      .cost,
                                                  name: productsCategoryWise[
                                                          index]!
                                                      .name,
                                                  category:
                                                      productsCategoryWise[
                                                              index]!
                                                          .category,
                                                  added: isAdded,
                                                )));
                                  },
                                  child: FittedBox(
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
                                              child:
                                                  (productsCategoryWise[index]!
                                                          .photo
                                                          .picture
                                                          .isEmpty)
                                                      ? Image.asset(
                                                          'assets/Vector.png',
                                                          // height: screenHeight*0.05,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : Image.network(
                                                          productsCategoryWise[
                                                                  index]!
                                                              .photo
                                                              .picture[0],
                                                          fit: BoxFit.fill,
                                                        ),
                                            ),
                                          ),
                                          title: Transform.translate(
                                            offset: Offset(
                                                0.0, -screenWidth * 0.04),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      productsCategoryWise[
                                                              index]!
                                                          .name,
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
                                                      productsCategoryWise[
                                                                  index]!
                                                              .cost
                                                              .currency +
                                                          " " +
                                                          productsCategoryWise[
                                                                  index]!
                                                              .cost
                                                              .value
                                                              .toString(),
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
                                                  ],
                                                ),
                                                Text(
                                                    productsCategoryWise[index]!
                                                        .description,
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
                                                                    .circular(
                                                                        5)),
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              // bool success = await addToCart(productsCategoryWise[index]!.id, context, index);
                                                              // if (success) {
                                                              //   // setState(() {
                                                              //   //   isAdded[index] = !isAdded[index];
                                                              //   //   print(isAdded);
                                                              //   //   _saveCartState();
                                                              //   // });
                                                              // }
                                                              Navigator.of(context).push(
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          UpdateProductPage(
                                                                            id: productsCategoryWise[index]!.id,
                                                                            image: (productsCategoryWise[index]!.photo.picture.isEmpty)
                                                                                ? 'assets/Vector.png'
                                                                                : productsCategoryWise[index]!.photo.picture[0],
                                                                            desc:
                                                                                productsCategoryWise[index]!.description,
                                                                            cost:
                                                                                productsCategoryWise[index]!.cost,
                                                                            name:
                                                                                productsCategoryWise[index]!.name,
                                                                            category:
                                                                                productsCategoryWise[index]!.category,
                                                                            quantity:
                                                                                productsCategoryWise[index]!.quantity,
                                                                          )));
                                                            },
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6.0),
                                                              child: Text(
                                                                "Update",
                                                                style: GoogleFonts
                                                                    .notoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 16,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ))),
                                                    Spacer(),
                                                    Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.red,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: GestureDetector(
                                                            onTap: () async {
                                                              bool success =
                                                                  await deleteProduct(
                                                                      productsCategoryWise[
                                                                              index]!
                                                                          .id);
                                                              if (success) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pushReplacement(MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                AdminItems(category: widget.category)));
                                                              }
                                                            },
                                                            child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        6.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .delete_outline,
                                                                  color: Colors
                                                                      .white,
                                                                )))),
                                                  ],
                                                )
                                              ],
                                            ),
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
