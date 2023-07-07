class Login {
  Login({
    required this.success,
    required this.data,
    required this.token,
  });
  late final bool success;
  late final Data data;
  late final String token;

  Login.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Data.fromJson(json['data']);
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    _data['token'] = token;
    return _data;
  }
}

class Data {
  Data({
    required this.roles,
    required this.id,
    required this.fName,
    required this.lName,
    required this.DOB,
    required this.email,
    required this.number,
    required this.isVerified,
    required this.cart,
    required this.order,
    required this.reviews,
    required this.tickets,
    required this.refreshToken,
    required this.addressList,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final Roles roles;
  late final String id;
  late final String fName;
  late final String lName;
  late final String DOB;
  late final String email;
  late final int number;
  late final bool isVerified;
  late final List<dynamic> cart;
  late final List<dynamic> order;
  late final List<dynamic> reviews;
  late final List<dynamic> tickets;
  late final List<dynamic> refreshToken;
  late final List<dynamic> addressList;
  late final String createdAt;
  late final String updatedAt;
  late final int V;

  Data.fromJson(Map<String, dynamic> json) {
    roles = Roles.fromJson(json['roles']);
    id = json['_id'];
    fName = json['fName'];
    lName = json['lName'];
    DOB = json['DOB'];
    email = json['email'];
    number = json['number'];
    isVerified = json['isVerified'];
    cart = List.castFrom<dynamic, dynamic>(json['cart']);
    order = List.castFrom<dynamic, dynamic>(json['order']);
    reviews = List.castFrom<dynamic, dynamic>(json['reviews']);
    tickets = List.castFrom<dynamic, dynamic>(json['tickets']);
    refreshToken = List.castFrom<dynamic, dynamic>(json['refreshToken']);
    addressList = List.castFrom<dynamic, dynamic>(json['addressList']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['roles'] = roles.toJson();
    _data['_id'] = id;
    _data['fName'] = fName;
    _data['lName'] = lName;
    _data['DOB'] = DOB;
    _data['email'] = email;
    _data['number'] = number;
    _data['isVerified'] = isVerified;
    _data['cart'] = cart;
    _data['order'] = order;
    _data['reviews'] = reviews;
    _data['tickets'] = tickets;
    _data['refreshToken'] = refreshToken;
    _data['addressList'] = addressList;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    return _data;
  }
}

class Roles {
  Roles({
    required this.User,
  });
  late final int User;

  Roles.fromJson(Map<String, dynamic> json) {
    User = json['User'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['User'] = User;
    return _data;
  }
}
