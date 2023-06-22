import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key}) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  bool liked = false;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      // appBar: AppBar(
      //   backgroundColor: whiteColor,
      //   automaticallyImplyLeading: false,
      //   title: Text("Divine Drapes",
      //       style: GoogleFonts.notoSans(
      //           color: darkPurple,
      //           fontSize: screenHeight * 0.035,
      //           fontWeight: FontWeight.w700)),
      //   elevation: 0.0,
      // ),
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
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            left: screenWidth * 0.047, right: screenWidth * 0.04),
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: screenHeight * 0.01),
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
                    "M1 White Mug",
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
                padding: EdgeInsets.only(top: 15, left: screenWidth * 0.05),
                child: Text("Customizable with photo",
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: screenWidth * 0.05),
                child: Text("₹150",
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
                        child: Text(
                          'Buy Now',
                          style: GoogleFonts.notoSans(
                            fontSize: screenWidth * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
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
                          'Add to Cart',
                          style: GoogleFonts.notoSans(
                            fontSize: screenWidth * 0.04,
                            color: const Color.fromRGBO(160, 30, 134, 1),
                            fontWeight: FontWeight.w600,
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

              Container(
                height: screenHeight,
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 5,
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: screenHeight * 0.14,
                        width: screenWidth,
                        child: ListTile(
                          leading: FractionallySizedBox(
                            //widthFactor: 0.25,
                            //heightFactor: 1.6,// Adjust the width factor as needed
                            heightFactor: screenHeight * 0.0021,
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const ItemDetails()));
                                },
                                child: Image.asset(
                                  'assets/mug.png',
                                  fit: BoxFit.fill,
                                ),
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
                                    "M1 White Mug",
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Text(
                                    "₹150",
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                              Text("Customizable with photo",
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500)),
                              SizedBox(
                                height: screenHeight * 0.0078,
                              ),
                              Row(
                                children: [
                                  Container(
                                      decoration: BoxDecoration(
                                          color: cream,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            isAdded = !isAdded;
                                          });
                                        },
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: screenWidth * 0.028,
                                              vertical: 5),
                                          child: isAdded
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      "Added",
                                                      style:
                                                          GoogleFonts.notoSans(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                    ),
                                                    SizedBox(
                                                      width: 2,
                                                    ),
                                                    Container(
                                                        width: 30,
                                                        height: 20,
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
                                                      color: Colors.black,
                                                      fontSize: 16,
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
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : Icon(
                                              Icons.favorite_border_outlined))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
