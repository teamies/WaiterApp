import 'dart:convert';

PopularMenuModel popularMenuModelFromJson(String str) =>
    PopularMenuModel.fromJson(json.decode(str));
String popularMenuModelToJson(PopularMenuModel data) =>
    json.encode(data.toJson());

class PopularMenuModel {
  PopularMenuModel({
    this.data,
  });

  PopularMenuModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(PopularMenuData.fromJson(v));
      });
    }
  }
  List<PopularMenuData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

PopularMenuData popularMenuDataFromJson(String str) =>
    PopularMenuData.fromJson(json.decode(str));
String popularMenuDataToJson(PopularMenuData data) =>
    json.encode(data.toJson());

class PopularMenuData {
  PopularMenuData({
    this.id,
    this.name,
    this.slug,
    this.menuNumber,
    this.unitPrice,
    this.discountPrice,
    this.currencyCode,
    this.image,
    this.description,
    this.variations,
    this.options,
  });

  PopularMenuData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'].toString();
    slug = json['slug'].toString();
    menuNumber = json['menu_number'].toString();
    unitPrice = json['unit_price'].toString();
    discountPrice = json['discount_price'].toString();
    currencyCode = json['currency_code'].toString();
    image = json['image'].toString();
    description = json['description'].toString();
    variations = json["variations"] != null
        ? List<dynamic>.from(json["variations"].map((x) => x))
        : [];
    options = json["options"] != null
        ? List<dynamic>.from(json["options"].map((x) => x))
        : [];
  }
  int? id;
  String? name;
  String? slug;
  String? menuNumber;
  String? unitPrice;
  String? discountPrice;
  String? currencyCode;
  String? image;
  String? description;
  List<dynamic>? variations;
  List<dynamic>? options;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['slug'] = slug;
    map['menu_number'] = menuNumber;
    map['unit_price'] = unitPrice;
    map['discount_price'] = discountPrice;
    map['currency_code'] = currencyCode;
    map['image'] = image;
    map['description'] = description;
    map["variations"] = List<dynamic>.from(variations!.map((x) => x));
    map["options"] = List<dynamic>.from(options!.map((x) => x));
    return map;
  }
}
