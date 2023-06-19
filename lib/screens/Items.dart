import 'package:divine_drapes/screens/itemDetails.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class Items extends StatefulWidget {
  const Items({Key? key}) : super(key: key);

  @override
  State<Items> createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  TextEditingController search = TextEditingController();
  String? searchData;
  bool liked = false;
  bool isAdded = false;


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
                width: screenWidth*0.9,
                height: screenHeight*0.06,
                decoration: BoxDecoration(
                  border:Border.all(width: 2,color: Colors.black),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18
                    ),
                    prefixIcon:Icon(
                      Icons.search,color: darkPurple,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  InkWell(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Home()));
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(width: 10,),
                  Text("Mugs",style: GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                  SizedBox(width: 10,),
                ],
              ),
              Container(
                height: screenHeight,
                child: GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ItemDetails()));
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 5,),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 20,
                    itemBuilder: (context, position) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Container(
                          height: screenHeight*0.14,
                          width: screenWidth,
                          child: ListTile(
                            leading: FractionallySizedBox(
                              //widthFactor: 0.25,
                              //heightFactor: 1.6,// Adjust the width factor as needed
                              heightFactor: screenHeight*0.0021,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.asset('assets/mug.png',fit: BoxFit.fill,),
                              ),
                            ),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("M1 White Mug",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                                    Spacer(),
                                    Text("₹150",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                                  ],
                                ),
                                Text("Customizable with photo",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w500)),
                                SizedBox(height: screenHeight*0.0078,),
                                Row(
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                            color: cream,
                                            borderRadius: BorderRadius.circular(5)
                                        ),

                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              isAdded=!isAdded;
                                            });
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(horizontal: screenWidth*0.028,vertical: 5),
                                            child: isAdded ?
                                            Row(
                                              children: [
                                                Text("Added",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
                                                ),
                                                SizedBox(width: 8,),
                                                Container(
                                                  width: 30,
                                                    height: 20,
                                                    color: Colors.transparent,
                                                    child: Image.asset('assets/tick.png',
                                                    ))
                                              ],
                                            )
                                                :
                                            Text("Add to cart",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
