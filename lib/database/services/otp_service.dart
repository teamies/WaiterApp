import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import 'api_list.dart';

class OtpService {
  static var client = http.Client();
  static otpSend({required email}) async {
    var response = await client.post(
      Uri.parse(ApiList.getOtp!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{"otp": email}),
    );

    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return true;
    } else if (response.statusCode == 401) {
      var stringObject = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return false;
    } else {
      return false;
    }
  }

  static otpVerify({required otp}) async {
    var response = await client.post(
      Uri.parse(ApiList.verifyOtp!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{"code": otp}),
    );

    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return true;
    } else if (response.statusCode == 401) {
      var stringObject = jsonDecode(response.body);

      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return false;
    } else {
      return false;
    }
  }

  static resetPassword({required email, required password}) async {
    var response = await client.post(
      Uri.parse(ApiList.resetPassword!),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      var stringObject = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return true;
    } else if (response.statusCode == 401) {
      var stringObject = jsonDecode(response.body);
      Fluttertoast.showToast(
        msg: stringObject['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_RIGHT,
      );
      return false;
    } else {
      return false;
    }
  }
}
