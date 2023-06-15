import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  bool liked = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                height: screenHeight * 0.065,
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
                        borderSide: BorderSide.none),
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
                    "Favourites",
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                height: screenHeight,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: 20,
                  itemBuilder: (context, position) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        // leading: Container(
                        //   height: double.infinity,
                        //   child: Image.asset('assets/mug.png',fit: BoxFit.cover,),
                        //   //child: Image.network("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/446b1af0-e6ba-4b0f-a9de-6ae6d3ed27a3/dfjhqn3-23d30b9d-16e3-42b6-aa12-e010a3999ef6.png/v1/fill/w_736,h_736,q_80,strp/satoru_gojo_aesthetic_pfp_by_harvester0fs0uls_dfjhqn3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzM2IiwicGF0aCI6IlwvZlwvNDQ2YjFhZjAtZTZiYS00YjBmLWE5ZGUtNmFlNmQzZWQyN2EzXC9kZmpocW4zLTIzZDMwYjlkLTE2ZTMtNDJiNi1hYTEyLWUwMTBhMzk5OWVmNi5wbmciLCJ3aWR0aCI6Ijw9NzM2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.F7_Ce5Ih1dhahsCnvFHRZgivj_8AByd9ZYHS3Ju0aws",height: 180,),
                        // ),
                        leading: FractionallySizedBox(
                          //heightFactor: 1.2,// Adjust the width factor as needed
                          heightFactor: screenHeight * 0.0014,
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.asset(
                              'assets/mug.png',
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
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "M1 White Mug",
                                      style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Text("Customizable with photo",
                                        style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                                Spacer(),
                                Column(
                                  children: [
                                    Text(
                                      "₹150",
                                      style: GoogleFonts.notoSans(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
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
                                ),
                              ],
                            ),
                            // SizedBox(height: 7,),
                          ],
                        ),
                      ),
                    );
                    //   Padding(
                    // padding: const EdgeInsets.all(20.0),
                    // child:
                    //     Column(
                    //       mainAxisAlignment: MainAxisAlignment.start,
                    //       crossAxisAlignment: CrossAxisAlignment.start,
                    //       children: [
                    //         Row(
                    //           children: [
                    //             Container(
                    //               height: MediaQuery.of(context).size.height*.056,
                    //               width: MediaQuery.of(context).size.width*.37,
                    //               decoration: BoxDecoration(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 image: DecorationImage(
                    //                   colorFilter: ColorFilter.mode(
                    //                     Colors.black.withOpacity(0.1),
                    //                     BlendMode.multiply,
                    //                   ),
                    //                   image: NetworkImage("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/446b1af0-e6ba-4b0f-a9de-6ae6d3ed27a3/dfjhqn3-23d30b9d-16e3-42b6-aa12-e010a3999ef6.png/v1/fill/w_736,h_736,q_80,strp/satoru_gojo_aesthetic_pfp_by_harvester0fs0uls_dfjhqn3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzM2IiwicGF0aCI6IlwvZlwvNDQ2YjFhZjAtZTZiYS00YjBmLWE5ZGUtNmFlNmQzZWQyN2EzXC9kZmpocW4zLTIzZDMwYjlkLTE2ZTMtNDJiNi1hYTEyLWUwMTBhMzk5OWVmNi5wbmciLCJ3aWR0aCI6Ijw9NzM2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.F7_Ce5Ih1dhahsCnvFHRZgivj_8AByd9ZYHS3Ju0aws"),
                    //
                    //                 ),
                    //               ),
                    //             ),
                    //
                    //             Column(
                    //
                    //               mainAxisAlignment: MainAxisAlignment.start,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text("M1 White Mug"),
                    //                 Text("Customizable with Photo"),
                    //                 SizedBox(height: 10,),
                    //                 Text("150R"),
                    //               ],
                    //             ),
                    //
                    //           ],
                    //         )
                    //       ],
                    //     )
                    //
                    // );
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
