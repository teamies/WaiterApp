import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:waiter_app/database/model/login_model.dart';
import 'package:waiter_app/database/services/api_list.dart';

class LoginService {
  static var client = http.Client();
  static login({required email, required password}) async {
    var response = await client.post(
      Uri.parse(ApiList.login!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          <String, String>{"email": email, "password": password, "role": '5'}),
    );
    if (response.statusCode == 200) {
      var stringObject = response.body;
      var user = loginMOdelFromJson(stringObject);
      return user;
    } else if (response.statusCode == 401) {
      var stringObject = jsonDecode(response.body);
      Get.snackbar(
        "Login",
        stringObject['message'],
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } else {
      return null;
    }
  }
}
