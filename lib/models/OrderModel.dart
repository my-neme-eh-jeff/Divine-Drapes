class ViewOrder {
  ViewOrder({
    required this.success,
    required this.data,
    required this.productDetails,
  });
  late final bool? success;
  late final List<Data>? data;
  late final List<ProductDetails>? productDetails;
  
  ViewOrder.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    productDetails = List.from(json['ProductDetails']).map((e)=>ProductDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data!.map((e)=>e.toJson()).toList();
    _data['ProductDetails'] = productDetails!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class ProductDetails {
  ProductDetails({
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
  late final String? id;
  late final String? name;
  late final String? description;
  late final String? category;
  late final int? quantity;
  late final List<dynamic> reviews;
  late final int? V;
  late final String updatedAt;
  
  ProductDetails.fromJson(Map<String, dynamic> json){
    cost = Cost.fromJson(json['cost']);
    photo = Photo.fromJson(json['photo']);
    text = Text.fromJson(json['text']);
    color = Color.fromJson(json['color']);
    id = json['id'];
    name = json['name'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    reviews = List.castFrom<dynamic, dynamic>(json['reviews']);
    V = json['_V'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['cost'] = cost.toJson();
    _data['photo'] = photo.toJson();
    _data['text'] = text.toJson();
    _data['color'] = color.toJson();
    _data['id'] = id;
    _data['name'] = name;
    _data['description'] = description;
    _data['category'] = category;
    _data['quantity'] = quantity;
    _data['reviews'] = reviews;
    _data['_V'] = V;
    _data['updatedAt'] = updatedAt;
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
  late final String? id;
  late final String? user;
  late final String? product;
  late final String? paymentStatus;
  late final String? paymentType;
  late final String? orderStatus;
  late final String? createdAt;
  late final String? updatedAt;
  late final int? V;
  
  Data.fromJson(Map<String, dynamic> json){
    photo = Photo.fromJson(json['photo']);
    text = Text.fromJson(json['text']);
    color = Color.fromJson(json['color']);
    id = json['id'];
    user = json['user'];
    product = json['product'];
    paymentStatus = json['paymentStatus'];
    paymentType = json['paymentType'];
    orderStatus = json['orderStatus'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    V = json['_V'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['photo'] = photo.toJson();
    _data['text'] = text.toJson();
    _data['color'] = color.toJson();
    _data['id'] = id;
    _data['user'] = user;
    _data['product'] = product;
    _data['paymentStatus'] = paymentStatus;
    _data['paymentType'] = paymentType;
    _data['orderStatus'] = orderStatus;
    _data['createdAt'] = createdAt;
    _data['updatedAt'] = updatedAt;
    _data['_V'] = V;
    return _data;
  }
}

class Photo {
  Photo({
    required this.isCust,
    required this.picture,
  });
  late final bool isCust;
  late final List<String> picture;
  
  Photo.fromJson(Map<String, dynamic> json){
    isCust = json['isCust'];
    picture = List.castFrom<dynamic, String>(json['picture']);
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
  late final List<String> color;
  
  Color.fromJson(Map<String, dynamic> json){
    isCust = json['isCust'];
    color = List.castFrom<dynamic, String>(json['color']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['isCust'] = isCust;
    _data['color'] = color;
    return _data;
  }
}

class Cost {
  Cost({
    required this.currency,
    required this.value,
  });
  late final String currency;
  late final int? value;
  
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