import 'package:get/get.dart';
import 'package:waiter_app/logic/controller/auth_controller.dart';
import 'package:waiter_app/logic/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
    Get.put(AuthController());
  }
}
