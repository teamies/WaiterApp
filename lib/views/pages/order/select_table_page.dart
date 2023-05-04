import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/logic/controller/search_menu_controller.dart';
import 'package:waiter_app/logic/controller/table_controller.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';
import 'package:waiter_app/views/widgets/custom_drawer.dart';

import '../../../constants/constants.dart';
import '../../../database/model/table_model.dart';

class SelectTablePage extends StatefulWidget {
  const SelectTablePage({Key? key}) : super(key: key);

  @override
  State<SelectTablePage> createState() => _SelectTablePageState();
}

class _SelectTablePageState extends State<SelectTablePage> {
  final TableController tableController = Get.put(TableController());
  final SearchMenuController searchMenuController =
      Get.put(SearchMenuController());
  // final OrderController orderController = Get.put(OrderController());
  int? selectedTable = 0;
  int? selectedTableID = 0;

  @override
  Widget build(BuildContext context) {
    selectedTableID = tableController.tableID;
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            // 'Take Order',
            'Chọn bàn',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        drawer: CustomDrawer(
          indexClicked: 1,
        ),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 8),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GetBuilder<TableController>(
                      init: TableController(),
                      builder: (bookTable) {
                        return Container(
                          child: bookTable.tableData.isEmpty
                              ? Container()
                              : GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemCount: bookTable.tableData.length-1,
                                  itemBuilder: (context, index) {
                                    TableData value = bookTable.tableData[index + 1];
                                    // if (index != 0) {
                                          print(index);
                                          print('object');
                                          print(bookTable.tableData[index].id );
                                      return GestureDetector(
                                        onTap: () {
                                          selectedTable = index + 1;
                                          selectedTableID =
                                              value.id;
                                          UserSecureStorage.setTableID(
                                              selectedTableID);
                                          bookTable.bookTable();
                                          searchMenuController
                                              .getMenuItemTable();
                                          (context as Element).markNeedsBuild();
                                          Get.to(() => TakeOrderPage());
                                          // navigator.push(context, MaterialPageRoute(builder: (context)=> TakeOrderPage()));
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: 1,
                                              color: selectedTable == index 
                                                  ? AppColor.primaryColor
                                                  : const Color(0xffF2CDD4),
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(5)),
                                          ),
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Container(
                                                  child: Image.asset(
                                                      'assets/images/table.jpg'),
                                                ),
                                                SizedBox(height: 10),
                                                Text(
                                                  value.name.toString(),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                    color: selectedTable ==
                                                            index
                                                        ? AppColor.primaryColor
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    // }
                                    // else{ return Container(decoration: BoxDecoration(color: Colors.amber));}
                                  },
                                ),
                        );
                      }),
                ])));
  }
}
