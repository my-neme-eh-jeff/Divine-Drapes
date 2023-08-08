import 'package:divine_drapes/Provider/Auth/profile_API.dart';
import 'package:divine_drapes/consts/constants.dart';
import 'package:divine_drapes/models/ProfileModel.dart' as data;
import 'package:divine_drapes/models/ProfileModel.dart';
import 'package:divine_drapes/screens/Account.dart';
import 'package:divine_drapes/screens/BulkOrder.dart';
import 'package:divine_drapes/screens/MyOrders.dart';
import 'package:divine_drapes/screens/favourites.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../Provider/Auth/AuthProvider.dart';
import 'package:divine_drapes/Provider/Auth/profile_API.dart';

class EditAddress extends StatefulWidget {
  const EditAddress({super.key});

  @override
  State<EditAddress> createState() => _EditAddressState();
}

class _EditAddressState extends State<EditAddress> {
  bool isLoading = false;
  data.Data? _profile;
  TextEditingController flatcontroller = TextEditingController();
  TextEditingController bldgcontroller = TextEditingController();
  TextEditingController streetcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();
  List<AddressList>? addresses = [];

  Future getProfile() async {
    setState(() {
      isLoading = true;
    });
    _profile = await Profiles().getProfileData();
    addresses = await Profiles().getAddressData();

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getProfile().then((_) {
      flatcontroller.text = addresses?[0].houseNumber.toString() ?? '';
      bldgcontroller.text = addresses?[0].building.toString() ?? '';
      streetcontroller.text = addresses?[0].street.toString() ?? '';
      citycontroller.text = addresses?[0].city.toString() ?? '';
      statecontroller.text = addresses?[0].state.toString() ?? '';
      countrycontroller.text = addresses?[0].country.toString() ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double sizefont = width * 0.05;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        title: Text("Your Addresses",
            style: GoogleFonts.notoSans(
                color: brownColor, fontSize: 26, fontWeight: FontWeight.w700)),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            )),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: cream,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      'Flat / House no.',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: flatcontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your house number',
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
                            prefixIcon: const Icon(Icons.home_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                      // SizedBox(
                      //   width: 15,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      'Building, Company, Apartment',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: bldgcontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your building name ',
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
                            prefixIcon: const Icon(Icons.home_work_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      'Area, Street, Sector',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: streetcontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your street name',
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
                            // prefixIcon: const Icon(Icons.home_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, bottom: 5),
                    child: Text(
                      'Town / City',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: citycontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your city name',
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
                            // prefixIcon: const Icon(Icons.home_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                      // SizedBox(
                      //   width: 15,
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            'State',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, bottom: 5),
                          child: Text(
                            'Country',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: statecontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your state  ',
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
                            // prefixIcon: const Icon(Icons.home_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 1,
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: countrycontroller,
                          decoration: InputDecoration(
                            hintText: 'Enter your country ',
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
                            // prefixIcon: const Icon(Icons.home_work_outlined),
                            // suffixIcon: Icon(Icons.edit),
                            isDense: true,
                          ),
                          validator: MultiValidator([
                            RequiredValidator(errorText: "    " '*Required')
                          ]),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20, bottom: 20),
                        child: InkWell(
                          child: Text('Save Changes',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: brownColor)),
                          onTap: () async {
                            await Profiles().manageAddress(
                                addresses?[0].addressOf,
                                flatcontroller.text.trim(),
                                bldgcontroller.text.trim(),
                                streetcontroller.text.trim(),
                                citycontroller.text.trim(),
                                statecontroller.text.trim(),
                                countrycontroller.text.trim());

                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => MyAccount()));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
