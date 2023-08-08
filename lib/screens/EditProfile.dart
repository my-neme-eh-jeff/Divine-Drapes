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

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  data.Data? _profile;
  String? dobString;
  bool isLoading = false;
  List<AddressList>? addresses = [];

  final _formkey = GlobalKey<FormState>();
  TextEditingController fnamecontroller = TextEditingController();
  TextEditingController lnamecontroller = TextEditingController();
  TextEditingController flatcontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController numbercontroller = TextEditingController();
  TextEditingController bldgcontroller = TextEditingController();
  TextEditingController streetcontroller = TextEditingController();
  TextEditingController citycontroller = TextEditingController();
  TextEditingController statecontroller = TextEditingController();
  TextEditingController countrycontroller = TextEditingController();

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
      fnamecontroller.text = _profile?.fName ?? '';
      lnamecontroller.text = _profile?.lName ?? '';
      dobcontroller.text = _profile?.DOB ?? '';
      numbercontroller.text = _profile?.number.toString() ?? '';
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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          title: Text("Divine Drapes",
              style: GoogleFonts.notoSans(
                  color: darkPurple,
                  fontSize: 28,
                  fontWeight: FontWeight.w700)),
          elevation: 0.0,
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
                    Row(
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                            )),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Edit Profile",
                          style: GoogleFonts.notoSans(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: width * 0.25,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage('${_profile?.profilePic}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: fnamecontroller,
                            decoration: InputDecoration(
                              hintText: 'Enter your new first name',
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
                              prefixIcon: const Icon(Icons.person_outline),
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
                            controller: lnamecontroller,
                            decoration: InputDecoration(
                              hintText: 'Enter your new last name',
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
                              prefixIcon: const Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
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
                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              controller: numbercontroller,
                              decoration: InputDecoration(
                                hintText: 'Enter your new number',
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
                                prefixIcon: const Icon(Icons.phone),
                                // suffixIcon: Icon(Icons.edit),
                                isDense: true,
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: "   " '*Required'),
                                PatternValidator(r'^[0-9]+$',
                                    errorText: 'Enter correct number'),
                                MaxLengthValidator(10,
                                    errorText: 'Enter a valid number'),
                                MinLengthValidator(10,
                                    errorText: 'Enter a valid number'),
                              ])),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            keyboardType: TextInputType.datetime,
                            controller: dobcontroller,
                            decoration: InputDecoration(
                              hintText: 'DD/MM/YYYY',
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
                              prefixIcon: const Icon(Icons.calendar_month),
                              // suffixIcon: Icon(Icons.edit),
                              isDense: true,
                            ),
                            readOnly: true,
                            //set it true, so that user will not able to edit text
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  //DateTime.now() - not to allow to choose before today.
                                  lastDate: DateTime(2100));

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat.yMMMMd().format(pickedDate);

                                setState(() {
                                  dobString = pickedDate.toString();
                                  dobcontroller.text = formattedDate;
                                });
                              } else {}
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
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
                        SizedBox(
                          width: 15,
                        ),
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
                    const SizedBox(
                      height: 30,
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
                        SizedBox(
                          width: 15,
                        ),
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
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Expanded(
                          flex: 1,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: InkWell(
                                child: Text('Submit',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                        color: brownColor)),
                                onTap: () async {
                                  int contactNumber =
                                      int.parse(numbercontroller.text.trim());

                                  await Profiles().editProfileData(
                                      fnamecontroller.text.trim(),
                                      lnamecontroller.text.trim(),
                                      numbercontroller.text.trim(),
                                      dobcontroller.text.trim(),
                                      null);

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
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
  }
}
