import 'dart:convert';

CategoryModel categoryModelFromJson(String str) =>
    CategoryModel.fromJson(json.decode(str));
String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.data,
  });

  CategoryModel.fromJson(dynamic json) {
    data =
        json['data'] != null ? CategoryListData.fromJson(json['data']) : null;
  }
  CategoryListData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

CategoryListData dataFromJson(String str) =>
    CategoryListData.fromJson(json.decode(str));
String dataToJson(CategoryListData data) => json.encode(data.toJson());

class CategoryListData {
  CategoryListData({
    this.status,
    this.data,
  });

  CategoryListData.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryData.fromJson(v));
      });
    }
  }
  int? status;
  List<CategoryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

CategoryData categoryDataFromJson(String str) =>
    CategoryData.fromJson(json.decode(str));
String categoryDataToJson(CategoryListData data) => json.encode(data.toJson());

class CategoryData {
  CategoryData({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.image,
  });

  CategoryData.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'].toString();
    slug = json['slug'].toString();
    description = json['description'].toString();
    image = json['image'].toString();
  }
  int? id;
  String? title;
  String? slug;
  String? description;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['slug'] = slug;
    map['description'] = description;
    map['image'] = image;
    return map;
  }
}
