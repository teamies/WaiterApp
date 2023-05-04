import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/database/services/refresh_token_services.dart';
import 'package:waiter_app/logic/bindings/login_binding.dart';
import 'package:waiter_app/views/pages/authentication/login_page.dart';
import 'package:get/get.dart';
import 'package:waiter_app/views/pages/order/order_history_page.dart';
import 'package:waiter_app/views/pages/order/select_table_page.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';
import 'package:waiter_app/views/pages/search/search_page.dart';

import 'database/storage/user_secure_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await UserSecureStorage.getToken();
  if (token != null) {
    await RefreshTokenService.refreshToken();
  }
  final WaiterApp myApp = WaiterApp(
    initialRoute: token != null ? "/SelectTablePage" : "/",
  );
  runApp(myApp);
}

class WaiterApp extends StatelessWidget {
  final String initialRoute;

  const WaiterApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Waiter App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primaryColor: AppColor.primaryColor,
      ),
      initialRoute: initialRoute,
      getPages: [
        GetPage(name: "/", page: () => LogInPage(), binding: LoginBinding()),
        GetPage(name: "/SelectTablePage", page: () => SelectTablePage()),
        GetPage(name: "/TakeOrderPage", page: () => TakeOrderPage()),
        GetPage(name: "/SearchPage", page: () => SearchPage()),
        GetPage(name: "/OrderHistoryPage", page: () => OrderHistoryPage()),
      ],
    );
  }
}
