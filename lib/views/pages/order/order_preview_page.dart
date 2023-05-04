// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/database/model/table_model.dart';
import 'package:waiter_app/database/storage/user_secure_storage.dart';
import 'package:waiter_app/logic/controller/order_controller.dart';
import 'package:waiter_app/logic/controller/search_menu_controller.dart';
import 'package:waiter_app/logic/controller/table_controller.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';
import 'package:waiter_app/views/widgets/custom_drawer.dart';
import 'package:get/get.dart';
import 'package:waiter_app/views/widgets/loader.dart';

class OrderPreviewPage extends StatelessWidget {
  OrderPreviewPage({Key? key}) : super(key: key);

  final TableController tableController = Get.put(TableController());
  final SearchMenuController searchMenuController =
      Get.put(SearchMenuController());
  final OrderController orderController = Get.put(OrderController());
  int? selectedTable = 0;
  int? selectedTableID = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          // 'Order Preview',
          'Xem trước đơn hàng',
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
              const EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
          child: Stack(children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GetBuilder<TableController>(
                          init: TableController(),
                          builder: (bookTable) {
                            return Container(
                              child: bookTable.tableData.isEmpty
                                  ? Container()
                                  : Container(
                                      height: 55,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0xffF2CDD4),
                                        ),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                      ),
                                      child: ButtonTheme(
                                        alignedDropdown: true,
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<TableData>(
                                            isExpanded: true,
                                            hint: const Text(
                                              // 'Select Table',
                                              'Chọn bàn',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 16),
                                            ),
                                            menuMaxHeight:
                                                ScreenSize(context).mainHeight /
                                                    3,
                                            value: bookTable.tableData[
                                                bookTable.tableIndex],
                                            items: bookTable.tableData
                                                .map((TableData value) {
                                              return DropdownMenuItem<
                                                  TableData>(
                                                value: value,
                                                child: Text(
                                                  value.name.toString(),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              selectedTable = bookTable
                                                  .tableData
                                                  .indexOf(newValue!);
                                              selectedTableID = newValue.id;
                                              UserSecureStorage.setTableID(
                                                  selectedTableID);
                                              bookTable.bookTable();
                                              searchMenuController
                                                  .getMenuItemTable();
                                              (context as Element)
                                                  .markNeedsBuild();
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      //order items headline
                      GetBuilder<SearchMenuController>(
                          init: SearchMenuController(),
                          builder: (menuItem) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: Text(
                                // 'Order items( ${menuItem.menuData.length} Items)',
                                'Đặt hàng( ${menuItem.menuData.length} Mặt hàng)',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff160040),
                                ),
                              ),
                            );
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      //ordered items list
                      GetBuilder<SearchMenuController>(
                          init: SearchMenuController(),
                          builder: (menuItem) {
                            return Container(
                              height: ScreenSize(context).mainHeight / 1.65,
                              color: Colors.grey.shade50,
                              child: menuItem.menuData.isEmpty
                                  ? Container()
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: menuItem.menuData.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          height:
                                              ScreenSize(context).mainHeight /
                                                  5.8,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1,
                                                color: Colors.blue
                                                    .withOpacity(.01)),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(15)),
                                            color: Colors.white,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  height: 85,
                                                  width: 80,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                      menuItem
                                                          .menuData[index].image
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (BuildContext
                                                              context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) {
                                                          return child;
                                                        }
                                                        return Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            color: AppColor
                                                                .primaryColor,
                                                            value: loadingProgress
                                                                        .expectedTotalBytes !=
                                                                    null
                                                                ? loadingProgress
                                                                        .cumulativeBytesLoaded /
                                                                    loadingProgress
                                                                        .expectedTotalBytes!
                                                                : null,
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: ScreenSize(context)
                                                            .mainHeight /
                                                        2,
                                                    color: Colors.white,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                menuItem
                                                                    .menuData[
                                                                        index]
                                                                    .name
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 14,
                                                                  color: Color(
                                                                      0xff160040),
                                                                ),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child: Center(
                                                                child:
                                                                    FloatingActionButton(
                                                                  heroTag: menuItem
                                                                      .menuData[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  elevation: 0,
                                                                  onPressed:
                                                                      () {
                                                                    searchMenuController
                                                                        .menuItemRemove(
                                                                            index);
                                                                  },
                                                                  child:
                                                                      const Icon(
                                                                    Icons.clear,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .red,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        //variations
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            menuItem.menuData[index]
                                                                        .variationName !=
                                                                    ''
                                                                ? Container(
                                                                    height: 14,
                                                                    width: 62,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: const Color(
                                                                          0xffF0F0F0),
                                                                      borderRadius:
                                                                          BorderRadius
                                                                              .circular(
                                                                        10,
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        menuItem
                                                                            .menuData[index]
                                                                            .variationName
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              9,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          color:
                                                                              Color(0xff160040),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),

                                                        const SizedBox(
                                                          height: 3,
                                                        ),
                                                        //options
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Center(
                                                              child: menuItem
                                                                      .menuData[
                                                                          index]
                                                                      .options!
                                                                      .isEmpty
                                                                  ? Container()
                                                                  : SizedBox(
                                                                      height:
                                                                          14,
                                                                      width: ScreenSize(context)
                                                                              .mainWidth /
                                                                          1.8,
                                                                      child: ListView
                                                                          .separated(
                                                                        itemCount: menuItem
                                                                            .menuData[index]
                                                                            .options!
                                                                            .length,
                                                                        itemBuilder:
                                                                            (context, itemIndex) =>
                                                                                Container(
                                                                          height:
                                                                              14,
                                                                          width:
                                                                              60,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                const Color(0xffF0F0F0),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              10,
                                                                            ),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 4),
                                                                              child: Text(
                                                                                menuItem.menuData[index].options![itemIndex]['name'].toString(),
                                                                                style: const TextStyle(
                                                                                  fontSize: 8,
                                                                                  fontWeight: FontWeight.w300,
                                                                                  color: Color(0xff160040),
                                                                                ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 1,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        scrollDirection:
                                                                            Axis.horizontal,
                                                                        physics:
                                                                            const ScrollPhysics(),
                                                                        shrinkWrap:
                                                                            true,
                                                                        separatorBuilder:
                                                                            (BuildContext context,
                                                                                int index) {
                                                                          return const SizedBox(
                                                                            width:
                                                                                3,
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                            ),
                                                            menuItem
                                                                    .menuData[
                                                                        index]
                                                                    .options!
                                                                    .isEmpty
                                                                ? Container()
                                                                : const Center(
                                                                    child: Text(
                                                                      '>',
                                                                      style:
                                                                          TextStyle(
                                                                        color: AppColor
                                                                            .primaryColor,
                                                                        fontSize:
                                                                            12,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                          ],
                                                        ),

                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        Expanded(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              SizedBox(
                                                                height: 25,
                                                                width: ScreenSize(
                                                                            context)
                                                                        .mainWidth /
                                                                    4.8,
                                                                child: Text(
                                                                  '${menuItem.menuData[index].currencyCode}' +
                                                                      menuItem
                                                                          .menuData[
                                                                              index]
                                                                          .unitPrice
                                                                          .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Color(
                                                                        0xff160040),
                                                                  ),
                                                                ),
                                                              ),
                                                              //  Add/Remove Button start
                                                              Container(
                                                                height: 26,
                                                                width: ScreenSize(
                                                                            context)
                                                                        .mainWidth /
                                                                    4,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  border: Border
                                                                      .all(
                                                                    width: 0,
                                                                    color:
                                                                        const Color(
                                                                      0xffF2CDD4,
                                                                    ),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            23,
                                                                        width:
                                                                            28,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              FloatingActionButton(
                                                                            shape:
                                                                                const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            heroTag:
                                                                                menuItem.menuData[index].id.toString(),
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            elevation:
                                                                                .5,
                                                                            onPressed:
                                                                                () {
                                                                              searchMenuController.menuItemQtyRemove(index);
                                                                            },
                                                                            child:
                                                                                const Text(
                                                                              '-',
                                                                              style: TextStyle(
                                                                                fontSize: 20,
                                                                                fontWeight: FontWeight.w600,
                                                                                color: Color(0xffEE1D48),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height:
                                                                          30,
                                                                      width: 20,
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          menuItem
                                                                              .menuData[index]
                                                                              .qty
                                                                              .toString(),
                                                                          style:
                                                                              const TextStyle(
                                                                            fontSize:
                                                                                20,
                                                                            fontWeight:
                                                                                FontWeight.w600,
                                                                            color:
                                                                                Color(0xff160040),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              2.0),
                                                                      child:
                                                                          SizedBox(
                                                                        height:
                                                                            23,
                                                                        width:
                                                                            28,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              FloatingActionButton(
                                                                            shape:
                                                                                const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(5.0),
                                                                              ),
                                                                            ),
                                                                            heroTag:
                                                                                menuItem.menuData[index].id.toString(),
                                                                            backgroundColor:
                                                                                Colors.white,
                                                                            elevation:
                                                                                .5,
                                                                            onPressed:
                                                                                () {
                                                                              searchMenuController.menuItemQtyAdd(index);
                                                                            },
                                                                            child:
                                                                                const Center(
                                                                              child: Text(
                                                                                '+',
                                                                                style: TextStyle(
                                                                                  fontSize: 20,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: Color(0xffEE1D48),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              //  Add/Remove Button end
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return Container(
                                          //color: Colors.blue.withOpacity(.08),
                                          height: 5,
                                        );
                                      },
                                    ),
                            );
                          }),
                    ],
                  ),
                  //Table
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: ScreenSize(context).mainWidth / 2.4,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: Colors.white,
                                onPrimary: AppColor.primaryColor,
                                onSurface: AppColor.primaryColor, // background
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  side: const BorderSide(
                                    color: Color(0xffEE1D48),
                                  ), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                Get.off(TakeOrderPage());
                              },
                              child: const Text(
                                // "Add More",
                                'Bổ sung thêm',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenSize(context).mainWidth / 2.2,
                            height: 42,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: AppColor.primaryColor,
                                onSurface: AppColor.primaryColor, // background
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(5), // <-- Radius
                                ),
                              ),
                              onPressed: () {
                                orderController.orderPost();
                              },
                              child: const Text(
                                // "Confirm Order",
                                'Xác nhận đơn hàng',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            GetBuilder<OrderController>(
              init: orderController,
              builder: (loader) {
                return loader.isLoading
                    ? Container(
                        height: ScreenSize(context).mainHeight,
                        width: ScreenSize(context).mainWidth,
                        color: Colors.white60,
                        child: const Center(child: Loader()))
                    : const SizedBox.shrink();
              },
            ),
          ])),
    );
  }
}
