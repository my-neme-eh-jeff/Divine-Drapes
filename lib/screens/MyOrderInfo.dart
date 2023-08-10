import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/Provider/Auth/order_API.dart';

import '../consts/constants.dart';
import '../widgets/shimmer_widget.dart';

class MyOrderInfo extends StatefulWidget {
  final String id;

  MyOrderInfo({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<MyOrderInfo> createState() => _MyOrderInfoState();
}

class _MyOrderInfoState extends State<MyOrderInfo> {
  var order;

  Future getSpecificOrder() async {
    try {
      order = await Order().getSingleOrderData(widget.id);
    } catch (e) {
      print(e);
    }
    // print("future products category wise:");
    // print(orders.length);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);

    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Transform.translate(
                offset: Offset(screenWidth * 0.08, 0),
                child: ShimmerWidget.rectangular(
                    width: screenWidth * 0.29, height: screenHeight * 0.025),
              ),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Transform.translate(
                offset: Offset(-5, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerWidget.rectangular(
                        width: screenWidth * 0.34, height: screenHeight * 0.14),
                    Transform.translate(
                      offset: Offset(-15, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShimmerWidget.rectangular(
                              width: screenWidth * 0.35,
                              height: screenHeight * 0.025),
                          SizedBox(
                            height: 8,
                          ),
                          ShimmerWidget.rectangular(
                              width: screenWidth * 0.38,
                              height: screenHeight * 0.022),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(-screenWidth * 0.06, -10),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              ShimmerWidget.rectangular(
                                  width: screenWidth * 0.65,
                                  height: screenHeight * 0.033),
                              SizedBox(
                                height: 5,
                              )
                            ],
                          ));
                    }),
              ),
              Transform.translate(
                offset: Offset(screenWidth * 0.14, 25),
                child: ShimmerWidget.rectangular(
                    width: screenWidth * 0.73, height: screenHeight * 0.17),
              )
            ],
          ),
        );
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
                return buildShimmer();
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return SingleChildScrollView(
                  child: Padding(
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
                                    child: (order['data']['photo']['picture']
                                                .isEmpty &&
                                            order['data']['product']['photo']
                                                    ['picture']
                                                .isEmpty)
                                        ? Image.asset(
                                            'assets/Vector.png',
                                            // height: screenHeight*0.05,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            (order['data']['photo']['picture']
                                                    .isEmpty)
                                                ? order['data']['product']
                                                    ['photo']['picture'][0]
                                                : order['data']['photo']
                                                    ['picture'][0],
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
                                      order['data']['product']['name'] ?? "NA",
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
                                          (order['data']['createdAt'] == Null)
                                              ? "NA"
                                              : order['data']['createdAt']
                                                  .split("T")[0],
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
                                order['data']['user']['fName'] +
                                    " " +
                                    order['data']['user']['lName'],
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
                                order['data']['user']['number'].toString(),
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
                              Expanded(
                                child: Text(
                                  order['data']['user']['email'],
                                  style: GoogleFonts.notoSans(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
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
                                order['data']['paymentType'] ?? "NA",
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
                                order['data']['orderStatus'] ?? "NA",
                                style: GoogleFonts.notoSans(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, -20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 25),
                                  Card(
                                    elevation: 4,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              (order['data']['user']
                                                          ['addressList'].isEmpty)
                                                  ? " "
                                                  : (order['data']['user']
                                                              ['addressList'][0]
                                                          ['addressOf'] ??
                                                      "Address"),
                                              style: GoogleFonts.notoSans(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600)),
                                          Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                          (order['data']['user']
                                                      ['addressList'].isEmpty)
                                              ? Text("NA")
                                              : Text(
                                                  order['data']['user']
                                                              ['addressList'][0]
                                                          ['houseNumber'] +
                                                      ' , ' +
                                                      order['data']['user']
                                                              ['addressList'][0]
                                                          ['building'] +
                                                      ' , ' +
                                                      order['data']['user']
                                                              ['addressList'][0]
                                                          ['street'],
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                          (order['data']['user']
                                                      ['addressList'].isEmpty)
                                              ? Text("NA")
                                              : Text(
                                                  order['data']['user']
                                                              ['addressList'][0]
                                                          ['city'] +
                                                      ' , ' +
                                                      order['data']['user']
                                                              ['addressList'][0]
                                                          ['state'] +
                                                      ' , ' +
                                                      order['data']['user']
                                                              ['addressList'][0]
                                                          ['country'],
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }));
  }
}
