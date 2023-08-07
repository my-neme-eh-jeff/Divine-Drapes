import 'package:divine_drapes/admin_screens/orderInfo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class NewOrders extends StatefulWidget {
  const NewOrders({Key? key}) : super(key: key);

  @override
  State<NewOrders> createState() => _NewOrdersState();
}

class _NewOrdersState extends State<NewOrders> {
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ));

  final list1 = [
    "Mugs",
    "Paper Weight",
    "Coasters",
    "Hair Comb",
    "Envelop",
    "Diary",
    "Folders",
    "Study Desk",
    "Sequence Bag",
    "Sash",
    "T-Shirts",
    "Greetings Card",
    "Puzzles",
    "Luggage Tags",
    "Steel Crockery",
    "Locket & Keychain",
    "Magnet",
    "Photo Frames",
    "Pen & Pencil",
    "Bottles",
    "Cube",
    "Badges",
    "Play Card",
    "Calendars",
    "Writing Pads",
    "Crayons",
    "Sequence Pouch",
    "Pillows",
    "Cap",
    "Surprise Box",
    "Clock",
    "Passport Covers",
    "Pen Drive",
    "Smiley Table",
    "Key Chains",
    "Mobile Covers",
    "Pen Stand",
    "Wallets",
    "Office Products",
  ];

  String? value1;
  String ItemName = "";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(),
                Spacer(),
                Container(
                  width: screenWidth * 0.36,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select Item:"),
                      value: value1,
                      isExpanded: true,
                      items: list1.map(buildMenuItem).toList(),
                      onChanged: (value) {
                        setState(() {
                          this.value1 = value;
                          ItemName = value!;
                        });
                      },
                    ),
                  ),
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
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const OrderInfo()));
                      },
                      child: ListTile(
                        // leading: Container(
                        //   height: double.infinity,
                        //   child: Image.asset('assets/mug.png',fit: BoxFit.cover,),
                        //   //child: Image.network("https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/446b1af0-e6ba-4b0f-a9de-6ae6d3ed27a3/dfjhqn3-23d30b9d-16e3-42b6-aa12-e010a3999ef6.png/v1/fill/w_736,h_736,q_80,strp/satoru_gojo_aesthetic_pfp_by_harvester0fs0uls_dfjhqn3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzM2IiwicGF0aCI6IlwvZlwvNDQ2YjFhZjAtZTZiYS00YjBmLWE5ZGUtNmFlNmQzZWQyN2EzXC9kZmpocW4zLTIzZDMwYjlkLTE2ZTMtNDJiNi1hYTEyLWUwMTBhMzk5OWVmNi5wbmciLCJ3aWR0aCI6Ijw9NzM2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.F7_Ce5Ih1dhahsCnvFHRZgivj_8AByd9ZYHS3Ju0aws",height: 180,),
                        // ),
                        leading: FractionallySizedBox(
                          widthFactor: 0.27,
                          //heightFactor: 1.6,// Adjust the width factor as needed
                          heightFactor: screenHeight * 0.0019,
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
                                Text(
                                  "M1 White Mug",
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: screenWidth * 0.036,
                                      fontWeight: FontWeight.w700),
                                ),
                                Spacer(),
                                Text(
                                  "21/05/2023",
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: screenWidth * 0.031,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Text("photo attached",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            SizedBox(
                              height: 7,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                "Payment: mode",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        ),
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
    );
  }
}
