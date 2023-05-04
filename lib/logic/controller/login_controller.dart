import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/database/services/login_service.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';

class LoginController extends GetxController {
  bool isLoading = false;
  final loginFormKey = GlobalKey<FormState>();
  late TextEditingController emailController, passwordController;
  String email = '', password = '';

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    init();
    super.onInit();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future init() async {
    final email = await UserSecureStorage.getEmail() ?? '';
    emailController.text = email;
  }

  String? validateEmail(String value) {
    if (!GetUtils.isEmail(value)) {
      return "Email Incorrect! Try Again...";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    if (value.length <= 2) {
      return "Password Incorrect! Try Again...";
    } else {
      return null;
    }
  }

  doLogin() async {
    bool isValidate = loginFormKey.currentState!.validate();
    if (isValidate) {
      isLoading = true;
      update();
      try {
        var data = await LoginService.login(
            email: emailController.text, password: passwordController.text);
        if (data != null) {
          isLoading = false;
          UserSecureStorage.setEmail(emailController.text);
          UserSecureStorage.setPassword(passwordController.text);
          UserSecureStorage.setToken(data.token);
          UserSecureStorage.setWaiterID(data.waiterID.toString());
          UserSecureStorage.setRestaurantId(data.restaurant.id.toString());
          loginFormKey.currentState!.save();
          update();
          Get.off(() => TakeOrderPage());
        } else {
          isLoading = false;
          update();
        }
      } finally {
        isLoading = false;
      }
    }
  }
}
