import 'dart:convert';

LoginMOdel loginMOdelFromJson(String str) =>
    LoginMOdel.fromJson(json.decode(str));
String loginMOdelToJson(LoginMOdel data) => json.encode(data.toJson());

class LoginMOdel {
  LoginMOdel({
    this.status,
    this.message,
    this.data,
    this.token,
    this.waiterID,
    this.restaurant,
  });

  LoginMOdel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'].toString();
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    token = json['token'].toString();
    waiterID = json['waiter_id'].toString();
    restaurant = json['restaurant'] != null
        ? LoginRestaurant.fromJson(json['restaurant'])
        : null;
  }
  int? status;
  String? message;
  LoginData? data;
  String? token;
  String? waiterID;
  LoginRestaurant? restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (waiterID != null) {
      map['waiterID'] = waiterID;
    }
    map['token'] = token;
    if (restaurant != null) {
      map['restaurant'] = restaurant?.toJson();
    }
    return map;
  }
}

LoginData dataFromJson(String str) => LoginData.fromJson(json.decode(str));
String dataToJson(LoginData data) => json.encode(data.toJson());

class LoginData {
  LoginData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.username,
    this.image,
    this.address,
    this.status,
    this.applied,
    this.myrole,
    this.mystatus,
  });

  LoginData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    username = json['username'].toString();
    image = json['image'].toString();
    address = json['address'].toString();
    status = int.parse(json['status'].toString());
    applied = int.parse(json['applied'].toString());
    myrole = json['myrole'].toString();
    mystatus = json['mystatus'].toString();
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? username;
  String? image;
  String? address;
  int? status;
  int? applied;
  String? myrole;
  String? mystatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['email'] = email;
    map['phone'] = phone;
    map['username'] = username;
    map['image'] = image;
    map['address'] = address;
    map['status'] = status;
    map['applied'] = applied;
    map['myrole'] = myrole;
    map['mystatus'] = mystatus;
    return map;
  }
}

LoginRestaurant restaurantFromJson(String str) =>
    LoginRestaurant.fromJson(json.decode(str));
String restaurantToJson(LoginRestaurant data) => json.encode(data.toJson());

class LoginRestaurant {
  LoginRestaurant({
    this.id,
    this.name,
  });

  LoginRestaurant.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  int? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
