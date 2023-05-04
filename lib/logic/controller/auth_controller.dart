import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/views/pages/authentication/login_page.dart';

class AuthController extends GetxController {
  var storage = const FlutterSecureStorage();
  var name = ''.obs;
  var email = '';

  var token = '';

  @override
  void onInit() {
    authData();
    super.onInit();
  }

  authData() async {
    email = UserSecureStorage.getEmail().toString();
    token = UserSecureStorage.getToken().toString();
  }

  bool isAuth() {
    return token.isNotEmpty;
  }

  doLogout() async {
    await storage.deleteAll();
    Get.off(() => LogInPage());
  }
}
