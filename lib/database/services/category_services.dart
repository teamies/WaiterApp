import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/category_model.dart';
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class CategoryService {
  static var client = http.Client();
  static Future<List<CategoryData>?> category() async {
    var token = await UserSecureStorage.getToken();
    var response =
        await client.get(Uri.parse(ApiList.restaurantCategory!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var category = CategoryListData.fromJson(stringObject['data']);
      return category.data;
    } else {
      return null;
    }
  }
}
