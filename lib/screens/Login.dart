import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/payment/cod.dart';
import 'package:divine_drapes/screens/forgotpassword.dart';
import 'package:divine_drapes/screens/home.dart';
import 'package:divine_drapes/screens/signup.dart';
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../admin_screens/AdminBottomNav.dart';
import '../admin_screens/AdminHome.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.135),
              // padding: EdgeInsets.symmetric(horizontal: size.width * 0.147),
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
                  SizedBox(height: size.height * 0.08),
                  Text(
                    'Email',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont,
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
                        autofocus: false,
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please enter your Email ID");
                          }
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid Email");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: emailController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: sizefont,
                                  ),
                                  onPressed: () => emailController.clear(),
                                ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.005,
                              horizontal: size.width * 0.03),
                          isDense: true,
                          hintText: 'Enter your Email address',
                          hintStyle: TextStyle(fontSize: sizefont * 0.8),
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
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    'Password',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont,
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
                  SizedBox(height: size.height * 0.0015),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.all(Colors.green),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      ),
                      Text(
                        'Remember me',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont * 0.65,
                          color: const Color.fromRGBO(0, 0, 0, 0.55),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Forgotpass()));
                        },
                        child: Text(
                          'Forgot password?',
                          style: GoogleFonts.notoSans(
                            fontSize: sizefont * 0.6,
                            color: const Color.fromRGBO(175, 13, 13, 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.01),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const Home()));
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
                            'Login',
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
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.of(context).push(MaterialPageRoute(
                  //         builder: (context) => const Home()));
                  //   },
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: size.height * 0.052,
                  //     decoration: BoxDecoration(
                  //       color: Color.fromRGBO(160, 30, 134, 1),
                  //       borderRadius: BorderRadius.circular(10),
                  //       border: Border.all(
                  //         color: Colors.black,
                  //         width: 2,
                  //       ),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       crossAxisAlignment: CrossAxisAlignment.center,
                  //       children: [
                  //         Text(
                  //           'Login',
                  //           style: GoogleFonts.notoSans(
                  //             fontSize: sizefont * 0.7,
                  //             color: Colors.white,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  const Row(
                    children: [
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'OR',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                          child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      )),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                    width: double.infinity,
                    height: size.height * 0.052,
                    decoration: BoxDecoration(
                      color: Colors.white,
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
                          'Login with Google',
                          style: GoogleFonts.notoSans(
                            fontSize: sizefont * 0.7,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 8),
                        SizedBox(
                          width: 20,
                          height: 20,
                          child: Image.asset(
                            'assets/google.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account? ',
                        style: GoogleFonts.poppins(
                          fontSize: sizefont * 0.7,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const Signup()));
                        },
                        child: Text(
                          'Signup',
                          style: GoogleFonts.poppins(
                            fontSize: sizefont * 0.7,
                            color: const Color.fromRGBO(175, 13, 13, 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Are you an Admin? ',
                        style: GoogleFonts.poppins(
                          fontSize: sizefont * 0.7,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AdminBottomNav()));
                        },
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: sizefont * 0.7,
                            color: const Color.fromRGBO(175, 13, 13, 0.85),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
