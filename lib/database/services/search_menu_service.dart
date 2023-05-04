import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/popular_menu_model.dart';
import 'package:waiter_app/database/model/search_menu_model.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

import 'api_list.dart';

class SearchMenuServices {
  static var client = http.Client();
  static Future<MenuData?> searchMenu(query, category) async {
    var token = await UserSecureStorage.getToken();
    var queryParameters = {
      'query': query,
      'category': category,
    };
    var uri = Uri.https(
        ApiList.apiUrl!, '/api/v1/' + ApiList.searches!, queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var menuDetail = MenuData.fromJson(stringObject['data']);
      return menuDetail;
    } else {
      return null;
    }
  }

  static Future<PopularMenuModel?> searchMenuItems(query, category) async {
    var token = await UserSecureStorage.getToken();
    var queryParameters = {
      'query': query,
      'category': category,
    };
    var uri = Uri.https(
        ApiList.apiUrl!, '/api/v1/' + ApiList.searches!, queryParameters);
    var response = await http.get(uri, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);

      var popularMenu = PopularMenuModel.fromJson(stringObject['data']);
      return popularMenu;
    } else {
      return null;
    }
  }
}
