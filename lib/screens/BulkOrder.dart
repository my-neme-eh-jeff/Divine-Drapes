import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';


import '../consts/constants.dart';

class BulkOrder extends StatefulWidget {
  const BulkOrder({Key? key}) : super(key: key);

  @override
  State<BulkOrder> createState() => _BulkOrderState();
}

class _BulkOrderState extends State<BulkOrder> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController itemController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  final list1 = [
    "St.Xavier's College, Mumbai, (SXC)",
    "D.J Sanghavi, Vile Parle, (DJSCE)",
    "Sardar Patel Institute of Technology, Andheri, (SPIT)",
    "Veermata Jijabai Technological Institute, Matunga, (VJTI)",
    "St. Francis Institute of Technology, Mumbai, (SFIT)"
  ];

  String? value1;
  String ItemName = "";
  File? _selectedImage;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _selectedImage = pickedImageFile;
      });
    } catch (e) {
      // Handle error during image picking
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;
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
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
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
                    "Bulk Order",
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'First Name',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.052,
                        width: screenWidth * 0.39,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            autofocus: false,
                            controller: fnameController,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return ("Please enter your Email ID");
                            //   }
                            //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                            //       .hasMatch(value)) {
                            //     return ("Please Enter a valid Email");
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              fnameController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: fnameController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                      onPressed: () => fnameController.clear(),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.005,
                                  horizontal: screenWidth * 0.03),
                              isDense: true,
                              hintText: 'First name',
                              hintStyle: TextStyle(fontSize: 16),
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Last Name',
                        style: GoogleFonts.notoSans(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.052,
                        width: screenWidth * 0.44,
                        // width: size.width * 0.32,
                        child: Padding(
                          padding: const EdgeInsets.all(0),
                          child: TextFormField(
                            style: TextStyle(fontSize: 16),
                            autofocus: false,
                            controller: lnameController,
                            // validator: (value) {
                            //   if (value!.isEmpty) {
                            //     return ("Please enter your Email ID");
                            //   }
                            //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                            //       .hasMatch(value)) {
                            //     return ("Please Enter a valid Email");
                            //   }
                            //   return null;
                            // },
                            onSaved: (value) {
                              lnameController.text = value!;
                            },
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              suffixIcon: lnameController.text.isEmpty
                                  ? Container(
                                      width: 0,
                                    )
                                  : IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                      onPressed: () => lnameController.clear(),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: screenWidth * 0.005,
                                  horizontal: screenWidth * 0.01),
                              isDense: true,
                              hintText: 'Last name',
                              hintStyle: TextStyle(fontSize: 16),
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
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  Text(
                    'Email',
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  SizedBox(
                    height: size.height * 0.052,
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
                          prefixIcon: const Icon(Icons.email),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
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
                    height: size.height * 0.052,
                    child: Padding(
                      padding: const EdgeInsets.all(0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: sizefont),
                        autofocus: false,
                        controller: phoneController,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter your Email ID");
                        //   }
                        //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        //       .hasMatch(value)) {
                        //     return ("Please Enter a valid Email");
                        //   }
                        //   return null;
                        // },
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
                          prefixIcon: const Icon(Icons.phone),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Company',
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
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: sizefont),
                        autofocus: false,
                        controller: companyController,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter your Email ID");
                        //   }
                        //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        //       .hasMatch(value)) {
                        //     return ("Please Enter a valid Email");
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          companyController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: companyController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: sizefont,
                                  ),
                                  onPressed: () => companyController.clear(),
                                ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.005,
                              horizontal: size.width * 0.03),
                          isDense: true,
                          hintText: 'Enter your company name',
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
                          prefixIcon: const Icon(Icons.business),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Number of units',
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
                        keyboardType: TextInputType.phone,
                        style: TextStyle(fontSize: sizefont),
                        autofocus: false,
                        controller: unitsController,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter your Email ID");
                        //   }
                        //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        //       .hasMatch(value)) {
                        //     return ("Please Enter a valid Email");
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          unitsController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: unitsController.text.isEmpty
                              ? Container(
                                  width: 0,
                                )
                              : IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: sizefont,
                                  ),
                                  onPressed: () => unitsController.clear(),
                                ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.005,
                              horizontal: size.width * 0.03),
                          isDense: true,
                          hintText: 'Enter number of units',
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Item Selected',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: const Text("Select Item:"),
                        value: value1,
                        isExpanded: true,
                        items: list1.map(buildMenuItem).toList(),
                        onChanged: (value) {
                          setState(() {
                            this.value1 = value;
                            ItemName = value!;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Additional Info',
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
                        keyboardType: TextInputType.text,
                        style: TextStyle(fontSize: sizefont),
                        autofocus: false,
                        controller: infoController,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return ("Please enter your Email ID");
                        //   }
                        //   if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                        //       .hasMatch(value)) {
                        //     return ("Please Enter a valid Email");
                        //   }
                        //   return null;
                        // },
                        onSaved: (value) {
                          infoController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          suffixIcon: infoController.text.isEmpty
                              ? Container(
                            width: 0,
                          )
                              : IconButton(
                            icon: Icon(
                              Icons.close,
                              size: sizefont,
                            ),
                            onPressed: () => infoController.clear(),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: size.width * 0.005,
                              horizontal: size.width * 0.03),
                          isDense: true,
                          hintText: 'Additional Info.',
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
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Upload Custom Photo/Logo',
                    style: GoogleFonts.notoSans(
                      fontSize: sizefont,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: size.height * 0.01),
                  InkWell(
                    onTap: () {
                      _pickImage(ImageSource.gallery);
                    },
                    child: Container(
                      height: screenHeight*0.12,
                      width: screenWidth*0.9,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black ,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: _selectedImage == null
                          ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.file_upload_outlined, size: 40),
                          SizedBox(height: 10.0),
                          Text(
                            'Add Photo',
                          ),
                        ],
                      )
                          : Image.file(
                        File(_selectedImage!.path),
                        fit: BoxFit.cover,
                        height: 180.0,
                        width: 180.0,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
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
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) =>
      DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ));
}
