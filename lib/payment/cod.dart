import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/screens/forgotpassword.dart';
import 'package:divine_drapes/screens/signup.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class COD extends StatefulWidget {
  const COD({super.key});

  @override
  State<COD> createState() => _CODState();
}

class _CODState extends State<COD> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width;

    return Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       children: [
      //         Text(
      //           'Divine Drapes',
      //           style: GoogleFonts.notoSans(
      //             fontSize: sizefont * 0.077,
      //             color: darkPurple,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
      body: Container(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.0375),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * 0.075),
                  Container(
                    child: Text(
                      'Divine Drapes',
                      style: GoogleFonts.notoSans(
                        fontSize: sizefont * 0.077,
                        color: darkPurple,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.0275),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    checkoutItem(),
                    checkoutItem(),
                    const SizedBox(height: 10),
                    Text(
                      'Payment',
                      style: GoogleFonts.notoSans(
                        fontSize: sizefont * 0.039,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),
                    GestureDetector(
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.05,
                        decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 17),
                            Text(
                              'Select payment method',
                              style: GoogleFonts.notoSans(
                                fontSize: sizefont * 0.039,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Address',
                      style: GoogleFonts.notoSans(
                        fontSize: sizefont * 0.039,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 13),
                    Container(
                        width: double.infinity,
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: addressController,
                          style: TextStyle(fontSize: sizefont * 0.04),
                          autofocus: false,
                          onSaved: (value) {
                            addressController.text = value!;
                          },
                          decoration: InputDecoration(
                            suffixIcon: addressController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: sizefont * 0.04,
                                    ),
                                    onPressed: () => addressController.clear(),
                                  ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size.width * 0.005,
                                horizontal: size.width * 0.03),
                            isDense: true,
                            hintStyle: TextStyle(fontSize: sizefont * 0.04),
                            hintText: "Address",
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 1,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                          ),
                        )),
                    const SizedBox(height: 13),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              width: double.infinity,
                              height: size.height * 0.05,
                              child: TextFormField(
                                controller: cityController,
                                style: TextStyle(fontSize: sizefont * 0.04),
                                autofocus: false,
                                onSaved: (value) {
                                  cityController.text = value!;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: cityController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: sizefont * 0.04,
                                          ),
                                          onPressed: () =>
                                              cityController.clear(),
                                        ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: size.width * 0.005,
                                      horizontal: size.width * 0.03),
                                  isDense: true,
                                  hintStyle:
                                      TextStyle(fontSize: sizefont * 0.04),
                                  hintText: "City",
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                              )),
                        ),
                        SizedBox(width: 30),
                        Expanded(
                          flex: 1,
                          child: Container(
                              width: double.infinity,
                              height: size.height * 0.05,
                              child: TextFormField(
                                controller: stateController,
                                style: TextStyle(fontSize: sizefont * 0.04),
                                autofocus: false,
                                onSaved: (value) {
                                  stateController.text = value!;
                                },
                                decoration: InputDecoration(
                                  suffixIcon: stateController.text.isEmpty
                                      ? Container(
                                          width: 0,
                                        )
                                      : IconButton(
                                          icon: Icon(
                                            Icons.close,
                                            size: sizefont * 0.04,
                                          ),
                                          onPressed: () =>
                                              stateController.clear(),
                                        ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: size.width * 0.005,
                                      horizontal: size.width * 0.03),
                                  isDense: true,
                                  hintStyle:
                                      TextStyle(fontSize: sizefont * 0.04),
                                  hintText: "State",
                                  enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(height: 13),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget checkoutItem() {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 3),
        Text(
          'M1 White Mug',
          style: GoogleFonts.notoSans(
            fontSize: sizefont * 0.045,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: size.width * 0.21,
              width: size.width * 0.21,
              child: Image.asset('assets/Rectangle 24.png'),
            ),
            const SizedBox(width: 7),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.height * 0.008),
                Text(
                  'Customizable with photo',
                  style: GoogleFonts.notoSans(
                    fontSize: sizefont * 0.039,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '₹150',
                  style: GoogleFonts.notoSans(
                    fontSize: sizefont * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 7),
        Text(
          'Customization',
          style: GoogleFonts.notoSans(
            fontSize: sizefont * 0.039,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: size.height * 0.015),
        Container(
          width: double.infinity,
          height: size.height * 0.05,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Add photo',
                style: GoogleFonts.notoSans(
                  fontSize: sizefont * 0.039,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 10),
              const Icon(
                Icons.upload, // Replace with the desired prefix icon
                color: Colors.black54,
              ),
            ],
          ),
        ),
        SizedBox(height: 5),
        Divider(
          color: darkPurple,
          thickness: 2,
        ),
      ],
    );
  }
}
