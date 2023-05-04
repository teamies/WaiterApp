import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:waiter_app/database/services/api_list.dart';
import 'package:waiter_app/database/services/profile_service.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';

class ProfileController extends GetxController {
  bool isLoading = false;
  String name = '';
  String email = '';
  String image = '';
  String phone = '';
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  void onInit() {
    getUserProfile();
    super.onInit();
  }

  getUserProfile() async {
    try {
      var profile = await ProfileServices.profile();
      if (profile != null) {
        name = profile.name!;
        email = profile.email!;
        image = profile.image!;
        phone = profile.phone!;
        isLoading = false;
        update();
      }
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  updateUserProfile(
      {BuildContext? context, required String filepath, type}) async {
    isLoading = true;
    update();
    Map<String, String> body = {
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneController.text,
    };
    multipartRequest(body: body, filepath: filepath, type: type)
        .then((response) {
      if (response.statusCode == 200) {
        isLoading = false;
        update();
        emailController.clear();
        nameController.clear();
        phoneController.clear();
        onInit();
        Get.back();
      } else {
        Get.rawSnackbar(
          title: 'Update not successful!',
          message: 'Please enter valid input',
          backgroundColor: AppColor.primaryColor.withOpacity(.9),
          maxWidth: ScreenSize(context!).mainWidth / 1.007,
          margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        );
        isLoading = false;
        update();
      }
    });
  }

  multipartRequest({body, String? filepath, type}) async {
    var token = await UserSecureStorage.getToken();
    Map<String, String> headers = {
      'Authorization': 'Bearer ' + token!,
      'Content-Type': 'multipart/form-data',
    };
    HttpClient client = HttpClient();
    try {
      http.MultipartRequest request;
      if (type) {
        request = http.MultipartRequest(
            'POST', Uri.parse(ApiList.profileUpdate!))
          ..fields.addAll(body)
          ..headers.addAll(headers)
          ..files.add(await http.MultipartFile.fromPath('image', filepath!));
      } else {
        request =
            http.MultipartRequest('POST', Uri.parse(ApiList.profileUpdate!))
              ..fields.addAll(body)
              ..headers.addAll(headers);
      }
      return await request.send();
    } catch (error) {
      return null;
    } finally {
      client.close();
    }
  }
}
