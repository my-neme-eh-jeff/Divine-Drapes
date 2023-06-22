import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../consts/constants.dart';

class OrderInfo extends StatefulWidget {
  const OrderInfo({Key? key}) : super(key: key);

  @override
  State<OrderInfo> createState() => _OrderInfoState();
}

class _OrderInfoState extends State<OrderInfo> {
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
        title: Text("Divine Drapes",style: GoogleFonts.notoSans(color: darkPurple,fontSize: 28,fontWeight: FontWeight.w700)),
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  InkWell(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Home()));
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(width: 10,),
                  Text("My Orders",style: GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                height: screenHeight*0.08,
                child: Row(
                  children: [
                    FractionallySizedBox(
                      heightFactor: screenHeight*0.0017,
                      child: AspectRatio(
                          aspectRatio: 1,
                          child: Image.asset('assets/mug.png',fit: BoxFit.cover,)),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("M1 White Mug",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),),
                        Row(
                          children: [
                            Text("Date: ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),),
                            Text("21/05/2023",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w500),),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Name: ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("Jenny",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Contact No. : ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("999999999",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Email id: ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("jenny@gmail.com",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Payment: ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("mode",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Text("Address: ",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                  Text("address",style:  GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w600),),
                ],
              ),
            ),
      Container(
      width: double.infinity,
      height: size.height * 0.052,
      decoration: BoxDecoration(
        color: Color.fromRGBO(160, 30, 134, 1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Submit',
            style: GoogleFonts.notoSans(
              fontSize: sizefont * 0.7,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
          ],
        ),
      )
    );
  }
}
