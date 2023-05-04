import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/database/model/popular_menu_model.dart';
import 'package:waiter_app/database/model/search_menu_model.dart';
import 'package:waiter_app/database/services/popular_menu_service.dart';
import 'package:waiter_app/database/services/search_menu_service.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';

class SearchMenuController extends GetxController {
  List<MenuDetail> menuData = <MenuDetail>[];
  List<MenuDetail> searchMenuData = <MenuDetail>[];
  List<PopularMenuData> popularMenuData = <PopularMenuData>[];
  final _formKeys = GlobalKey<FormState>();
  bool isLoading = false;
  int variationID = 0;
  int? menuTotal;
  String variationIDPrice = '';
  String variationName = '';
  List selectOptionsList = [];
  List selectOptions = [];

  @override
  void onInit() async {
    popularMenu();
    menuData = <MenuDetail>[];
    var menuItems = await UserSecureStorage.getMenuItem();
    if (menuItems != null) {
      menuData.addAll(
        List<MenuDetail>.from(
            jsonDecode(menuItems).map((x) => MenuDetail.fromJson(x))),
      );
    } else {
      menuData = <MenuDetail>[];
    }
    update();
    super.onInit();
  }

  void _onCategorySelected(context, bool? selected, categoryId, options) {
    if (selected == true) {
      selectOptionsList.add(categoryId);
      selectOptions.add(options);
      (context as Element).markNeedsBuild();
    } else {
      selectOptions.removeWhere((item) => item['id'] == categoryId);
      selectOptionsList.remove(categoryId);
      (context as Element).markNeedsBuild();
    }
  }

  popularMenu() async {
    isLoading = true;
    update();
    try {
      var popularMenu = await PopularMenuService.popularMenu();
      if (popularMenu != null) {
        popularMenuData = <PopularMenuData>[];
        popularMenuData.addAll(popularMenu.data!);
        isLoading = false;
        update();
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  menuItem(query, category) async {
    isLoading = true;
    update();
    try {
      var menu = await SearchMenuServices.searchMenuItems(query, category);

      if (menu != null && menu.data!.isNotEmpty) {
        popularMenuData = <PopularMenuData>[];
        popularMenuData.addAll(menu.data!);
        isLoading = false;
      }
      update();
    } finally {
      isLoading = false;
      update();
    }
  }

  menuItemNumberAdd(context, menuNumber, selectedTableID) async {
    try {
      var menu = await SearchMenuServices.searchMenu(menuNumber, null);

      if (menu != null && menu.data!.isNotEmpty) {
        if (menu.data?[0].variations != null &&
            menu.data![0].variations!.isNotEmpty) {
          showVariations(context, false, menu.data);
        } else {
          var menuItems = await UserSecureStorage.getMenuItem();
          if (menuItems != null) {
            menuData = <MenuDetail>[];
            menuData.addAll(menu.data!);
            menuData.addAll(
              List<MenuDetail>.from(jsonDecode(menuItems).map((x) {
                if (x['id'] == menu.data?[0].id) {
                  menuData.removeWhere((item) => item.id == menu.data?[0].id);
                  x['qty'] = x['qty'] + 1;
                }
                return MenuDetail.fromJson(x);
              })),
            );
            UserSecureStorage.setMenuItem(menuData);
          } else {
            menuData = <MenuDetail>[];
            UserSecureStorage.setMenuItem(menu.data);
            var menuItems = await UserSecureStorage.getMenuItem();
            menuData.addAll(
              List<MenuDetail>.from(
                  jsonDecode(menuItems!).map((x) => MenuDetail.fromJson(x))),
            );
          }
          update();
        }
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  menuItemsClear() async {
    UserSecureStorage.deleteMenu();
    onInit();
  }

  menuItemRemove(index) async {
    menuData.removeAt(index);
    update();
    UserSecureStorage.setMenuItem(menuData);
  }

  menuItemQtyAdd(index) async {
    menuData[index].qty = menuData[index].qty! + 1;
    update();
    UserSecureStorage.setMenuItem(menuData);
  }

  menuItemQtyRemove(index) async {
    if (menuData[index].qty! > 1) {
      menuData[index].qty = menuData[index].qty! - 1;
    }
    update();
    UserSecureStorage.setMenuItem(menuData);
  }

  menuItemAdd(context, menuItem) async {
    var tableID = await UserSecureStorage.getTableID();
    if (tableID != '0' && tableID != null) {
      UserSecureStorage.setMenu(menuItem);
      var menuItems = await UserSecureStorage.getMenuItem();
      var menu = await UserSecureStorage.getMenu();
      var menus = jsonDecode(menu!);
      if (menus['variations'].isNotEmpty && menus['variations'] != null) {
        searchMenuData.clear();
        searchMenuData.add(MenuDetail.fromJson(menus));
        showVariations(context, true, searchMenuData);
      } else {
        if (menuItems != null) {
          menuData = <MenuDetail>[];
          menuData.add(MenuDetail.fromJson(menus));
          menuData.addAll(
            List<MenuDetail>.from(jsonDecode(menuItems).map((x) {
              if (x['id'] == menuItem.id) {
                menuData.removeWhere((item) => item.id == menuItem.id);
                x['qty'] = x['qty'] + 1;
              }
              return MenuDetail.fromJson(x);
            })),
          );
          UserSecureStorage.setMenuItem(menuData);
        } else {
          menuData.add(MenuDetail.fromJson(menus));
          UserSecureStorage.setMenuItem(menuData);
        }
        Get.off(() => TakeOrderPage());
      }
    } else {
      Get.snackbar("Table", 'Please select a Table first',
          snackPosition: SnackPosition.TOP,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white);
    }
  }

  getMenuItemTable() async {
    menuData = <MenuDetail>[];
    var menuItems = await UserSecureStorage.getMenuItem();
    if (menuItems != null) {
      menuData.addAll(
        List<MenuDetail>.from(
            jsonDecode(menuItems).map((x) => MenuDetail.fromJson(x))),
      );
    } else {
      menuData = <MenuDetail>[];
    }
    update();
  }

  showVariations(context, type, data) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            content: Stack(
              clipBehavior: Clip.none,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Get.back();
                    },
                    child: const CircleAvatar(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      backgroundColor: AppColor.primaryColor,
                    ),
                  ),
                ),
                Form(
                  key: _formKeys,
                  child: SizedBox(
                    width: ScreenSize(context).mainWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Choose Variation',
                          style: TextStyle(
                            color: Color(0xff160040),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: ScreenSize(context).mainHeight / 5,
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data[0].variations.length,
                            itemBuilder: (context, index) => CheckboxListTile(
                              activeColor: AppColor.primaryColor,
                              checkColor: Colors.white,
                              controlAffinity: ListTileControlAffinity.leading,
                              value:
                                  variationID == data[0].variations[index]['id']
                                      ? true
                                      : false,
                              onChanged: (bool? selected) {
                                variationID = data[0].variations[index]['id'];
                                variationIDPrice =
                                    data[0].variations[index]['unit_price'];
                                variationName =
                                    data[0].variations[index]['name'];
                                (context as Element).markNeedsBuild();
                              },
                              title: Text(data[0].variations[index]['name']),
                              secondary: Text(data[0].variations[index]
                                      ['currency_code'] +
                                  '' +
                                  data[0].variations[index]['unit_price']),
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),
                        //2nd row
                        const Text(
                          'Choose Option',
                          style: TextStyle(
                            color: Color(0xff160040),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        data[0].options.length != 0
                            ? SizedBox(
                                height: ScreenSize(context).mainHeight / 5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data[0].options.length,
                                  itemBuilder: (context, index) =>
                                      CheckboxListTile(
                                    activeColor: AppColor.primaryColor,
                                    checkColor: Colors.white,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    value: selectOptionsList
                                        .contains(data[0].options[index]['id']),
                                    onChanged: (bool? selected) {
                                      _onCategorySelected(
                                          context,
                                          selected,
                                          data[0].options[index]['id'],
                                          data[0].options[index]);
                                    },
                                    title: Text(data[0].options[index]['name']),
                                    secondary: Text(data[0].options[index]
                                            ['currency_code'] +
                                        '' +
                                        data[0].options[index]['unit_price']),
                                  ),
                                ),
                              )
                            : Container(),

                        const SizedBox(
                          height: 30,
                        ),

                        Center(
                          child: SizedBox(
                            height: 45,
                            width: ScreenSize(context).mainWidth / 4,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: AppColor.primaryColor, // background
                                onPrimary: Colors.white, // foreground
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(10), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                if (variationID != 0) {
                                  if (type) {
                                    addVaritaionsOptions(data, variationID,
                                        variationIDPrice, variationName);
                                    Get.off(() => TakeOrderPage());
                                  } else {
                                    addVaritaionsOptions(data, variationID,
                                        variationIDPrice, variationName);
                                    Get.back();
                                  }
                                } else {
                                  Get.snackbar("Variation",
                                      'Please select a variation first',
                                      snackPosition: SnackPosition.TOP,
                                      backgroundColor: AppColor.primaryColor,
                                      colorText: Colors.white);
                                }
                              },
                              child: const Text(
                                'Add',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  addVaritaionsOptions(
      data, variationsID, variationsPrice, variationsName) async {
    double total = 0;
    if (selectOptions.isNotEmpty) {
      selectOptions.map((element) {
        total = (total + double.parse(element['unit_price']));
      }).toList();
      data[0].options = selectOptions;
    } else {
      data[0].options = selectOptions;
    }
    data[0].unitPrice = (double.parse(variationsPrice) + total).toString();
    data[0].variationId = variationsID.toString();
    data[0].variationName = variationsName.toString();

    var menuItems = await UserSecureStorage.getMenuItem();

    if (menuItems != null) {
      menuData = <MenuDetail>[];
      menuData.addAll(data);
      menuData.addAll(
        List<MenuDetail>.from(jsonDecode(menuItems).map((x) {
          if (x['id'] == data[0].id &&
              x['variationId'] == data[0].variationId) {
            menuData
                .removeWhere((item) => item.variationId == data[0].variationId);
            x['unit_price'] = data[0].unitPrice;
            x['variationId'] = data[0].variationId;
            x['variationName'] = data[0].variationName;
            x['options'] = data[0].options;
            x['qty'] = x['qty'] + 1;
          }

          return MenuDetail.fromJson(x);
        })),
      );

      UserSecureStorage.setMenuItem(menuData);
    } else {
      menuData = <MenuDetail>[];
      UserSecureStorage.setMenuItem(data);
      var menuItems = await UserSecureStorage.getMenuItem();
      menuData.addAll(
        List<MenuDetail>.from(
            jsonDecode(menuItems!).map((x) => MenuDetail.fromJson(x))),
      );
    }
    isLoading = false;
    variationID = 0;
    variationIDPrice = '';
    variationName = '';
    selectOptionsList = [];
    selectOptions = [];
    searchMenuData = [];
    update();
  }
}
