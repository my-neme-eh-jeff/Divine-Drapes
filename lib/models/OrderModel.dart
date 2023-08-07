class OrderModel {
  OrderModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final List<Data> data;
  
  OrderModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.photo,
    required this.text,
    required this.color,
    required this.id,
    required this.user,
    required this.product,
    required this.paymentStatus,
    required this.paymentType,
    required this.orderStatus,
    required this.createdAt,
    required this.updatedAt,
    required this.V,
  });
  late final Photo photo;
  late final Text text;
  late final Color color;
  late final String id;
  late final String user;
  late final String product;
  late final String paymentStatus;
  late final String paymentType;
  late final String orderStatus;
  late final String createdAt;
  late final String updatedAt;
  late final int V;
  
  Data.fromJson(Map<String, dynamic> json){
    photo = Photo.fromJson(json['photo']);
    text = Text.fromJson(json['text']);
    color = Color.fromJson(json['color']);
    id = json['_id'];
    user = json['user'];
    product = json['product'];
    paymentStatus = json['paymentStatus'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo.toJson();
    _data['text'] = text.toJson();
    _data['color'] = color.toJson();
    _data['_id'] = id;
    _data['user'] = user;
    _data['product'] = product;
    _data['paymentStatus'] = paymentStatus;
    _data['paymentType'] = paymentType;
    _data['orderStatus'] = orderStatus;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
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