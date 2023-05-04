import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/popular_menu_model.dart';
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class PopularMenuService {
  static var client = http.Client();
  static Future<PopularMenuModel?> popularMenu() async {
    var token = await UserSecureStorage.getToken();
    var response = await client.get(Uri.parse(ApiList.popularItems!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var popularMenu = PopularMenuModel.fromJson(stringObject);
      return popularMenu;
    } else {
      return null;
    }
  }
}
