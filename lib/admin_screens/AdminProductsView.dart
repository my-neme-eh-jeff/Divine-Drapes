import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../Provider/Auth/AuthProvider.dart';
import '../Provider/Auth/products_API.dart';
import '../consts/constants.dart';
import 'package:divine_drapes/models/ProductModel.dart' as data;

import '../screens/Items.dart';
import 'AdminItems.dart';


class AdminProductsView extends StatefulWidget {
  const AdminProductsView({Key? key}) : super(key: key);

  @override
  State<AdminProductsView> createState() => _AdminProductsViewState();
}

class _AdminProductsViewState extends State<AdminProductsView> {
  List<data.Data?> products = [];
  String? fname;
  List<data.Data?> filteredProducts = [];
  bool isLoading = true;

  Future<void> getProducts() async {
    try {
      products = await Products().getProductsData();
      filteredProducts = List.from(products);
      setState(() {
        isLoading = false;
      });
      // print(products.map((e) => e?.photo.picture));
      // print((products[13]!.photo.picture.isEmpty) ? "asset": "network");
    } catch (e) {
      print(e);
    }
  }

  void _performSearch(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
      product?.category.toLowerCase().contains(query.toLowerCase()) ??
          false)
          .toList();
    });
  }

  @override
  void initState() {
    getProducts();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextEditingController search = TextEditingController();
    String? searchData;


    return Scaffold(
      drawer: Drawer(
        child :Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              SizedBox(
                height: 50, // Set the desired height
                width: 200, // Set the desired width
                child: InkWell(
                  onTap: () {
                    logoutProvider.Logout(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Log out",
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          // automaticallyImplyLeading: false,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.w700)),
          elevation: 0.0,
        ),
      body:  isLoading
          ? Center(
          child: CircularProgressIndicator(
            color: cream,
          ))
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: size.height * 0.004,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.04),
                padding: EdgeInsets.only(top: 0),
                width: width * 0.792,
                // height: height * 0.06,
                height: height * 0.05,
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.centerLeft,
                child: TextField(
                  cursorColor: Colors.black,
                  cursorHeight: height * 0.03,
                  controller: search,
                  onChanged: _performSearch,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: 'Search',
                    contentPadding: EdgeInsets.all(0),
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: darkPurple,
                    ),
                  ),
                  textAlignVertical: TextAlignVertical.center,
                ),
              ),
              // onPressed: _showCategories,
              GestureDetector(
                onTap: _showCategories,
                child: Container(
                    margin: EdgeInsets.only(
                        right: width * 0.045, left: width * 0.025),
                    height: height * 0.05,
                    child: Icon(
                      Icons.menu,
                      size: 35,
                    )),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.01875,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: width * 0.077),
                    child: Text("Personalised gift for all Occasions",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: width * 0.044,
                            fontWeight: FontWeight.w700)),
                  ),
                  GridView.count(
                    childAspectRatio: 0.82,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.094,
                        vertical: height * 0.033),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: width * 0.068,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      filteredProducts.length,
                          (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => AdminItems(
                                      category: products[index]!
                                          .category,
                                    )));
                              },
                              child: Container(
                                height: width * 0.215,
                                width: width * 0.215,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    border: Border.all(width: 0),
                                    image: DecorationImage(
                                      image: (filteredProducts[index]!
                                          .photo
                                          .picture
                                          .isEmpty)
                                          ? AssetImage(
                                          'assets/Vector.png')
                                          : NetworkImage(
                                          filteredProducts[index]!
                                              .photo
                                              .picture[
                                          0]) as ImageProvider,

                                      // image: AssetImage('assets/mug.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )),
                              ),
                            ),
                            Text(
                                filteredProducts[index]?.category ??
                                    "Mugs",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w600)),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Padding(
                    padding:
                    EdgeInsets.symmetric(horizontal: width * 0.077),
                    child: Text("Top Selling",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: width * 0.044,
                            fontWeight: FontWeight.w700)),
                  ),
                  GridView.count(
                    childAspectRatio: 0.82,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.094,
                        vertical: height * 0.033),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: width * 0.068,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      products.length,
                          (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                    builder: (context) => AdminItems(category: products[index]!.category,)));
                              },
                              child: Container(
                                height: width * 0.213,
                                width: width * 0.215,
                                decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.shade600,
                                        spreadRadius: 1,
                                      )
                                    ],
                                    border: Border.all(width: 0),
                                    image: DecorationImage(
                                      image: (products[index]!
                                          .photo
                                          .picture
                                          .isEmpty)
                                          ? AssetImage('assets/mug.png')
                                          : NetworkImage(
                                          products[index]!
                                              .photo
                                              .picture[0])
                                      as ImageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                  products[index]?.category ?? "Mugs",
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: width * 0.03,
                                      fontWeight: FontWeight.w600)),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ));

  }

  Future<void> _showCategories() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          var size = MediaQuery.of(context).size;
          var height = size.height;
          var width = size.width;
          return AlertDialog(
            insetPadding: EdgeInsets.fromLTRB(8, height * 0.09, 8, 5),
            scrollable: true,
            elevation: 2,
            // shadowColor: Colors.black,
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(
                  15.0,
                )),
            title: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          size: width * 0.077,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Categories",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: width * 0.044,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
                Divider(
                  thickness: 2,
                )
              ],
            ),
            content: Transform.translate(
              offset: Offset(0, -28),
              child: Container(
                height: height * 0.575,
                width: width * 0.82,
                child: ListView.builder(
                  physics: ScrollPhysics(),
                  itemCount: products.length,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: width * 0.1, top: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Items(
                              category: products[index]!.category,
                            )));
                      },
                      child: Text(products[index]!.category,
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: height * 0.025,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
