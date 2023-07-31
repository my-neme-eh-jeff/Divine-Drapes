import 'dart:convert';

import 'package:divine_drapes/screens/itemDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divine_drapes/models/ProductModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/products_API.dart';
import 'package:http/http.dart'as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Provider/CartProvider.dart';
import '../consts/constants.dart';

class Items extends StatefulWidget {
  final String category;

  Items({Key? key, required this.category}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
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

  Future<bool> addToCart(String productId, BuildContext context,int index) async {
    final url = Uri.parse('https://divine-drapes.onrender.com/user/addCart/$productId');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    print(token);
    if (token == null) {
      print('Authentication token is missing');
      return false;
    }

    // Show the circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    // Hide the circular progress indicator
    Navigator.pop(context);

    if (response.statusCode == 200) {
      // Item added to cart successfully
      // Handle the response or show a success message
      print('Item added to cart successfully');
      print('Response: ${response.body}');

      // Show a success message
      Fluttertoast.showToast(
        msg: "Item added to cart successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
      cartProvider.addToCart(productId);
      return true;
    } else {
      // Failed to add item to cart
      // Handle the error or show an error message
      Fluttertoast.showToast(
        msg: "Failed to add item to cart!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response.statusCode);
      print('Response: ${response.body}');
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                              Divider(thickness: 2,)
                            ],
                          ),
                          
                          Container(
                            height: screenHeight*0.75,
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: productsCategoryWise.length,
                              itemBuilder: (context, index) {
                                String productId = productsCategoryWise[index]!.id;
                                CartProvider cartProvider = Provider.of<CartProvider>(context);
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => ItemDetails(
                                                  id: productsCategoryWise[index]!.id,
                                                  image: (productsCategoryWise[index]!.photo .picture.isEmpty)
                                                  ? 'assets/Vector.png'
                                                  : productsCategoryWise[index]!.photo.picture[0],
                                                  desc: productsCategoryWise[index]!.description,
                                                  cost: productsCategoryWise[index]!.cost,
                                                  name: productsCategoryWise[index]!.name,
                                                  category: productsCategoryWise[index]!.category,
                                                 added: isAdded,

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
                                            child: (productsCategoryWise[index]!
                                                    .photo
                                                    .picture
                                                    .isEmpty)
                                                ? Image.asset(
                                                    'assets/Vector.png',
                                                    // height: screenHeight*0.05,
                                                    fit: BoxFit.fill,
                                                  )
                                                : Image.network(
                                                    productsCategoryWise[index]!
                                                        .photo
                                                        .picture[0],
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                        ),
                                        title: Transform.translate(
                                          offset:
                                              Offset(0.0, -screenWidth * 0.04),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    productsCategoryWise[index]!
                                                        .name,
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize:
                                                            screenWidth * 0.04,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    productsCategoryWise[index]!
                                                            .cost
                                                            .currency +
                                                        " " +
                                                        productsCategoryWise[
                                                                index]!
                                                            .cost
                                                            .value
                                                            .toString(),
                                                    style: GoogleFonts.notoSans(
                                                        color: Colors.black,
                                                        fontSize:
                                                            screenWidth * 0.039,
                                                        fontWeight:
                                                            FontWeight.w700),
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
                                                                  .circular(5)),
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          bool success = await addToCart(productsCategoryWise[index]!.id, context, index);
                                                          if (success) {
                                                            // setState(() {
                                                            //   isAdded[index] = !isAdded[index];
                                                            //   print(isAdded);
                                                            //   _saveCartState();
                                                            // });
                                                          }
                                                        },
                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Text(
                                                            cartProvider.addedProductsIds.contains(productId) ? "Added" : "Add to cart",
                                                            style: GoogleFonts.notoSans(
                                                              color: Colors.black,
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w600,
                                                            ),
                                                          ),
                                                        ),
                                                        // isAdded[index] ?
                                                        // Row(
                                                        //         children: [
                                                        //           Text(
                                                        //             "Added",
                                                        //             style: GoogleFonts.notoSans(
                                                        //                 color: Colors
                                                        //                     .black,
                                                        //                 fontSize: screenWidth *
                                                        //                     0.04,
                                                        //                 fontWeight:
                                                        //                     FontWeight.w600),
                                                        //           ),
                                                        //           SizedBox(
                                                        //             width: 2,
                                                        //           ),
                                                        //           Container(
                                                        //               width:
                                                        //                   25,
                                                        //               height:
                                                        //                   20,
                                                        //               color: Colors
                                                        //                   .transparent,
                                                        //               child: Image
                                                        //                   .asset(
                                                        //                 'assets/tickmark.png',
                                                        //               ))
                                                        //         ],
                                                        //       ) : Text("Add to cart", style: GoogleFonts.notoSans(color: Colors.black,
                                                        //             fontSize:
                                                        //                 16,
                                                        //             fontWeight:
                                                        //                 FontWeight
                                                        //                     .w600),),
                                                      )
                                                  ),
                                                  Spacer(),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          liked = !liked;
                                                        });
                                                      },
                                                      child: liked
                                                          ? Icon(
                                                              Icons.favorite,
                                                              color: Colors.red,
                                                            )
                                                          : Icon(Icons
                                                              .favorite_border_outlined))
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
