import 'dart:convert';

TableModel tableModelFromJson(String str) =>
    TableModel.fromJson(json.decode(str));
String tableModelToJson(TableModel data) => json.encode(data.toJson());

class TableModel {
  TableModel({
    this.data,
  });

  TableModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TableData.fromJson(v));
      });
    }
  }
  List<TableData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

TableData dataFromJson(String str) => TableData.fromJson(json.decode(str));
String dataToJson(TableData data) => json.encode(data.toJson());

class TableData {
  TableData({
    this.id,
    this.name,
    this.capacity,
    this.status,
    this.restaurantId,
  });

  TableData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'].toString();
    capacity = json['capacity'].toString();
    status = int.parse(json['status'].toString());
    restaurantId = int.parse(json['restaurant_id'].toString());
  }
  int? id;
  String? name;
  String? capacity;
  int? status;
  int? restaurantId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['capacity'] = capacity;
    map['status'] = status;
    map['restaurant_id'] = restaurantId;
    return map;
  }
}
