// ignore: duplicate_ignore
// ignore_for_file: unused_local_variable, avoid_print, implementation_imports, unused_import

import 'package:divine_drapes/consts/constants.dart';
import '../screens/forgotpassword.dart';
import 'package:divine_drapes/screens/signup.dart';
// ignore: unnecessary_import
import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class COD extends StatefulWidget {
  // const COD({super.key});
  const COD({Key? key}) : super(key: key);

  @override
  State<COD> createState() => _CODState();
}

class _CODState extends State<COD> {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  String? selectedOption = 'Select Payment';
  String? selectedState = 'State';
  final ImagePicker _imagePicker = ImagePicker();
  bool isImageSelected = false;
  String? address;
  String? state;
  String? city;
  String? pincode;
  Future<void> _selectImageFromGallery() async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      // Do something with the selected image file (e.g., display it in the UI)
      final File selectedImageFile = File(pickedImage.path);
      setState(() {
        isImageSelected = true;
        // Set selectedImageFile to the chosen image file
      });

      // ... your code here ...
    }
  }

  void saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('address', addressController.text);
    prefs.setString('state', stateController.text);
    prefs.setString('city', cityController.text);
    prefs.setString('pincode', pinController.text);
  }

  void readData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    address = prefs.getString('address');
    state = prefs.getString('state');
    city = prefs.getString('city');
    pincode = prefs.getString('pincode');
    print(address);
    // print(state);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width;
    final List<String> dropdownItems = [
      'COD',
      'Debit Card/Credit Card',
      'Net Banking',
      'Select Payment'
    ];
    List<String> statesOfIndia = [
      'State',
      'Andaman and Nicobar Islands',
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chandigarh',
      'Chhattisgarh',
      'Dadra and Nagar Haveli',
      'Daman and Diu',
      'Delhi',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jammu and Kashmir',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Ladakh',
      'Lakshadweep',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Puducherry',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
    ];

    return Scaffold(
      // backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: darkPurple,
          ), // Custom icon for leading
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        flexibleSpace: Container(
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.0375),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: size.width * 0.12),
                Text(
                  'Divine Drapes',
                  style: GoogleFonts.notoSans(
                    fontSize: sizefont * 0.077,
                    color: darkPurple,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Scrollbar(
        thumbVisibility: true,
        trackVisibility: true,
        radius: const Radius.circular(20),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: 25, top: size.height * 0.0275),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(height: size.height * 0.0275),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          3, // Replace 'itemCount' with the actual number of items
                      itemBuilder: (BuildContext context, int index) {
                        return checkoutItem(index);
                      },
                    ),
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
                        child: DropdownButton<String>(
                          value: selectedOption,
                          onChanged: (String? newValue) {
                            // Perform any action you want when the dropdown value changes
                            setState(() {
                              selectedOption =
                                  newValue; // Update the selected value
                            });
                          },
                          items: dropdownItems.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 17),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: sizefont * 0.039,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          underline:
                              Container(), // Add this line to remove the underline
                          icon: const Icon(
                            Icons
                                .arrow_drop_down, // Remove this line to remove the arrow icon
                            color: Colors
                                .grey, // Add this line to make the arrow transparent
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
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
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Address is required';
                            }
                            return null;
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
                        Container(
                            width: size.width * 0.303,
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
                                        onPressed: () => cityController.clear(),
                                      ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: size.width * 0.005,
                                    horizontal: size.width * 0.03),
                                isDense: true,
                                hintStyle: TextStyle(fontSize: sizefont * 0.04),
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
                        const SizedBox(width: 30),
                        Container(
                          width: size.width * 0.352,
                          height: size.height * 0.05,

                          // child: DropdownButton<String>(
                          //   value: selectedState,
                          //   onChanged: (String? newState) {
                          //     // Perform any action you want when the dropdown value changes
                          //     setState(() {
                          //       selectedState =
                          //           newState; // Update the selected value
                          //     });
                          //   },
                          //   items: statesOfIndia.map((String value1) {
                          //     return DropdownMenuItem<String>(
                          //       value: value1,
                          //       child: Padding(
                          //         padding: const EdgeInsets.symmetric(
                          //             horizontal: 13, vertical: 0),
                          //         child: Text(
                          //           value1,
                          //           overflow: TextOverflow.ellipsis,
                          //           style: TextStyle(
                          //             fontSize: sizefont * 0.039,
                          //             color: Colors.grey,
                          //             fontWeight: FontWeight.w500,
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   }).toList(),
                          //   underline:
                          //       Container(), // Add this line to remove the underline
                          // ),

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
                                      onPressed: () => stateController.clear(),
                                    ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: size.width * 0.005,
                                  horizontal: size.width * 0.03),
                              isDense: true,
                              hintStyle: TextStyle(fontSize: sizefont * 0.04),
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
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 13),
                    Container(
                        width: double.infinity,
                        height: size.height * 0.05,
                        child: TextFormField(
                          controller: pinController,
                          style: TextStyle(fontSize: sizefont * 0.04),
                          autofocus: false,
                          onSaved: (value) {
                            pinController.text = value!;
                          },
                          decoration: InputDecoration(
                            suffixIcon: pinController.text.isEmpty
                                ? Container(
                                    width: 0,
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      size: sizefont * 0.04,
                                    ),
                                    onPressed: () => pinController.clear(),
                                  ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: size.width * 0.005,
                                horizontal: size.width * 0.03),
                            isDense: true,
                            hintStyle: TextStyle(fontSize: sizefont * 0.04),
                            hintText: "Pincode",
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
                    const SizedBox(height: 18),
                    GestureDetector(
                      onTap: () {
                        saveData();
                        readData();
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              title: Row(
                                children: [
                                  Text(
                                    'Saved Address',
                                    style: GoogleFonts.notoSans(
                                      fontSize: sizefont * 0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                      iconSize: size.width * 0.05,
                                      onPressed: () {
                                        Navigator.of(context).pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.black,
                                      ))
                                ],
                              ),
                              content: Container(
                                height: size.height * 0.17,
                                width: size.width * 0.852,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.zero,
                                      child: Text(
                                        '${address!},',
                                        style: GoogleFonts.notoSans(
                                          fontSize: sizefont * 0.033,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${pincode!},',
                                          style: GoogleFonts.notoSans(
                                            fontSize: sizefont * 0.033,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          '${city!},',
                                          style: GoogleFonts.notoSans(
                                            fontSize: sizefont * 0.033,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        Text(
                                          state!,
                                          style: GoogleFonts.notoSans(
                                            fontSize: sizefont * 0.033,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Do you want to use the saved address?',
                                      style: GoogleFonts.notoSans(
                                        fontSize: sizefont * 0.033,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    // SizedBox(height: 11),
                                    const Spacer(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: GoogleFonts.notoSans(
                                              fontSize: sizefont * 0.033,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 80),
                                        GestureDetector(
                                          onTap: () {
                                            // Navigator.of(context).push(
                                            //     MaterialPageRoute(builder: (context) => const COD()));
                                          },
                                          child: Container(
                                            width: size.width * 0.261,
                                            height: size.height * 0.0425,
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(
                                                  160, 30, 134, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  'Yes',
                                                  style: GoogleFonts.notoSans(
                                                    fontSize: sizefont * 0.033,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: size.height * 0.052,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(160, 30, 134, 1),
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
                              'Buy Now',
                              style: GoogleFonts.notoSans(
                                fontSize: sizefont * 0.04,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 18),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget checkoutItem(int index) {
    var size = MediaQuery.of(context).size;
    double sizefont = size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 3),
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
        GestureDetector(
          onTap: _selectImageFromGallery,
          child: Container(
            width: double.infinity,
            height: size.height * 0.05,
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black),
              borderRadius: BorderRadius.circular(5),
            ),
            child: isImageSelected
                ? const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Added Successfully..')],
                  )
                : Row(
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
        ),
        const SizedBox(height: 5),
        Divider(
          color: darkPurple,
          thickness: 2,
        ),
      ],
    );
  }
}
