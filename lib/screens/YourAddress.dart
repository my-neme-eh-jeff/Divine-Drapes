import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/models/ProfileModel.dart';
import 'package:divine_drapes/screens/EditAddress.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:divine_drapes/models/ProfileModel.dart' as data;

import '../consts/constants.dart';
import '../widgets/shimmer_widget.dart';

class address extends StatefulWidget {
  const address({super.key});

  @override
  State<address> createState() => _addressState();
}

class _addressState extends State<address> {
  bool isLoading = false;
  Data? _profile;
  AddressList? _address;

  List<AddressList> addresses = [];

  Future getProfile() async {
    setState(() {
      isLoading = true;
    });
    _profile = await Profiles().getProfileData();
    addresses = await Profiles().getAddressData();
    print(addresses);
    // _address = await Profiles().getAddressData();
    // print(_address?.building ?? 'ERROR YAAAAR');

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
    var size = MediaQuery.of(context).size;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Transform.translate(
            offset: Offset(screenWidth * 0.07, screenWidth * 0.15),
            child: ShimmerWidget.rectangular(
                width: screenWidth * 0.86,
                 height: screenHeight * 0.17),
          ),
        );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("Your Addresses",
            style: GoogleFonts.notoSans(
                color: brownColor, fontSize: 26, fontWeight: FontWeight.w700)),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            )),
      ),
      body: isLoading
          ? buildShimmer()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 25),
                  Card(
                    elevation: 4,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(addresses[0].addressOf ?? 'Address',
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600)),
                          Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                          Text(
                            _profile?.fName ?? '',
                            style: GoogleFonts.notoSans(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(addresses[0].houseNumber +
                              ' , ' +
                              addresses[0].building +
                              ' , ' +
                              addresses[0].street),
                          Text(addresses[0].city +
                              ' , ' +
                              addresses[0].state +
                              ' , ' +
                              addresses[0].country),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const EditAddress()));
                            },
                            child: Container(
                              width: 50,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
