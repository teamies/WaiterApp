// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromMap(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromMap(String str) =>
    OrderDetailModel.fromMap(json.decode(str));

String orderDetailModelToMap(OrderDetailModel data) =>
    json.encode(data.toMap());

class OrderDetailModel {
  OrderDetailModel({
    this.data,
  });

  OrderDetailModelData? data;

  factory OrderDetailModel.fromMap(Map<String, dynamic> json) =>
      OrderDetailModel(
        data: OrderDetailModelData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "data": data!.toMap(),
      };
}

class OrderDetailModelData {
  OrderDetailModelData({
    this.status,
    this.data,
  });

  int? status;
  OrderShowData? data;

  factory OrderDetailModelData.fromMap(Map<String, dynamic> json) =>
      OrderDetailModelData(
        status: json["status"],
        data: OrderShowData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "data": data!.toMap(),
      };
}

class OrderShowData {
  OrderShowData({
    this.id,
    this.orderId,
    this.total,
    this.createdAt,
    this.updatedAt,
    this.timeFormat,
    this.date,
    this.tableName,
    this.order,
  });

  int? id;
  String? orderId;
  String? total;
  String? createdAt;
  String? updatedAt;
  String? timeFormat;
  String? date;
  String? tableName;
  Order? order;

  factory OrderShowData.fromMap(Map<String, dynamic> json) => OrderShowData(
        id: json["id"],
        orderId: json["order_id"].toString(),
        total: json["total"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        timeFormat: json["time_format"].toString(),
        date: json["date"].toString(),
        tableName: json["table_name"].toString(),
        order: Order.fromMap(json["order"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "total": total,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "time_format": timeFormat,
        "date": date,
        "table_name": tableName,
        "order": order!.toMap(),
      };
}

class Order {
  Order({
    this.id,
    this.total,
    this.subTotal,
    this.status,
    this.statusName,
    this.paymentStatus,
    this.paymentMethod,
    this.paymentMethodName,
    this.paidAmount,
    this.restaurantId,
    this.restaurantName,
    this.items,
  });

  int? id;
  String? total;
  String? subTotal;
  int? status;
  String? statusName;
  int? paymentStatus;
  int? paymentMethod;
  String? paymentMethodName;
  String? paidAmount;
  int? restaurantId;
  String? restaurantName;
  List<Item>? items;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        total: json["total"].toString(),
        subTotal: json["sub_total"].toString(),
        status: int.parse(json["status"].toString()),
        statusName: json["status_name"].toString(),
        paymentStatus: int.parse(json["payment_status"].toString()),
        paymentMethod: int.parse(json["payment_method"].toString()),
        paymentMethodName: json["payment_method_name"].toString(),
        paidAmount: json["paid_amount"].toString(),
        restaurantId: int.parse(json["restaurant_id"].toString()),
        restaurantName: json["restaurant_name"].toString(),
        items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "total": total,
        "sub_total": subTotal,
        "status": status,
        "status_name": statusName,
        "payment_status": paymentStatus,
        "payment_method": paymentMethod,
        "payment_method_name": paymentMethodName,
        "paid_amount": paidAmount,
        "restaurant_id": restaurantId,
        "restaurant_name": restaurantName,
        "items": List<dynamic>.from(items!.map((x) => x.toMap())),
      };
}

class Item {
  Item({
    this.id,
    this.orderId,
    this.restaurantId,
    this.menuItemId,
    this.menuItemName,
    this.menuItemNumber,
    this.menuItemImage,
    this.quantity,
    this.unitPrice,
    this.discountedPrice,
    this.itemTotal,
    this.createdAt,
    this.updatedAt,
    this.menuItemVariation,
    this.options,
    this.optionTotal,
  });

  int? id;
  int? orderId;
  int? restaurantId;
  int? menuItemId;
  String? menuItemName;
  String? menuItemNumber;
  String? menuItemImage;
  int? quantity;
  String? unitPrice;
  String? discountedPrice;
  String? itemTotal;
  String? createdAt;
  String? updatedAt;
  Unit? menuItemVariation;
  List<Unit>? options;
  int? optionTotal;

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        id: json["id"],
        orderId: int.parse(json["order_id"].toString()),
        restaurantId: int.parse(json["restaurant_id"].toString()),
        menuItemId: int.parse(json["menu_item_id"].toString()),
        menuItemName: json["menu_item_name"].toString(),
        menuItemNumber: json["menu_item_number"].toString(),
        menuItemImage: json["menu_item_image"].toString(),
        quantity: int.parse(json["quantity"].toString()),
        unitPrice: json["unit_price"].toString(),
        discountedPrice: json["discounted_price"].toString(),
        itemTotal: json["item_total"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        menuItemVariation: Unit.fromMap(json["menu_item_variation"]),
        options: List<Unit>.from(json["options"].map((x) => Unit.fromMap(x))),
        optionTotal: int.parse(json["option_total"].toString()),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "order_id": orderId,
        "restaurant_id": restaurantId,
        "menu_item_id": menuItemId,
        "menu_item_name": menuItemName,
        "menu_item_number": menuItemNumber,
        "menu_item_image": menuItemImage,
        "quantity": quantity,
        "unit_price": unitPrice,
        "discounted_price": discountedPrice,
        "item_total": itemTotal,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "menu_item_variation": menuItemVariation!.toMap(),
        "options": List<dynamic>.from(options!.map((x) => x.toMap())),
        "option_total": optionTotal,
      };
}

class Unit {
  Unit({
    this.id,
    this.name,
    this.unitPrice,
    this.currencyCode,
    this.discountPrice,
  });

  int? id;
  String? name;
  String? unitPrice;
  String? currencyCode;
  String? discountPrice;

  factory Unit.fromMap(Map<String, dynamic> json) => Unit(
        id: json["id"],
        name: json["name"].toString(),
        unitPrice: json["unit_price"].toString(),
        currencyCode: json["currency_code"].toString(),
        discountPrice: json["discount_price"].toString(),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "unit_price": unitPrice,
        "currency_code": currencyCode,
        "discount_price": discountPrice,
      };
}
