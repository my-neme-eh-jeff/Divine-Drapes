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
  });
  late final String fName;
  late final String lName;
  late final String DOB;
  late final String profilePic;
  late final String email;
  late final int number;
  late final bool isVerified;

  Data.fromJson(Map<String, dynamic> json){
    fName = json['fName'];
    lName = json['lName'];
    DOB = json['DOB'];
    profilePic = json['profilePic'];
    email = json['email'];
    number = json['number'];
    isVerified = json['isVerified'];
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
    return _data;
  }
}