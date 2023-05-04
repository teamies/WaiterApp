import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/logic/controller/auth_controller.dart';
import 'package:get/get.dart';
import 'package:waiter_app/logic/controller/login_controller.dart';
import 'package:waiter_app/logic/controller/profile_controller.dart';
import 'package:waiter_app/views/pages/order/order_history_page.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';
import 'package:waiter_app/views/pages/profile/profile_page.dart';

// ignore: must_be_immutable
class CustomDrawer extends GetView {
  int indexClicked;
  CustomDrawer({Key? key, required this.indexClicked}) : super(key: key);
  final authController = Get.put(AuthController());
  final loginController = Get.put(LoginController());
  final profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1),
                    shape: BoxShape.circle,
                    color: Colors.white,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(profileController.image),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: ScreenSize(context).mainWidth / 2.5,
                  child: Text(
                    profileController.name.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                    maxLines: 3,
                  ),
                ),
              ],
            ),
          ),
          _drawerItem(
            icon: Icons.account_circle_outlined,
            // text: 'Profile',
            text: 'Hồ sơ',
            indexNumber: 0,
            onTap: () {
              Get.off(() => ProfilePage());
              indexClicked = 0;
              (context as Element).markNeedsBuild();
            },
          ),
          _drawerItem(
            icon: Icons.add_alert_rounded,
            // text: 'Take order',
            text: 'Nhận yêu câu',
            indexNumber: 1,
            onTap: () {
              indexClicked = 1;
              Get.off(() => TakeOrderPage());
              (context as Element).markNeedsBuild();
            },
          ),
          _drawerItem(
            icon: Icons.add_alert,
            // text: 'Order history',
            text: 'Lịch sử đơn hàng',
            indexNumber: 2,
            onTap: () {
              indexClicked = 2;
              Get.off(() => OrderHistoryPage());
              (context as Element).markNeedsBuild();
            },
          ),
          _drawerItem(
            icon: Icons.logout,
            // text: 'Log out',
            text: 'Đăng xuất',
            indexNumber: 3,
            onTap: () {
              authController.doLogout();
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
      {required IconData icon,
      required String text,
      required int indexNumber,
      required GestureTapCallback onTap}) {
    return ListTile(
      selected: indexClicked == indexNumber,
      selectedTileColor: AppColor.primaryColor,
      title: Row(
        children: [
          Icon(
            icon,
            color: indexClicked == indexNumber
                ? Colors.white
                : AppColor.primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: indexClicked == indexNumber
                    ? Colors.white
                    : AppColor.primaryColor,
              ),
            ),
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
