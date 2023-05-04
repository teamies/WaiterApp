import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/profile_model.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

import 'api_list.dart';

class ProfileServices {
  static var client = http.Client();

  static Future<ProfileData?> profile() async {
    var token = await UserSecureStorage.getToken();
    var response = await client.get(Uri.parse(ApiList.profile!), headers: {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      var profile = ProfileModelData.fromJson(stringObject['data']);
      return profile.data;
    } else {
      return null;
    }
  }
}
