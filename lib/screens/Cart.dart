import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../consts/constants.dart';
import '../models/CartModel.dart' as data;


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
  List<data.CartModel> cartList = [];
  Future<List<data.CartModel>> getCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    print(token);
    if (token == null) {
      print('Authentication token is missing');
      return []; // Return an empty list if the token is missing
    }
    var headers = {
      'Authorization': 'Bearer $token',
    };
    final url = Uri.parse('https://divine-drapes.onrender.com/user/viewMyCart');
    final response = await http.get(url, headers: headers);
    var data1 = jsonDecode(response.body.toString());
    print(data1);
    if (response.statusCode == 200) {
      final cartData = data1['data'] as List<dynamic>;
      cartList = cartData
          .map((index) => data.CartModel.fromJson(index))
          .toList(); // Use map and toList to create the cartList
      return cartList;
    } else {
      return []; // Return an empty list in case of an error
    }
  }
  @override
  void initState() {
    getCartData();
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
            style: GoogleFonts.notoSans(color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
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
                    style: GoogleFonts.notoSans(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                height: screenHeight,
                child: FutureBuilder(
                  future: getCartData(),
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
                    } else if (!snapshot.hasData) {
                      return Text('No data available.');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: cartList.length,
                        itemBuilder: (context, position) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: FractionallySizedBox(
                                heightFactor: screenHeight * 0.0019,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: Image.network(
                                    cartList[position].data[position].photo.toString(),// Assuming 'picture' is a list of URLs
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              title: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cartList[position].data[position].name,
                                        style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      Text(
                                        "₹${cartList[position].data[position].cost.value}", // Assuming 'value' is the cost value
                                        style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    cartList[position].data[position].description,
                                    style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 7),
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: cream,
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            "Remove",
                                            style: GoogleFonts.notoSans(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            liked = liked ?? false; // Provide a default value of false if liked is null
                                            liked = !liked; // Now, perform the boolean operation
                                          });
                                        },
                                        child: liked
                                            ? Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                            : Icon(Icons.favorite_border_outlined),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
