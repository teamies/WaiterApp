// To parse this JSON data, do
//
//     final searchMenu = searchMenuFromJson(jsonString);

import 'dart:convert';

SearchMenuModel searchMenuModelFromJson(String str) =>
    SearchMenuModel.fromJson(json.decode(str));

String searchMenuModelToJson(SearchMenuModel data) =>
    json.encode(data.toJson());

class SearchMenuModel {
  SearchMenuModel({
    this.data,
  });

  MenuData? data;

  factory SearchMenuModel.fromJson(Map<String, dynamic> json) =>
      SearchMenuModel(
        data: MenuData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class MenuData {
  MenuData({
    this.status,
    this.data,
  });

  int? status;
  List<MenuDetail>? data;

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
        status: json["status"],
        data: List<MenuDetail>.from(
            json["data"].map((x) => MenuDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class MenuDetail {
  MenuDetail({
    this.id,
    this.name,
    this.qty,
    this.slug,
    this.menuNumber,
    this.unitPrice,
    this.discountPrice,
    this.currencyCode,
    this.image,
    this.description,
    this.variations,
    this.variationId,
    this.variationName,
    this.options,
  });

  int? id;
  int? qty;
  String? name;
  String? slug;
  String? menuNumber;
  String? unitPrice;
  String? discountPrice;
  String? currencyCode;
  String? image;
  String? description;
  String? variationId;
  String? variationName;
  List<dynamic>? variations;
  List<dynamic>? options;

  factory MenuDetail.fromJson(Map<String, dynamic> json) => MenuDetail(
        id: json["id"],
        name: json["name"].toString(),
        qty: json["qty"] ?? 1,
        slug: json["slug"].toString(),
        menuNumber: json["menu_number"] ?? json["menuNumber"].toString(),
        unitPrice: json["unit_price"] ?? json["unitPrice"].toString(),
        discountPrice:
            json["discount_price"] ?? json["discountPrice"].toString(),
        currencyCode: json["currency_code"] ?? json["currencyCode"].toString(),
        image: json["image"].toString(),
        variationId: json["variationId"] ?? '',
        variationName: json["variationName"] ?? '',
        description: json["description"].toString(),
        variations: json["variations"] != null
            ? List<dynamic>.from(json["variations"].map((x) => x))
            : [],
        options: json["options"] != null
            ? List<dynamic>.from(json["options"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "qty": qty,
        "slug": slug,
        "menu_number": menuNumber,
        "unit_price": unitPrice,
        "discount_price": discountPrice,
        "currency_code": currencyCode,
        "image": image,
        "variationId": variationId,
        "variationName": variationName,
        "description": description,
        "variations": List<dynamic>.from(variations!.map((x) => x)),
        "options": List<dynamic>.from(options!.map((x) => x)),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
