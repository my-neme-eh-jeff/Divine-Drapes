import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/models/ProfileModel.dart';
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:divine_drapes/screens/EditProfile.dart';
import 'package:divine_drapes/screens/MyOrders.dart';
import 'package:divine_drapes/screens/YourAddress.dart';
import 'package:divine_drapes/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth/AuthProvider.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  data.Data? _profile;
  String? fname;
  bool isLoading = true;
  List<AddressList> addresses = [];

  Future getProfile() async {
    setState(() {
      isLoading = true;
    });
    _profile = await Profiles().getProfileData();
    addresses = await Profiles().getAddressData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);
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
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: cream,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
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
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                        height: screenHeight * 0.2,
                        width: screenWidth * 0.33,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage('${_profile?.profilePic}'),
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
                                // "Jenny",
                                _profile?.fName ?? '',
                                style: GoogleFonts.notoSans(
                                    color: brownColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                // "Jenny",
                                _profile?.lName ?? '',
                                style: GoogleFonts.notoSans(
                                    color: brownColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 15, bottom: 10),
                                child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile()));
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      size: 18,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            // "abc@gmail.com",
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
                            border: Border.all(width: 2, color: Colors.black),
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
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
                            border: Border.all(width: 2, color: Colors.black),
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
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
                            border: Border.all(width: 2, color: Colors.black),
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
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
                            builder: (context) => const address()));
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
                              )
                            ]),
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Manage address",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14, fontWeight: FontWeight.w700),
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
                              )
                            ]),
                        height: screenHeight * 0.05,
                        width: screenWidth * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text(
                                "Log out",
                                style: GoogleFonts.notoSans(
                                    fontSize: 14, fontWeight: FontWeight.w700),
                              ),
                              Spacer(),
                              Icon(
                                Icons.logout,
                                color: Colors.red,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )),
    );
  }
}
