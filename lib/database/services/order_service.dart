import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/order_detail_model.dart';
import 'package:waiter_app/database/model/order_history_model.dart';
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class OrderService {
  static var client = http.Client();
  static Future<OrderHistoryModel?> orderList() async {
    var token = await UserSecureStorage.getToken();
    var response = await client.get(Uri.parse(ApiList.orders!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print(jsonDecode(response.body));
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var orderHistory = OrderHistoryModel.fromJson(stringObject);
      return orderHistory;
    } else {
      return null;
    }
  }

  static Future<OrderDetailModelData?> orderShow(orderID) async {
    var token = await UserSecureStorage.getToken();
    var response =
        await client.get(Uri.parse(ApiList.orders! + '/' + orderID), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);

      var orderHistory = OrderDetailModelData.fromMap(stringObject['data']);

      return orderHistory;
    } else {
      return null;
    }
  }

  static orderPost(body) async {
    var token = await UserSecureStorage.getToken();
    var response = await client.post(Uri.parse(ApiList.orderPost!),
        headers: {
          'Authorization': 'Bearer ' + token!,
          'Content-Type': 'application/json'
        },
        body: body);

    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      return stringObject['data'];
    } else {
      return null;
    }
  }
}
