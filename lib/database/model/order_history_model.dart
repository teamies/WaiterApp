import 'dart:convert';

OrderHistoryModel orderHistoryModelFromJson(String str) =>
    OrderHistoryModel.fromJson(json.decode(str));
String orderHistoryModelToJson(OrderHistoryModel data) =>
    json.encode(data.toJson());

class OrderHistoryModel {
  OrderHistoryModel({
    this.status,
    this.data,
  });

  OrderHistoryModel.fromJson(dynamic json) {
    status = json['status'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(HistoryData.fromJson(v));
      });
    }
  }
  int? status;
  List<HistoryData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

HistoryData historyDataFromJson(String str) =>
    HistoryData.fromJson(json.decode(str));
String historyDataToJson(HistoryData data) => json.encode(data.toJson());

class HistoryData {
  HistoryData({
    this.id,
    this.orderId,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.timeFormat,
    this.date,
    this.tableName,
  });

  HistoryData.fromJson(dynamic json) {
    id = json['id'];
    orderId = json['order_id'].toString();
    total = json['total'].toString();
    createdAt = json['created_at'].toString();
    updatedAt = json['updated_at'].toString();
    timeFormat = json['time_format'].toString();
    date = json['date'].toString();
    tableName = json['table_name'].toString();
  }
  int? id;
  String? orderId;
  String? total;
  String? createdAt;
  String? updatedAt;
  String? timeFormat;
  String? date;
  String? tableName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['order_id'] = orderId;
    map['total'] = total;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['time_format'] = timeFormat;
    map['date'] = date;
    map['table_name'] = tableName;
    return map;
  }
}
