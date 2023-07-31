import 'package:divine_drapes/screens/itemDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/constants.dart';

import 'package:divine_drapes/models/ProductModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/products_API.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  TextEditingController search = TextEditingController();
  String? searchData;
  bool liked = false;

  List<data.Data?> cartProducts = [];

  Future CartData() async {
    try {
      cartProducts = await Products().getCartData();
      print("future cart data: ");
      print(cartProducts.map((e) => e?.id));
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    CartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("Divine Drapes",
            style: GoogleFonts.notoSans(
                color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(5),
                width: screenWidth * 0.9,
                height: screenHeight * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkPurple,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10),
                  Text(
                    "My Cart",
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                height: screenHeight,
                child: FutureBuilder(
                  future: CartData(),
                  builder: (builder, snapshot) {
                    print('Snapshot: ${snapshot.connectionState}');
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: cream,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      print(snapshot.error);
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Padding(
                            padding:
                                const EdgeInsets.only(right: 4, bottom: 10),
                            child: StatefulBuilder(builder:
                                (BuildContext context, StateSetter setState) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Divider(
                                    thickness: 2,
                                  ),

                                  Container(
                                    height: screenHeight * 0.75,
                                    child: ListView.builder(
                                      padding: EdgeInsets.only(
                                        top: 5,
                                      ),
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: cartProducts.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ItemDetails(
                                                          id: cartProducts[
                                                                  index]!
                                                              .id,
                                                          image: (cartProducts[
                                                                      index]!
                                                                  .photo
                                                                  .picture
                                                                  .isEmpty)
                                                              ? 'assets/Vector.png'
                                                              : cartProducts[
                                                                      index]!
                                                                  .photo
                                                                  .picture[0],
                                                          desc: cartProducts[
                                                                  index]!
                                                              .description,
                                                          cost: cartProducts[
                                                                  index]!
                                                              .cost,
                                                          name: cartProducts[
                                                                  index]!
                                                              .name,
                                                          category:
                                                              cartProducts[
                                                                      index]!
                                                                  .category,
                                                          added: [],
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
                                                  heightFactor:
                                                      screenHeight * 0.0024,
                                                  child: AspectRatio(
                                                    aspectRatio: 1,
                                                    child: (cartProducts[index]!
                                                            .photo
                                                            .picture
                                                            .isEmpty)
                                                        ? Image.asset(
                                                            'assets/Vector.png',
                                                            // height: screenHeight*0.05,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            cartProducts[index]!
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            cartProducts[index]!
                                                                .name,
                                                            style: GoogleFonts.notoSans(
                                                                color: Colors
                                                                    .black,
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.036,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            cartProducts[index]!
                                                                    .cost
                                                                    .currency +
                                                                " " +
                                                                cartProducts[
                                                                        index]!
                                                                    .cost
                                                                    .value
                                                                    .toString(),
                                                            style: GoogleFonts.notoSans(
                                                                color: Colors
                                                                    .black,
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
                                                          cartProducts[
                                                                  index]!
                                                              .description,
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                      screenWidth *
                                                                          0.0348,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500)),
                                                      SizedBox(
                                                        height: screenHeight *
                                                            0.0078,
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
                                                                onTap:
                                                                    () async {},
                                                                child: Text(
                                                                  "Remove",
                                                                  style: GoogleFonts
                                                                      .notoSans(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
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
                                                              )),
                                                          Spacer(),
                                                          InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  liked =
                                                                      !liked;
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
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
