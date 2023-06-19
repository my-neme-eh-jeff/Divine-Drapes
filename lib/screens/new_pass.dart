import 'package:divine_drapes/consts/constants.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class new_pass extends StatefulWidget {
  const new_pass({super.key});

  @override
  State<new_pass> createState() => _new_passState();
}

final TextEditingController emailController = TextEditingController();

class _new_passState extends State<new_pass> {
  bool isHidden = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.05;

    void togglePasswordView() {
      setState(() {
        isHidden = !isHidden;
      });
    }

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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  Text(
                    'Create new password',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont * 0.8,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.052,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextFormField(
                        style: TextStyle(fontSize: sizefont),
                        obscureText: isHidden,
                        autofocus: false,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter your Password");
                          }
                          if (!RegExp(r'^.{8,}$').hasMatch(value)) {
                            return ("Please Enter a valid Password");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(fontSize: sizefont * 0.8),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: const Icon(Icons.lock),
                          isDense: true,
                          suffixIcon: InkWell(
                            onTap: togglePasswordView,
                            child: FittedBox(
                              alignment: Alignment.center,
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '*The password must be minimum 8 characters',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont * 0.6,
                      // color: Colors.rgba(0, 0, 0, 0.65),
                      // color: Color.fromARGB(0, 0, 0, 1),
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Confirm new password',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont * 0.8,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  SizedBox(
                    height: size.height * 0.052,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextFormField(
                        style: TextStyle(fontSize: sizefont),
                        obscureText: isHidden,
                        autofocus: false,
                        controller: passwordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter your Password");
                          }
                          if (!RegExp(r'^.{8,}$').hasMatch(value)) {
                            return ("Please Enter a valid Password");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(fontSize: sizefont * 0.8),
                          contentPadding: const EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.black)),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          prefixIcon: const Icon(Icons.lock),
                          isDense: true,
                          suffixIcon: InkWell(
                            onTap: togglePasswordView,
                            child: FittedBox(
                              alignment: Alignment.center,
                              fit: BoxFit.fitHeight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  isHidden
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
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
                          'Reset Password',
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
