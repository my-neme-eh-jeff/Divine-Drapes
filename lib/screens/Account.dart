import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:divine_drapes/screens/MyOrders.dart';
import 'package:divine_drapes/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  data.Data? _profile;
  String? fname;

  Future getProfile() async {
    print('HELLO');
    _profile = await Profiles().getProfileData();
    print(_profile!.lName);
    // setState(() {
    //   // Trigger a rebuild after fetching the profile data
    // });
  }

  @override
  void initState() {
    getProfile();
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
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
              future: getProfile(),
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
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Account",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      Row(
                        children: [
                          Container(
                            height: screenHeight * 0.2,
                            width: screenWidth * 0.35,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                    "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/446b1af0-e6ba-4b0f-a9de-6ae6d3ed27a3/dfjhqn3-23d30b9d-16e3-42b6-aa12-e010a3999ef6.png/v1/fill/w_736,h_736,q_80,strp/satoru_gojo_aesthetic_pfp_by_harvester0fs0uls_dfjhqn3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzM2IiwicGF0aCI6IlwvZlwvNDQ2YjFhZjAtZTZiYS00YjBmLWE5ZGUtNmFlNmQzZWQyN2EzXC9kZmpocW4zLTIzZDMwYjlkLTE2ZTMtNDJiNi1hYTEyLWUwMTBhMzk5OWVmNi5wbmciLCJ3aWR0aCI6Ijw9NzM2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.F7_Ce5Ih1dhahsCnvFHRZgivj_8AByd9ZYHS3Ju0aws"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    _profile?.fName ?? '',
                                    // '',
                                    style: GoogleFonts.notoSans(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                _profile?.email ?? '',
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _profile?.number.toString() ?? '',
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyOrders()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "My Orders",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Favourites()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Favourites",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BulkOrder()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Bulk Order",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              })),
    );
  }
}
