import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/refresh_token_model.dart';
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class RefreshTokenService {
  static var client = http.Client();
  static refreshToken() async {
    var token = await UserSecureStorage.getToken();
    var response = await client.get(Uri.parse(ApiList.tokenRefresh!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var refreshData = RefreshTokenModel.fromJson(jsonResponse);
      UserSecureStorage.setToken(refreshData.token.toString());
      return refreshData.token;
    } else {
      return null;
    }
  }
}
