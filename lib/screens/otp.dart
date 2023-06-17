import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/screens/new_pass.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/dashed_textfield.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

final TextEditingController emailController = TextEditingController();

class _OTPState extends State<OTP> {
  void _onOtpChanged(String otp) {
    // Handle the OTP value here
    print('OTP entered: $otp');
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.05;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: cream,
      body: Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15),
                height: size.height * 0.22,
                width: size.width * 0.49,
                child: const Image(image: AssetImage('assets/Vector.png'))),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.147, vertical: size.height * 0.1),
              height: size.height * 0.7,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 30.0,
                      spreadRadius: 10,
                      offset: Offset(
                        20,
                        20,
                      ),
                    )
                  ],
                  color: whiteColor,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(size.height * 0.04),
                      topLeft: Radius.circular(size.height * 0.04)),
                  border: Border.all(color: whiteColor, width: 5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset password',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter the OTP received on your',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont * 0.8,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'email address',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont * 0.8,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.035),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Enter OTP',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DashedTextField(
                        length: 6, // Number of digits in OTP
                        onChanged: _onOtpChanged,
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.07),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const new_pass()));
                    },
                    child: Container(
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
                            'Continue',
                            style: GoogleFonts.notoSans(
                              fontSize: sizefont * 0.7,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              // height: size.height * 0.115,
              height: size.width * 0.255,
              width: size.width * 0.255,
              margin: EdgeInsets.only(top: size.height * 0.237),
              // margin: EdgeInsets.only(top: size.height * 0.25),

              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/Ellipse 4.png'),
                      fit: BoxFit.fill),
                  shape: BoxShape.circle),
            ),
          ],
        ),
      ]),
    );
  }
}
