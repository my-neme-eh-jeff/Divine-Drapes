// class User {
//   User({
//     required this.success,
//     required this.data,
//   });
//   late final bool success;
//   late final Data data;

//   User.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     data = Data.fromJson(json['data']);
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['success'] = success;
//     _data['data'] = data.toJson();
//     return _data;
//   }
// }

// class Data {
//   Data(
//       {required this.fName,
//       required this.lName,
//       required this.DOB,
//       required this.email,
//       required this.number,
//       required this.isVerified,
//       required this.profilePic});
//   late final String fName;
//   late final String lName;
//   late final String DOB;
//   late final String email;
//   late final int number;
//   late final bool isVerified;
//   late final String profilePic;

//   Data.fromJson(Map<String, dynamic> json) {
//     fName = json['fName'];
//     lName = json['lName'];
//     DOB = json['DOB'];
//     email = json['email'];
//     number = json['number'];
//     isVerified = json['isVerified'];
//     profilePic = json['profilePic'];
//   }

//   Map<String, dynamic> toJson() {
//     final _data = <String, dynamic>{};
//     _data['fName'] = fName;
//     _data['lName'] = lName;
//     _data['DOB'] = DOB;
//     _data['email'] = email;
//     _data['number'] = number;
//     _data['isVerified'] = isVerified;
//     _data['profilePic'] = profilePic;
//     return _data;
//   }
// }

class User {
  User({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  User.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.fName,
    required this.lName,
    required this.DOB,
    required this.profilePic,
    required this.email,
    required this.number,
    required this.isVerified,
    required this.addressList,
  });
  late final String fName;
  late final String lName;
  late final String DOB;
  late final String profilePic;
  late final String email;
  late final int number;
  late final bool isVerified;
  late final List<AddressList> addressList;

  Data.fromJson(Map<String, dynamic> json){
    fName = json['fName'];
    lName = json['lName'];
    DOB = json['DOB'];
    profilePic = json['profilePic'];
    email = json['email'];
    number = json['number'];
    isVerified = json['isVerified'];
    addressList = List.from(json['addressList'])
        .map((e) => AddressList.fromJson(e))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['fName'] = fName;
    _data['lName'] = lName;
    _data['DOB'] = DOB;
    _data['profilePic'] = profilePic;
    _data['email'] = email;
    _data['number'] = number;
    _data['isVerified'] = isVerified;
    _data['addressList'] = addressList.map((e) => e.toJson()).toList();
    return _data;
  }
}

class AddressList {
  AddressList({
    required this.addressOf,
    required this.houseNumber,
    required this.building,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.id,
  });
  late final String addressOf;
  late final String houseNumber;
  late final String building;
  late final String street;
  late final String city;
  late final String state;
  late final String country;
  late final String id;

  AddressList.fromJson(Map<String, dynamic> json) {
    addressOf = json['addressOf'];
    houseNumber = json['houseNumber'];
    building = json['building'];
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['addressOf'] = addressOf;
    _data['houseNumber'] = houseNumber;
    _data['building'] = building;
    _data['street'] = street;
    _data['city'] = city;
    _data['state'] = state;
    _data['country'] = country;
    _data['_id'] = id;
    return _data;
  }
}