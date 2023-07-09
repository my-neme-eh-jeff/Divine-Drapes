import 'package:divine_drapes/screens/Items.dart';
import 'package:flutter/material.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController search = TextEditingController();
  String? searchData;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height = size.height;
    var width = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   flexibleSpace: Container(
      //     child: Padding(
      //       padding: EdgeInsets.only(top: size.height * 0.03625),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           SizedBox(width: size.width * 0.075),
      //           Text(
      //             'Divine Drapes',
      //             style: GoogleFonts.notoSans(
      //               // fontSize: height * 0.035,
      //               fontSize: width * 0.075,
      //               color: darkPurple,
      //               fontWeight: FontWeight.w700,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("Divine Drapes",
            style: GoogleFonts.notoSans(
                color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
        elevation: 0.0,
      ),
      body: Column(
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
                    padding: EdgeInsets.symmetric(horizontal: width * 0.077),
                    child: Text("Personalised gift for all occasions",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: width * 0.044,
                            fontWeight: FontWeight.w700)),
                  ),
                  GridView.count(
                    childAspectRatio: 0.82,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.094, vertical: height * 0.033),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: width * 0.068,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      9,
                      (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Items()));
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
                                      image: AssetImage(
                                        'assets/mug.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )),
                              ),
                            ),
                            Text("Mugs ",
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
                    padding: EdgeInsets.symmetric(horizontal: width * 0.077),
                    child: Text("Top Selling",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: width * 0.044,
                            fontWeight: FontWeight.w700)),
                  ),
                  GridView.count(
                    childAspectRatio: 0.82,
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.094, vertical: height * 0.033),
                    physics: BouncingScrollPhysics(),
                    crossAxisCount: 3,
                    crossAxisSpacing: width * 0.068,
                    mainAxisSpacing: 10.0,
                    shrinkWrap: true,
                    children: List.generate(
                      9,
                      (index) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const Items()));
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
                                      image: AssetImage(
                                        'assets/mug.png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    )),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5),
                              child: Text("Mugs",
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
      ),
    );
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
            title: Row(
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
            content: Container(
              height: height * 0.575,
              width: width * 0.82,
              child: ListView.builder(
                physics: ScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, index) => Padding(
                  padding: EdgeInsets.only(left: width * 0.1, top: 10),
                  child: Text("Item $index",
                      style: GoogleFonts.notoSans(
                          color: Colors.black,
                          fontSize: height * 0.025,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
          );
        });
  }
}
