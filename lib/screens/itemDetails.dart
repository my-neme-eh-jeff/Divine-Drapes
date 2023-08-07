import 'dart:convert';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divine_drapes/models/ProductModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/products_API.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/OrderStausProvider.dart';
import '../consts/constants.dart';

class ItemDetails extends StatefulWidget {
  final String id;
  final String image;
  final String desc;
  var cost;
  final String name;
  final String category;
  late List<bool> isAdded;

  ItemDetails({
    Key? key,
    required this.id,
    required this.image,
    required this.desc,
    required this.cost,
    required this.name,
    required this.category,
    required List<bool> added,
  }) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool liked = false;
  bool isAdded = false;
  bool placed = false;
  static const String authTokenKey = 'auth_token';




  var product;
  Future SpecificProduct() async {
    try {
      // product = await Products().getSpecificProduct(widget.id);
      // print(product);
      // print((products[13]!.photo.picture.isEmpty) ? "asset": "network");
    } catch (e) {
      print(e);
    }
  }

  List<data.Data?> productsCategoryWise = [];
  Future getProductsCategory() async {
    print('products category here');
    try {
      productsCategoryWise =
          await Products().getProductsDataCategorywise(widget.category);
          log(productsCategoryWise.length);
      // print(productsCategoryWise.map((e) => e?.id));
      // print((products[13]!.photo.picture.isEmpty) ? "asset": "network");
    } catch (e) {
      print(e);
    }
    print("future products category wise:");
    print(productsCategoryWise.length);
  }


  // Future<void> placeOrder(String pID) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(authTokenKey);
  //   var headers = {
  //     'Authorization': 'Bearer $token',
  //     'Content-Type': 'application/json'
  //   };
  //
  //   var jsonData = {
  //     "pID": pID,
  //     "isCustPhoto": true,
  //     "isCustText": true,
  //     "text": "ABC",
  //     "isCustColor": false,
  //     "paymentStatus": "pending",
  //     "paymentType": "cod"
  //   };
  //
  //   var request = http.Request('POST', Uri.parse('https://divine-drapes.onrender.com/user/order'));
  //   request.body = json.encode(jsonData);
  //   request.headers.addAll(headers);
  //
  //   // Show circular progress indicator while waiting for the response
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (BuildContext context) {
  //       return Center(
  //         child: CircularProgressIndicator(
  //           valueColor: AlwaysStoppedAnimation<Color>(cream),
  //         ),
  //       );
  //     },
  //   );
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   Navigator.of(context).pop(); // Hide the circular progress indicator
  //
  //   if (response.statusCode == 200) {
  //     print(await response.stream.bytesToString());
  //     Fluttertoast.showToast(
  //       msg: "Order Placed Successfully",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     setState(() {
  //       placed = !placed;
  //     });
  //   } else {
  //     print(response.reasonPhrase);
  //     Fluttertoast.showToast(
  //       msg: "Failed to place the order",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //   }
  // }


  @override
  void initState() {
    SpecificProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final orderStatusProvider = Provider.of<OrderStatusProvider>(context);
    @override
    void initState() {
      super.initState();
      // Call checkOrderStatus for each product ID in initState
      // to initialize the order status and retain it on refreshing the page
      orderStatusProvider.checkOrderStatus(widget.id);
    }
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
          future: SpecificProduct(),
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
              return Padding(
                padding: EdgeInsets.only(top: screenHeight * 0.008, left: screenWidth*0.02),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(Icons.arrow_back)),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          widget.name,
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Icon(
                          Icons.star,
                          color: cream,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          "4.5",
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: screenWidth * 0.07,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: screenHeight * 0.022,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth * 0.194,
                        ),
                        Center(
                          child: Container(
                            height: screenWidth * 0.416,
                            width: screenWidth * 0.416,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: (widget.image == "assets/Vector.png")
                                        ? AssetImage(widget.image)
                                        : NetworkImage(widget.image)
                                            as ImageProvider),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                )),
                          ),
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
                                : Icon(Icons.favorite_border_outlined)),
                        SizedBox(
                          width: screenWidth * 0.07,
                        ),
                      ],
                    ),
                    //SizedBox(height: screenHeight*0.02,),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 15, left: screenWidth * 0.05),
                      child: Text(widget.desc,
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(top: 5, left: screenWidth * 0.05),
                      child: Text(
                          widget.cost.currency +
                              " " +
                              widget.cost.value.toString(),
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w700)),
                    ),
                    //SizedBox(height: screenHeight*0.01,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: GestureDetector(
                            onTap: (){
                              orderStatusProvider.placeOrder(widget.id);
                            },
                            child: Container(
                              width: screenWidth * 0.85,
                              height: screenHeight * 0.052,
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(160, 30, 134, 1),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(

                                child:
                                orderStatusProvider.placedProducts[widget.id] ?? false?
                                Text(
                                  'Order Placed',
                                  style: GoogleFonts.notoSans(
                                    fontSize: screenWidth * 0.04,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ):
                                    Text(
                                      'Buy Now',
                                      style: GoogleFonts.notoSans(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                          ),
                          child: GestureDetector(
                            onTap: (){
                              print(widget.id);
                            },
                            child: Container(
                              width: screenWidth * 0.85,
                              height: screenHeight * 0.052,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  isAdded?'Added': 'Add to cart',
                                  style: GoogleFonts.notoSans(
                                    fontSize: screenWidth * 0.04,
                                    color:
                                        const Color.fromRGBO(160, 30, 134, 1),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: screenHeight * 0.02, left: screenWidth * 0.03),
                      child: Text(
                        "More like this...",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Divider(thickness: 2,),

                    FutureBuilder(
                        future: getProductsCategory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                            return Container(
                              height: screenHeight*0.342,
                              child: Transform.translate(
                                offset: Offset(-18, 0),
                                child: ListView.builder(
                                  padding: EdgeInsets.only(
                                    top: 5,
                                  ),
                                  shrinkWrap: true,
                                  physics: BouncingScrollPhysics(),
                                  itemCount: productsCategoryWise.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10),
                                      child: Container(
                                        // height: screenHeight * 0.15,
                                        width: screenWidth,
                                        child: ListTile(
                                          leading: FractionallySizedBox(
                                            //widthFactor: 0.25,
                                            //heightFactor: 1.6,// Adjust the width factor as needed
                                            heightFactor:
                                                screenHeight * 0.0021,
                                            child: AspectRatio(
                                              aspectRatio: 1,
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .push(MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  ItemDetails(
                                                                    id: productsCategoryWise[
                                                                            index]!
                                                                        .id,
                                                                    image: (productsCategoryWise[index]!                                                   
                                                                            .photo
                                                                            .picture
                                                                            .isEmpty)
                                                                        ? 'assets/mug.png'
                                                                        : productsCategoryWise[index]!
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
                                                                        productsCategoryWise[index]!
                                                                            .category,
                                                                    added: [],
                                                                  )));
                                                },
                                                child: (productsCategoryWise[index]!
                                                    .photo
                                                    .picture
                                                    .isEmpty)
                                                ? Image.asset(
                                                    'assets/mug.png',
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
                                          ),
                                          title: Transform.translate(
                                            offset: Offset(0, -10),
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
                                                      style: GoogleFonts
                                                          .notoSans(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: screenWidth*0.036,
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
                                                      style: GoogleFonts
                                                          .notoSans(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: screenWidth*0.033,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                    productsCategoryWise[
                                                            index]!
                                                        .description,
                                                    style:
                                                        GoogleFonts.notoSans(
                                                            color:
                                                                Colors.black,
                                                            fontSize: screenWidth*0.031,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
                                                SizedBox(
                                                  height:
                                                      screenHeight * 0.0078,
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
                                                        child:
                                                            GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isAdded =
                                                                  !isAdded;
                                                            });
                                                          },
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        screenWidth *
                                                                            0.028,
                                                                    vertical:
                                                                        5),
                                                            child: isAdded
                                                                ? Row(
                                                                    children: [
                                                                      Text(
                                                                        "Added",
                                                                        style: GoogleFonts.notoSans(
                                                                            color: Colors.black,
                                                                            fontSize: 16,
                                                                            fontWeight: FontWeight.w600),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            2,
                                                                      ),
                                                                      Container(
                                                                          width:
                                                                              30,
                                                                          height:
                                                                              20,
                                                                          color:
                                                                              Colors.transparent,
                                                                          child: Image.asset(
                                                                            'assets/tickmark.png',
                                                                          ))
                                                                    ],
                                                                  )
                                                                : Text(
                                                                    "Add to cart",
                                                                    style: GoogleFonts.notoSans(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                          ),
                                                        )),
                                                    Spacer(),
                                                    InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            liked = !liked;
                                                          });
                                                        },
                                                        child: liked
                                                            ? Icon(
                                                                Icons
                                                                    .favorite,
                                                                color: Colors
                                                                    .red,
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
                                    );
                                  },
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                ),
              );
            }
          }),
    );
  }
}
