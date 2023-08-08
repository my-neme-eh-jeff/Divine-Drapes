class AllOrders {
  AllOrders({
    required this.success,
    required this.received,
  });
  late final bool success;
  late final List<Received> received;

  // AllOrders.fromJson(Map<String, dynamic> json){
  //   success = json['success'];
  //   received = List.from(json['received']).map((e)=>Received.fromJson(e)).toList();
  // }
  factory AllOrders.fromJson(Map<dynamic, dynamic> json) {
    return AllOrders(
      success: json['success'],
      received: (json['received'] as List)
          .map((item) => Received.fromJson(item))
          .toList(),
    );
  }


  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['received'] = received.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Received {
  Received({
    required this.photo,
    required this.text,
    required this.color,
    required this.id,
    required this.user,
    required this.product,
    required this.paymentStatus,
    required this.paymentType,
    required this.orderStatus,
    required this.V,
  });
  late final Photo photo;
  late final Text text;
  late final Color color;
  late final String id;
  late final User user;
  late final Product product;
  late final String paymentStatus;
  late final String paymentType;
  late final String orderStatus;
  late final int V;

  Received.fromJson(Map<String, dynamic> json){
    photo = Photo.fromJson(json['photo']);
    text = Text.fromJson(json['text']);
    color = Color.fromJson(json['color']);
    id = json['_id'];
    user = User.fromJson(json['user']);
    product = Product.fromJson(json['product']);
    paymentStatus = json['paymentStatus'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo.toJson();
    _data['text'] = text.toJson();
    _data['color'] = color.toJson();
    _data['_id'] = id;
    _data['user'] = user.toJson();
    _data['product'] = product.toJson();
    _data['paymentStatus'] = paymentStatus;
    _data['paymentType'] = paymentType;
    _data['orderStatus'] = orderStatus;
    _data['__v'] = V;
    return _data;
  }
}

class Photo {
  Photo({
    required this.isCust,
    required this.picture,
  });
  late final bool isCust;
  late final List<dynamic> picture;

  Photo.fromJson(Map<String, dynamic> json){
    isCust = json['isCust'];
    picture = List.castFrom<dynamic, dynamic>(json['picture']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isCust'] = isCust;
    _data['picture'] = picture;
    return _data;
  }
}

class Text {
  Text({
    required this.isCust,
    required this.text,
  });
  late final bool isCust;
  late final String text;

  Text.fromJson(Map<String, dynamic> json){
    isCust = json['isCust'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isCust'] = isCust;
    _data['text'] = text;
    return _data;
  }
}

class Color {
  Color({
    required this.isCust,
    required this.color,
  });
  late final bool isCust;
  late final List<dynamic> color;

  Color.fromJson(Map<String, dynamic> json){
    isCust = json['isCust'];
    color = List.castFrom<dynamic, dynamic>(json['color']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isCust'] = isCust;
    _data['color'] = color;
    return _data;
  }
}

class User {
  User({
    required this.roles,
    required this.id,
    required this.fName,
    required this.lName,
    required this.DOB,
    required this.email,
    required this.number,
    required this.password,
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
    required this.profilePic,
  });
  late final Roles roles;
  late final String id;
  late final String fName;
  late final String lName;
  late final String DOB;
  late final String email;
  late final int number;
  late final String password;
  late final bool isVerified;
  late final List<String> cart;
  late final List<String> order;
  late final List<dynamic> reviews;
  late final List<dynamic> tickets;
  late final List<String> refreshToken;
  late final List<AddressList> addressList;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  late final String profilePic;

  User.fromJson(Map<String, dynamic> json){
    roles = Roles.fromJson(json['roles']);
    id = json['_id'];
    fName = json['fName'];
    lName = json['lName'];
    DOB = json['DOB'];
    email = json['email'];
    number = json['number'];
    password = json['password'];
    isVerified = json['isVerified'];
    cart = List.castFrom<dynamic, String>(json['cart']);
    order = List.castFrom<dynamic, String>(json['order']);
    reviews = List.castFrom<dynamic, dynamic>(json['reviews']);
    tickets = List.castFrom<dynamic, dynamic>(json['tickets']);
    refreshToken = List.castFrom<dynamic, String>(json['refreshToken']);
    addressList = List.from(json['addressList']).map((e)=>AddressList.fromJson(e)).toList();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
    profilePic = json['profilePic'];
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
    _data['password'] = password;
    _data['isVerified'] = isVerified;
    _data['cart'] = cart;
    _data['order'] = order;
    _data['reviews'] = reviews;
    _data['tickets'] = tickets;
    _data['refreshToken'] = refreshToken;
    _data['addressList'] = addressList.map((e)=>e.toJson()).toList();
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['__v'] = V;
    _data['profilePic'] = profilePic;
    return _data;
  }
}

class Roles {
  Roles({
    required this.User,
  });
  late final int User;

  Roles.fromJson(Map<String, dynamic> json){
    User = json['User'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['User'] = User;
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

  AddressList.fromJson(Map<String, dynamic> json){
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

class Product {
  Product({
    required this.cost,
    required this.photo,
    required this.text,
    required this.color,
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.quantity,
    required this.reviews,
    required this.V,
    required this.updatedAt,
  });
  late final Cost cost;
  late final Photo photo;
  late final Text text;
  late final Color color;
  late final String id;
  late final String name;
  late final String description;
  late final String category;
  late final int quantity;
  late final List<dynamic> reviews;
  late final int V;
  late final String updatedAt;

  Product.fromJson(Map<String, dynamic> json){
    cost = Cost.fromJson(json['cost']);
    photo = Photo.fromJson(json['photo']);
    text = Text.fromJson(json['text']);
    color = Color.fromJson(json['color']);
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    reviews = List.castFrom<dynamic, dynamic>(json['reviews']);
    V = json['__v'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cost'] = cost.toJson();
    _data['photo'] = photo.toJson();
    _data['text'] = text.toJson();
    _data['color'] = color.toJson();
    _data['_id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['category'] = category;
    _data['quantity'] = quantity;
    _data['reviews'] = reviews;
    _data['__v'] = V;
    _data['updatedAt'] = updatedAt;
    return _data;
  }
}

class Cost {
  Cost({
    required this.currency,
    required this.value,
  });
  late final String currency;
  late final int value;

  Cost.fromJson(Map<String, dynamic> json){
    currency = json['currency'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['currency'] = currency;
    _data['value'] = value;
    return _data;
  }
}