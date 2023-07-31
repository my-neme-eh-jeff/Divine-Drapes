import 'package:divine_drapes/screens/home.dart';
import 'package:divine_drapes/screens/itemDetails.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/constants.dart';
import 'package:http/http.dart' as http;
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
  static const String authTokenKey = 'auth_token';

  List<data.Data?> filteredProducts = [];
  bool isLoading = true;

  List<data.Data?> cartProducts = [];

  Future<void> CartData() async {
    try {
      cartProducts = await Products().getCartData();
      print("future cart data: ");
      print(cartProducts.map((e) => e?.id));
      filteredProducts = List.from(cartProducts);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void _performSearch(String query) {
    setState(() {
      filteredProducts = cartProducts
          .where((product) =>
              product?.name.toLowerCase().contains(query.toLowerCase()) ??
              false)
          .toList();
    });
  }

  Future<bool> removeFromCart(String productId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'https://divine-drapes.onrender.com/user/removeCart/$productId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print("Item removed successfully");
      Fluttertoast.showToast(
        msg: "Item removed successfully",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return true;
    } else {
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
                  controller: search,
                  onChanged: _performSearch,
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
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                      color: cream,
                    ))
                  : Container(
                      height: screenHeight,
                      child: SingleChildScrollView(
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
                                      itemCount: filteredProducts.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ItemDetails(
                                                          id: filteredProducts[
                                                                  index]!
                                                              .id,
                                                          image: (filteredProducts[
                                                                      index]!
                                                                  .photo
                                                                  .picture
                                                                  .isEmpty)
                                                              ? 'assets/Vector.png'
                                                              : filteredProducts[
                                                                      index]!
                                                                  .photo
                                                                  .picture[0],
                                                          desc:
                                                              filteredProducts[
                                                                      index]!
                                                                  .description,
                                                          cost:
                                                              filteredProducts[
                                                                      index]!
                                                                  .cost,
                                                          name:
                                                              filteredProducts[
                                                                      index]!
                                                                  .name,
                                                          category:
                                                              filteredProducts[
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
                                                    child: (filteredProducts[
                                                                index]!
                                                            .photo
                                                            .picture
                                                            .isEmpty)
                                                        ? Image.asset(
                                                            'assets/Vector.png',
                                                            // height: screenHeight*0.05,
                                                            fit: BoxFit.fill,
                                                          )
                                                        : Image.network(
                                                            filteredProducts[
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            filteredProducts[
                                                                    index]!
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
                                                            filteredProducts[
                                                                        index]!
                                                                    .cost
                                                                    .currency +
                                                                " " +
                                                                filteredProducts[
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
                                                          filteredProducts[
                                                                  index]!
                                                              .description,
                                                          style: GoogleFonts.notoSans(
                                                              color:
                                                                  Colors.black,
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
                                                                    () async {
                                                                  print(cartProducts[
                                                                          index]
                                                                      ?.id);
                                                                  var success =
                                                                      await removeFromCart(
                                                                          cartProducts[index]!
                                                                              .id);
                                                                  if (success) {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Home()));
                                                                  }
                                                                },
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
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
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
