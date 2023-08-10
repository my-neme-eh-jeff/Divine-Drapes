import 'dart:io';
import 'dart:math';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
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

class UpdateProductPage extends StatefulWidget {
  final String id;
  final String image;
  final String desc;
  var cost;
  final String name;
  final String category;
  final int quantity;
  UpdateProductPage({
    Key? key,
    required this.id,
    required this.image,
    required this.desc,
    required this.cost,
    required this.name,
    required this.category,
    required this.quantity,
  }) : super(key: key);
  @override
  _UpdateProductPageState createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController currencyController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController photo1Controller = TextEditingController();
  TextEditingController photo2Controller = TextEditingController();

  static const String authTokenKey = 'auth_token';

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    descriptionController.text = widget.desc;
    categoryController.text = widget.category;
    quantityController.text = widget.quantity.toString();
    currencyController.text = 'INR';
    valueController.text = widget.cost.value.toString();
  }

  Future<void> updateProduct() async {
    final url =
        Uri.parse('https://divine-drapes.onrender.com/admin/updateProduct');
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
      barrierDismissible:
          false, // Prevent closing the dialog by tapping outside
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    final response = await http.patch(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "id": widget.id,
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
      print('Product updated successfully');
      print('Response: ${response.body}');
      // Map<String, dynamic> responseMap = jsonDecode(response.body);
      // String productId = responseMap['product']['_id'];
      // print(productId);
      updateImage(widget.id);
      // Show a success message
      Fluttertoast.showToast(
        msg: "Product updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );

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
        msg: "Failed to update product!",
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
  // Future<void> updateProduct() async {
  //   final url = Uri.parse('https://divine-drapes.onrender.com/admin/updateProduct');
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString(authTokenKey);
  //   print(token);
  //   if (token == null) {
  //     print('Authentication token is missing');
  //     return;
  //   }
  //
  //   // Show the circular progress indicator
  //   showDialog(
  //     context: context,
  //     barrierDismissible: false, // Prevent closing the dialog by tapping outside
  //     builder: (context) => Center(
  //       child: CircularProgressIndicator(),
  //     ),
  //   );
  //
  //   // Create a new http.MultipartRequest
  //   var request = http.MultipartRequest('PATCH', url);
  //
  //   // Add the authorization header
  //   request.headers['Authorization'] = 'Bearer $token';
  //
  //   // Add the product data
  //   request.fields['id'] = widget.id;
  //   request.fields['name'] = nameController.text;
  //   request.fields['description'] = descriptionController.text;
  //   request.fields['category'] = categoryController.text;
  //   request.fields['quantity'] = int.parse(quantityController.text).toString();
  //   request.fields['cost[currency]'] = currencyController.text;
  //   request.fields['cost[value]'] = int.parse(valueController.text).toString();
  //   request.fields['photo[isCust]'] = 'true';
  //   request.fields['text[isCust]'] = 'true';
  //   request.fields['color[isCust]'] = 'true';
  //   request.fields['color[color]'] = '["red", "blue", "green"]';
  //
  //   // Handle the selected image, if available
  //   if (_selectedImage != null) {
  //     String fileName = _selectedImage!.path.split('/').last;
  //     String extension = fileName.split('.').last;
  //
  //     Directory tempDir = await getTemporaryDirectory();
  //     File newFile = File('${tempDir.path}/$fileName');
  //
  //     await _selectedImage!.copy(newFile.path);
  //
  //     request.files.add(await http.MultipartFile.fromPath(
  //       'files',
  //       newFile.path,
  //       contentType: MediaType('image', extension),
  //     ));
  //   }
  //   else
  //     {
  //       print("Image is null");
  //     }
  //
  //   // Send the request and get the response
  //   final response = await request.send();
  //
  //   // Hide the circular progress indicator
  //   Navigator.pop(context);
  //
  //   if (response.statusCode == 200 || response.statusCode == 201) {
  //     print('Product updated successfully');
  //     print('Response: ${await response.stream.bytesToString()}');
  //
  //     // Show a success message
  //     Fluttertoast.showToast(
  //       msg: "Product updated successfully!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.green,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //
  //     setState(() {
  //       nameController.clear();
  //       descriptionController.clear();
  //       categoryController.clear();
  //       quantityController.clear();
  //       currencyController.clear();
  //       valueController.clear();
  //     });
  //   } else {
  //     // Product update failed
  //     // Handle the error or show an error message
  //     Fluttertoast.showToast(
  //       msg: "Failed to update product!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 3,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0,
  //     );
  //     print('Response status: ${response.statusCode}');
  //     print('Response: ${await response.stream.bytesToString()}');
  //   }
  // }

  Future<void> updateImage(String productId) async {
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
      print('Image added successfully!!!!!!!!!!!!!!!!!!!!!!!!!!');
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
    final logoutProvider = Provider.of<AuthProvider>(context, listen: false);

    var size = MediaQuery.of(context).size;
    double sizefont = size.width * 0.044;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Column(
            children: [
              SizedBox(
                height: 50, // Set the desired height
                width: 200, // Set the desired width
                child: InkWell(
                  onTap: () {
                    logoutProvider.Logout(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: whiteColor,
                      border: Border.all(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.circular(5),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Log out",
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.logout,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: whiteColor,
        title: Text("Divine Drapes",
            style: GoogleFonts.notoSans(
                color: darkPurple, fontSize: 28, fontWeight: FontWeight.w700)),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back)),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Update Product",
                    style: GoogleFonts.notoSans(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Text(
                'Product Name',
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
                        return ("Please enter your Product name");
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
                      hintText: "Enter product name",
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Product Description',
                style: GoogleFonts.notoSans(
                  fontSize: sizefont,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                height: size.height * 0.1,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    maxLines: 3,
                    style: TextStyle(fontSize: sizefont),
                    autofocus: false,
                    controller: descriptionController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter your Product Description");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      descriptionController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: descriptionController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: sizefont,
                              ),
                              onPressed: () => descriptionController.clear(),
                            ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: "Enter product desc.",
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Product Category',
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
                        return ("Please enter product category");
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
                      hintText: "Product category",
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Product Quantity',
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: sizefont),
                    autofocus: false,
                    controller: quantityController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter product quantity");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      quantityController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: quantityController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: sizefont,
                              ),
                              onPressed: () => quantityController.clear(),
                            ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: "Enter quantity",
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Curreny',
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
                    controller: currencyController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter Currency");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      currencyController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: currencyController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: sizefont,
                              ),
                              onPressed: () => currencyController.clear(),
                            ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: 'INR',
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Product Price',
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: sizefont),
                    autofocus: false,
                    controller: valueController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Please enter product price");
                      }
                      // if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9,-]+.[a-z]")
                      //     .hasMatch(value)) {
                      //   return ("Please Enter a valid Email");
                      // }
                      return null;
                    },
                    onSaved: (value) {
                      valueController.text = value!;
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      suffixIcon: valueController.text.isEmpty
                          ? Container(
                              width: 0,
                            )
                          : IconButton(
                              icon: Icon(
                                Icons.close,
                                size: sizefont,
                              ),
                              onPressed: () => valueController.clear(),
                            ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: size.width * 0.005,
                          horizontal: size.width * 0.03),
                      isDense: true,
                      hintText: "Enter product price",
                      hintStyle: TextStyle(fontSize: sizefont * 0.8),
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Colors.red,
                            strokeAlign: BorderSide.strokeAlignInside),
                      ),
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
                  height: screenHeight * 0.12,
                  width: screenWidth * 0.9,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  padding: const EdgeInsets.all(10.0),
                  child: _selectedImage == null
                      ? Image(
                          image: (widget.image == "assets/Vector.png")
                              ? AssetImage(widget.image)
                              : NetworkImage(widget.image) as ImageProvider)
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
                onTap: () {
                  updateProduct();
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
                        'Update Product',
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
