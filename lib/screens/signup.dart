// ignore_for_file: unused_local_variable, unused_import

import 'package:divine_drapes/consts/constants.dart';

import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth/AuthProvider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isValidEmail(String input) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input);
  }

  final _formKey = GlobalKey<FormState>();
  bool isHidden = true;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  bool isChecked = false;
  String? dobstring;


  @override
  void dispose() {
    // TODO: implement dispose
    fnameController.dispose();
    lnameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    //_confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<AuthProvider>(context, listen: false);
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;

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
                // height: size.height * 0.22,
                // width: size.width * 0.49,
                height: size.height * 0.1625,
                width: size.width * 0.3611,
                child: const Image(image: AssetImage('assets/Vector.png'))),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.122),
              height: size.height * 0.763,
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
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: size.height * 0.06),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First Name',
                                style: GoogleFonts.notoSans(
                                  fontSize: sizefont,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.361,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: sizefont),
                                    autofocus: false,
                                    controller: fnameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("First Name*");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      fnameController.text = value!;
                                    },
                                   // textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixIcon: fnameController.text.isEmpty
                                          ? Container(
                                              width: 0,
                                            )
                                          : IconButton(
                                              icon: Icon(
                                                Icons.close,
                                                size: sizefont,
                                              ),
                                              onPressed: () =>
                                                  fnameController.clear(),
                                            ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.005,
                                          horizontal: size.width * 0.03),
                                      isDense: true,
                                      hintText: 'First name',
                                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Last Name',
                                style: GoogleFonts.notoSans(
                                  fontSize: sizefont,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.06,
                                width: size.width * 0.361,
                                child: Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: TextFormField(
                                    style: TextStyle(fontSize: sizefont),
                                    autofocus: false,
                                    controller: lnameController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return ("Last Name*");
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      lnameController.text = value!;
                                    },
                                    // textInputAction: TextInputAction.next,
                                    decoration: InputDecoration(
                                      suffixIcon: lnameController.text.isEmpty
                                          ? Container(
                                        width: 0,
                                      )
                                          : IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          size: sizefont,
                                        ),
                                        onPressed: () =>
                                            lnameController.clear(),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: size.width * 0.005,
                                          horizontal: size.width * 0.03),
                                      isDense: true,
                                      hintText: 'Last name',
                                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                                      enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.001),
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
                        height: size.height * 0.069,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
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
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                              ),
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Phone number',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        height: size.height * 0.069,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            keyboardType: TextInputType.phone,
                            style: TextStyle(fontSize: sizefont),
                            autofocus: false,
                            controller:phoneController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter your Email ID");
                              }
                              if (!RegExp(r'^[+0]?\d{10,12}$')
                                  .hasMatch(value)) {
                                return ("Please Enter a valid Phone-No.");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              phoneController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: phoneController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: sizefont,
                                      ),
                                      onPressed: () => phoneController.clear(),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.005,
                                  horizontal: size.width * 0.03),
                              isDense: true,
                              hintText: 'Enter your phone number',
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
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                              ),
                              prefixIcon: const Icon(Icons.phone),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Text(
                        'Date Of Birth',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      SizedBox(
                        height: size.height * 0.063,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            // keyboardType: TextInputType.datetime,
                            style: TextStyle(fontSize: sizefont),
                            autofocus: false,
                            controller: dobController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return ("Please enter your Date of Birth");
                              }
                              if (!RegExp(r'^(19|20)\d{2}-(0?[1-9]|1[0-2])-([1-9]|0?[1-9]|[12][0-9]|3[01])$')
                                  .hasMatch(value)) {
                                return ("Please Enter a valid Date of Birth");
                              }
                              return null;
                            },
                            onSaved: (value) {
                              dobController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: dobController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: sizefont,
                                      ),
                                      onPressed: () => dobController.clear(),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.005,
                                  horizontal: size.width * 0.03),
                              isDense: true,
                              hintText: 'DD / MM / YY',
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
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                              ),
                              prefixIcon: const Icon(Icons.calendar_month),
                            ),
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-M-d').format(pickedDate);


                                setState(() {
                                  //dobstring = pickedDate.toIso8601String();
                                  dobController.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),
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
                        height: size.height * 0.073,
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
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: Colors.red,strokeAlign: BorderSide.strokeAlignInside),
                              ),
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
                      // SizedBox(height: size.height * 0.0001),
                      Text(
                        '*The password must be minimum 8 characters',
                        style: GoogleFonts.notoSans(
                          fontSize: sizefont * 0.7,
                          // color: Colors.rgba(0, 0, 0, 0.65),
                          // color: Color.fromARGB(0, 0, 0, 1),
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      GestureDetector(
                        onTap: () {
                          if(_formKey.currentState!.validate()){
                            print(fnameController.text);
                            print(lnameController.text);
                            print(phoneController.text);
                            print(dobController.text);
                            print(emailController.text);
                            print(passwordController.text);
                            signUpProvider.UserSignUp(fName:fnameController.text, lName: lnameController.text, DOB: dobController.text, email: emailController.text, number:phoneController.text.trim(), password: passwordController.text.trim(),context: context);
                            // Navigator.of(context).push(MaterialPageRoute(
                            //     builder: (context) => const Login()));

                          }
                          else();

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
                                'Sign up',
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
                ),
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
              margin: EdgeInsets.only(top: size.height * 0.175),
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
