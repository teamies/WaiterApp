import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/table_model.dart';
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class TableService {
  static var client = http.Client();
  static Future<TableModel?> table() async {
    var token = await UserSecureStorage.getToken();
    var response = await client.get(Uri.parse(ApiList.table!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var table = TableModel.fromJson(stringObject);
      return table;
    } else {
      return null;
    }
  }
}
