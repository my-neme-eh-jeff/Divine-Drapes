import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/Provider/Auth/order_API.dart';

import '../consts/constants.dart';

class MyOrderInfo extends StatefulWidget {
  final String id;
  final String name;
  final String date;
  MyOrderInfo({
    Key? key,
    required this.id,
    required this.name,
    required this.date,
  }) : super(key: key);

  @override
  State<MyOrderInfo> createState() => _MyOrderInfoState();
}

class _MyOrderInfoState extends State<MyOrderInfo> {
  var order;
  data.Data? _profile;

  Future getSpecificOrder() async {
    try {
      order = await Order().getSingleOrderData(widget.id);
      print('HELLO');
      _profile = await Profiles().getProfileData();
      // print(order['photo']['picture']);
    } catch (e) {
      print(e);
    }
    // print("future products category wise:");
    // print(orders.length);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.w700)),
          elevation: 0.0,
        ),
        body: FutureBuilder(
            future: getSpecificOrder(),
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
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
                              "My Orders",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          height: screenHeight * 0.08,
                          child: Row(
                            children: [
                              FractionallySizedBox(
                                heightFactor: screenHeight * 0.0022,
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: (order!['photo']['picture'].isEmpty)
                                      ? Image.asset(
                                          'assets/Vector.png',
                                          // height: screenHeight*0.05,
                                          fit: BoxFit.fill,
                                        )
                                      : Image.network(
                                          order!['photo']['picture'][0],
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              ),
                              SizedBox(
                                width: screenWidth * 0.04,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.name,
                                    style: GoogleFonts.notoSans(
                                        color: Colors.black,
                                        fontSize: screenWidth * 0.045,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Date: ",
                                        style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: screenWidth * 0.039,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        widget.date.split("T")[0],
                                        style: GoogleFonts.notoSans(
                                            color: Colors.black,
                                            fontSize: screenWidth * 0.039,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Name: ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _profile!.fName + " "+ _profile!.lName,
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Contact No. : ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _profile!.number.toString(),
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Email id: ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              _profile!.email,
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Payment: ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              order['paymentType'],
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Order Status: ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              order['orderStatus'],
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Row(
                          children: [
                            Text(
                              "Address: ",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "address",
                              style: GoogleFonts.notoSans(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }));
  }
}
