import 'dart:convert';

import 'package:get/get.dart';
import 'package:waiter_app/database/model/order_detail_model.dart';
import 'package:waiter_app/database/model/order_history_model.dart';
import 'package:waiter_app/database/model/table_model.dart';
import 'package:waiter_app/database/services/order_service.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/logic/controller/search_menu_controller.dart';
import 'package:waiter_app/views/pages/order/order_details_page.dart';

class OrderController extends GetxController {
  List<TableData> tableData = <TableData>[];
  List<HistoryData> orderData = <HistoryData>[];
  List<OrderShowData> orderShowData = <OrderShowData>[];

  var tableIndex = 0;
  var tableID = 0;
  bool isLoading = false;
  List<Map> items = [];

  @override
  void onInit() {
    orderList();
    super.onInit();
  }

  orderList() async {
    try {
      var order = await OrderService.orderList();
      if (order != null) {
        orderData = <HistoryData>[];
        orderData.addAll(order.data!);
      }else{
        print('*******no order history**********');
      }

      update();
    } finally {
      update();
    }
  }

  orderShow(orderID) async {
    try {
      var orderShow = await OrderService.orderShow(orderID);
      if (orderShow != null) {
        orderShowData = <OrderShowData>[];
        orderShowData.add(orderShow.data!);
      }
      update();
    } finally {
      update();
    }
  }

  orderPost() async {
    isLoading = true;
    update();
    var tableID = await UserSecureStorage.getTableID();
    var waiterID = await UserSecureStorage.getWaiterID();
    var restaurantId = await UserSecureStorage.getRestaurantId();
    var menuItems = await UserSecureStorage.getMenuItem();
    double total = 0;
    jsonDecode(menuItems!).forEach((element) => total +=
        (double.parse(element['unit_price'].toString()) * element['qty']));
    jsonDecode(menuItems).forEach((element) => items.add(ItemProduct(
            restaurantId: 0,
            menuItemId: element['id'],
            unitPrice: double.parse(element['unit_price'].toString()),
            discountedPrice: 0.0,
            quantity: element['qty'],
            instructions: '',
            menuItemVariationId: element['variationId'],
            options: element['options'])
        .toJsonData()));

    Map body = {
      "items": json.encode(items),
      "lat": '33',
      "long": '22',
      "table_id": tableID,
      "waiter_id": waiterID,
      "total": total,
      "restaurant_id": restaurantId,
      "payment_type": 25,
    };
    String jsonBody = json.encode(body);

    var order = await OrderService.orderPost(jsonBody);

    if (order != null) {
      Get.off(
          () => OrderDetailsPage(orderID: order.toString(), orderType: true));
      UserSecureStorage.deleteMenu();
      Get.find<SearchMenuController>().onInit();
      isLoading = false;
      update();
    } else {
      isLoading = false;
      update();
    }
  }
}

class ItemProduct {
  String? instructions;
  int? restaurantId;
  int? menuItemId;
  double? discountedPrice;
  double? unitPrice;
  int? quantity;
  String? menuItemVariationId;
  List? options = [];

  ItemProduct(
      {this.instructions,
      this.restaurantId,
      this.menuItemId,
      this.unitPrice,
      this.quantity,
      this.discountedPrice,
      this.menuItemVariationId,
      this.options});

  Map<String, dynamic> toJsonData() {
    var map = <String, dynamic>{};
    map["instructions"] = instructions;
    map["restaurant_id"] = restaurantId;
    map["menu_item_variation_id"] = menuItemVariationId;
    map["menuItem_id"] = menuItemId;
    map["unit_price"] = unitPrice;
    map["quantity"] = quantity;
    map["discounted_price"] = discountedPrice;
    map["options"] = options;
    return map;
  }
}
