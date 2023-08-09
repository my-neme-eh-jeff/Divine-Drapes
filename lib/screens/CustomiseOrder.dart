import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../Provider/Auth/AuthProvider.dart';
import '../consts/constants.dart';

class CustomiseOrder extends StatefulWidget {
  final String productName;

  CustomiseOrder({
    Key? key,
    required this.productName,
  }) : super(key: key);

  @override
  _CustomiseOrderState createState() => _CustomiseOrderState();
}

class _CustomiseOrderState extends State<CustomiseOrder> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController photo1Controller = TextEditingController();
  TextEditingController photo2Controller = TextEditingController();

  static const String authTokenKey = 'auth_token';




  Future<void> addProduct() async {
    final url = Uri.parse('https://divine-drapes.onrender.com/admin/addProduct');
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(authTokenKey);
    print(token);
    if (token == null) {
      print('Authentication token is missing');
      return;
    }

    // Show the circular progress indicator
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing the dialog by tapping outside
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
        body: jsonEncode({
                "name": nameController.text,
                "description": descriptionController.text,
                "category": categoryController.text,
                "quantity": int.parse(quantityController.text),
                "cost": {
                  "currency": currencyController.text,
                  "value": int.parse(valueController.text),
                },
                "photo": {"isCust": true},
                "text": {"isCust": true},
                "color": {
                  "isCust": true,
                  "color": ["red", "blue", "green"],
                },
              }),
    );

    // Hide the circular progress indicator
    Navigator.pop(context);

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Product added successfully
      // Handle the response or show a success message
      print('Product added successfully');
      print('Response: ${response.body}');
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      String productId = responseMap['product']['_id'];
      print(productId);

      // Show a success message
      Fluttertoast.showToast(
        msg: "Product added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      uploadImages(productId);
      setState(() {
        nameController.clear();
        descriptionController.clear();
        categoryController.clear();
        quantityController.clear();
        currencyController.clear();
        valueController.clear();
      });
    } else {
      // Product addition failed
      // Handle the error or show an error message
      Fluttertoast.showToast(
        msg: "Failed to add product!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print(response.statusCode);
      print('Response: ${response.body}');
    }
  }


  Future<void> uploadImages(String productId) async {
    final url = Uri.parse('https://divine-drapes.onrender.com/admin/addImages');
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

    request.fields.addAll({'id': productId!});

    if (_selectedImage != null) {
      String fileName = _selectedImage!.path.split('/').last;
      String extension = fileName.split('.').last;

      Directory tempDir = await getTemporaryDirectory();
      File newFile = File('${tempDir.path}/$productId.$extension');

      await _selectedImage!.copy(newFile.path);

      request.files.add(await http.MultipartFile.fromPath(
        'files',
        newFile.path,
        contentType: MediaType('image', extension),
      ));

      // Clear the selected image after successful upload
      setState(() {
        _selectedImage = null;
      });
    }

    http.StreamedResponse response = await request.send();
    String responseBody = await response.stream.bytesToString();
    print('Response: $responseBody');

    if (response.statusCode == 200) {
      print('Image added successfully!');
    } else {
      print("Image was not added!");
      print(response.reasonPhrase);
    }
  }


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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          child: Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.03625),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: screenWidth * 0.075),
                Text(
                  'Divine Drapes',
                  style: GoogleFonts.notoSans(
                    // fontSize: height * 0.035,
                    fontSize: screenWidth * 0.075,
                    color: darkPurple,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                      onTap: (){
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => const Home()));
                        Navigator.of(context).pop();
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(width: 2,),
                  Text("Customise " + widget.productName ,style: GoogleFonts.notoSans(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Add Custom Text',
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
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: sizefont),
                    autofocus: false,
                    controller: nameController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter the text!");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      nameController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: nameController.text.isEmpty
                          ? Container(
                        width: 0,
                      )
                          : IconButton(
                        icon: Icon(
                          Icons.close,
                          size: sizefont,
                        ),
                        onPressed: () => nameController.clear(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: 'Enter the Text',
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

                    ),
                  ),
                ),
              ),          
              SizedBox(height: size.height * 0.01),
              Text(
                'Add Custom Color',
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
                    keyboardType: TextInputType.name,
                    style: TextStyle(fontSize: sizefont),
                    autofocus: false,
                    controller: categoryController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter product color");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      categoryController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: categoryController.text.isEmpty
                          ? Container(
                        width: 0,
                      )
                          : IconButton(
                        icon: Icon(
                          Icons.close,
                          size: sizefont,
                        ),
                        onPressed: () => categoryController.clear(),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: 'Enter the Color',
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

                    ),
                  ),
                ),
              ),                            
              SizedBox(height: size.height * 0.02),
              Text(
                'Upload Custom Photo',
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
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
              ),

              SizedBox(height: 16),
              SizedBox(height: size.height * 0.02),
              InkWell(
                onTap: (){
                  // addProduct();
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
                        'Place Order',
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
    );
  }
}
