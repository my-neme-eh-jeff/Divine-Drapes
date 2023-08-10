import 'dart:io';
import 'package:divine_drapes/screens/EditProfile.dart';
import 'package:divine_drapes/screens/HomePage.dart';
import 'package:divine_drapes/screens/YourAddress.dart';
import 'package:http/http.dart' as http;
import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:divine_drapes/screens/MyOrders.dart';
import 'package:divine_drapes/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Provider/Auth/AuthProvider.dart';
import '../widgets/shimmer_widget.dart';

class MyAccount extends StatefulWidget {
  MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  data.Data? _profile;
  String? fname;
  String? value1;
  String ItemName = "";
  File? _selectedImage;
  String? newURL;
  static const String authTokenKey = 'auth_token';

  Future<void> uploadpfp(File _selectedImage) async {
    final url = Uri.parse('https://divine-drapes.onrender.com/user/profilePic');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);

    if (token == null) {
      print('Authentication token is missing');
      return;
    }

    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.MultipartRequest('POST', url);
    request.headers.addAll(headers);

    if (_selectedImage != null) {
      String fileName = _selectedImage.path.split('/').last;
      String extension = fileName.split('.').last;

      Directory tempDir = await getTemporaryDirectory();
      File newFile = File('${tempDir.path}/$fileName');

      await _selectedImage.copy(newFile.path);

      request.files.add(await http.MultipartFile.fromPath(
        'file',
        newFile.path,
        contentType: MediaType('image', extension),
      ));
    } else {
      print("Image is null");
    }

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print('Response: $responseBody');

    if (response.statusCode == 200) {
      print('Image added successfully!');
      setState(() {
        // Navigator.pushReplacement(
        //         context,
        //         MaterialPageRoute(builder: (context) => HomePage()),
        //       );
      });
    } else {
      print("Image was not added!");
      print(response.reasonPhrase);
    }
  }

  Future getProfile() async {
    _profile = await Profiles().getProfileData();
    print(_profile!.lName);
    // setState(() {
    //   // Trigger a rebuild after fetching the profile data
    // });
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;

      final pickedImageFile = File(pickedImage.path);
      setState(() {
        _selectedImage = pickedImageFile;
      });
      uploadpfp(_selectedImage!);
      if (_selectedImage == null) {
        print("IsNull");
      }
    } catch (e) {
      // Handle error during image picking
      print('Error picking image: $e');
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget buildShimmer() => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              ShimmerWidget.rectangular(
                  width: screenWidth * 0.23, height: screenHeight * 0.023),
              SizedBox(
                height: screenHeight * 0.025,
              ),
              Transform.translate(
                offset: Offset(-20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ShimmerWidget.circular(
                        width: screenWidth * 0.34, height: screenWidth * 0.34),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ShimmerWidget.rectangular(
                            width: screenWidth * 0.25,
                            height: screenHeight * 0.023),
                        SizedBox(
                          height: 18,
                        ),
                        ShimmerWidget.rectangular(
                            width: screenWidth * 0.38,
                            height: screenHeight * 0.021),
                        SizedBox(
                          height: 4,
                        ),
                        ShimmerWidget.rectangular(
                            width: screenWidth * 0.32,
                            height: screenHeight * 0.021)
                      ],
                    )
                  ],
                ),
              ),
              Transform.translate(
                offset: Offset(-10, 0),
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
                                  width: screenWidth * 0.7,
                                  height: screenHeight * 0.048)
                            ],
                          ));
                    }),
              ),
            ],
          ),
        );

    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);

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
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
              future: getProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return buildShimmer();
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Account",
                        style: GoogleFonts.notoSans(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Stack(children: [
                            Container(
                              height: screenWidth * 0.33,
                              width: screenWidth * 0.33,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: (_profile!.profilePic.isEmpty)
                                      ? NetworkImage(
                                          "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/446b1af0-e6ba-4b0f-a9de-6ae6d3ed27a3/dfjhqn3-23d30b9d-16e3-42b6-aa12-e010a3999ef6.png/v1/fill/w_736,h_736,q_80,strp/satoru_gojo_aesthetic_pfp_by_harvester0fs0uls_dfjhqn3-fullview.jpg?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9NzM2IiwicGF0aCI6IlwvZlwvNDQ2YjFhZjAtZTZiYS00YjBmLWE5ZGUtNmFlNmQzZWQyN2EzXC9kZmpocW4zLTIzZDMwYjlkLTE2ZTMtNDJiNi1hYTEyLWUwMTBhMzk5OWVmNi5wbmciLCJ3aWR0aCI6Ijw9NzM2In1dXSwiYXVkIjpbInVybjpzZXJ2aWNlOmltYWdlLm9wZXJhdGlvbnMiXX0.F7_Ce5Ih1dhahsCnvFHRZgivj_8AByd9ZYHS3Ju0aws")
                                      : NetworkImage(_profile!.profilePic)
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 20,
                              right: 0,
                              child: GestureDetector(
                                onTap: () async {
                                  await _pickImage(ImageSource.gallery);
                                },
                                child: CircleAvatar(
                                  backgroundColor: cream,
                                  // Customize the background color of the camera icon.
                                  radius: 18,
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors
                                        .black, // Customize the color of the camera icon.
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        _profile?.fName ?? '',
                                        style: GoogleFonts.notoSans(
                                            fontSize: 18,
                                            color: brownColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text(
                                        _profile?.lName ?? '',
                                        style: GoogleFonts.notoSans(
                                            fontSize: 18,
                                            color: brownColor,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit_outlined,
                                      color: Colors.black,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfile()));
                                    },
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                // "abc@gmail.com",
                                _profile?.email ?? '',
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              ),
                              Text(
                                _profile?.number.toString() ?? '',
                                style: GoogleFonts.notoSans(
                                    fontSize: 15, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const MyOrders()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "My Orders",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const Favourites()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Favourites",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BulkOrder()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Bulk Order",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const address()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Manage Address",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_right_alt_outlined,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: InkWell(
                          onTap: () {
                            // logoutProvider.Logout(context: context);
                            _showLogoutConfirmationDialog(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: whiteColor,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: Offset(2, 2),
                                  )
                                ]),
                            height: screenHeight * 0.05,
                            width: screenWidth * 0.7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Log out",
                                    style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.logout,
                                    color: Colors.red,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }
              })),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          child: AlertDialog(
            title: Text("Log Out"),
            content: Text(
              "Are you sure you want to log out?",
              style: TextStyle(
                color: brownColor,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  // Navigator.pop(context);

                  Provider.of<AuthProvider>(context, listen: false)
                      .Logout(context: context);
                },
                child: Container(
                  width: 70,
                  height: 40,
                  decoration: BoxDecoration(
                    color: cream,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
