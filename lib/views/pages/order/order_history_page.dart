import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/logic/controller/order_controller.dart';
import 'package:waiter_app/views/pages/order/order_details_page.dart';
import 'package:waiter_app/views/widgets/custom_drawer.dart';

class OrderHistoryPage extends StatelessWidget {
  OrderHistoryPage({Key? key}) : super(key: key);
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          // 'Order History',
          'Lịch sử đơn hàng',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      drawer: CustomDrawer(
        indexClicked: 2,
      ),
      body: RefreshIndicator(
        onRefresh: _onRefresh,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: GetBuilder<OrderController>(
              init: OrderController(),
              builder: (orderHistory) {
                return ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: orderHistory.orderData.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(OrderDetailsPage(
                            orderID:
                                orderHistory.orderData[index].id.toString(),
                            orderType: false));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orderHistory.orderData[index].tableName
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff160040),
                                  ),
                                ),
                                Text(
                                  orderHistory.orderData[index].total
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff160040),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              children: [
                                const Text(
                                  // 'Order id: ',
                                  'Mã số đơn đặt hàng',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff160040),
                                  ),
                                ),
                                Text(
                                  orderHistory.orderData[index].orderId
                                      .toString(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff160040),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      // 'Time: ',
                                      'Thời gian',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff160040),
                                      ),
                                    ),
                                    Text(
                                      orderHistory.orderData[index].createdAt
                                          .toString(),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff706881),
                                      ),
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(OrderDetailsPage(
                                        orderID: orderHistory
                                            .orderData[index].id
                                            .toString(),
                                        orderType: false));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    minimumSize: Size.zero, // Set this
                                    padding: const EdgeInsets.only(
                                        left: 8, right: 8, top: 4, bottom: 4),
                                    primary: Colors.white, // background
                                    onPrimary: AppColor.primaryColor,
                                    // foreground
                                    side: const BorderSide(
                                      width: 1,
                                      color: Color(0xffEE1D48),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          5), // <-- Radius
                                    ),
                                  ),
                                  // child: const Text('View'),
                                  child: const Text('Xem'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      color: Colors.blue.withOpacity(.03),
                      height: 12,
                    );
                  },
                );
              }),
        ),
      ),
    );
  }

  Future<void> _onRefresh() {
    orderController.orderList();
    Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }
}
