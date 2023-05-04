import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/logic/controller/order_controller.dart';
import 'package:waiter_app/views/pages/order/order_history_page.dart';
import 'package:waiter_app/views/pages/order/take_order_page.dart';

class OrderDetailsPage extends StatelessWidget {
  OrderDetailsPage({Key? key, this.orderID, required this.orderType})
      : super(key: key);
  final String? orderID;
  final bool orderType;
  final OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    orderController.orderShow(orderID);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          // orderType == false ? 'Order Details' : 'Order Confirmed',
          orderType == false ? 'Chi tiết đặt hàng' : 'Xác nhận đặt hàng',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: TextButton.icon(
            onPressed: () => Get.to(OrderHistoryPage()),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
            ),
            label: Text('')),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: Padding(
          padding:
              const EdgeInsets.only(top: 18, left: 18, right: 18, bottom: 12),
          child: GetBuilder<OrderController>(
              init: OrderController(),
              builder: (orderHistory) {
                return orderHistory.orderShowData.isEmpty
                    ? Container()
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          orderType == true
                              ? Center(
                                  child: Container(
                                    height: 40,
                                    width: ScreenSize(context).mainWidth / 2.1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: const Color(0xffE0FFE5),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Icon(
                                            FontAwesomeIcons.checkCircle,
                                            size: 12,
                                            color: Color(0xff37BB4E),
                                          ),
                                          Text(
                                            // "Order Confirmed",
                                            'Xác nhận đặt hàng',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff37BB4E),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                          Text(
                            orderHistory.orderShowData[0].tableName.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff160040),
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                // 'Order id: ',
                                'Mã số đơn đặt hàng: ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff160040),
                                ),
                              ),
                              Text(
                                orderHistory.orderShowData[0].orderId
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff160040),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Row(
                            children: [
                              const Text(
                                // 'Time: ',
                                'Thời gian: ',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff160040),
                                ),
                              ),
                              Text(
                                orderHistory.orderShowData[0].createdAt
                                    .toString(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff706881),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          const Text(
                            // 'Ordered Items',
                            'Các mặt hàng đã đặt hàng',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff160040),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: ScreenSize(context).mainHeight / 2.4,
                            color: Colors.grey.shade50,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: orderHistory
                                  .orderShowData[0].order!.items!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.blue.withOpacity(.01)),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.white,
                                  ),
                                  height: ScreenSize(context).mainHeight / 5.8,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          height: 85,
                                          width: 85,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.network(
                                              orderHistory
                                                  .orderShowData[0]
                                                  .order!
                                                  .items![index]
                                                  .menuItemImage
                                                  .toString(),
                                              fit: BoxFit.cover,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    color:
                                                        AppColor.primaryColor,
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
                                            height:
                                                ScreenSize(context).mainHeight /
                                                    5.7,
                                            color: Colors.white,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      orderHistory
                                                          .orderShowData[0]
                                                          .order!
                                                          .items![index]
                                                          .menuItemName
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xff160040),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                //variation
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      height: 14,
                                                      width: 62,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffF0F0F0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                          10,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          orderHistory
                                                              .orderShowData[0]
                                                              .order!
                                                              .items![index]
                                                              .menuItemVariation!
                                                              .name
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 8,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Color(
                                                                0xff160040),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
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
                                                      child: orderHistory
                                                              .orderShowData[0]
                                                              .order!
                                                              .items![index]
                                                              .options!
                                                              .isEmpty
                                                          ? Container()
                                                          : SizedBox(
                                                              height: 14,
                                                              width: ScreenSize(
                                                                          context)
                                                                      .mainWidth /
                                                                  1.8,
                                                              child: ListView
                                                                  .separated(
                                                                itemCount: orderHistory
                                                                    .orderShowData[
                                                                        0]
                                                                    .order!
                                                                    .items![
                                                                        index]
                                                                    .options!
                                                                    .length,
                                                                itemBuilder: (context,
                                                                        itemIndex) =>
                                                                    Container(
                                                                  height: 14,
                                                                  width: 60,
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
                                                                  child: Center(
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              4),
                                                                      child:
                                                                          Text(
                                                                        orderHistory
                                                                            .orderShowData[0]
                                                                            .order!
                                                                            .items![index]
                                                                            .options![itemIndex]
                                                                            .name
                                                                            .toString(),
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              8,
                                                                          fontWeight:
                                                                              FontWeight.w300,
                                                                          color:
                                                                              Color(0xff160040),
                                                                        ),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        maxLines:
                                                                            1,
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
                                                                    (BuildContext
                                                                            context,
                                                                        int index) {
                                                                  return const SizedBox(
                                                                    width: 3,
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                    ),
                                                    orderHistory
                                                            .orderShowData[0]
                                                            .order!
                                                            .items![index]
                                                            .options!
                                                            .isEmpty
                                                        ? Container()
                                                        : const Center(
                                                            child: Text(
                                                              '>',
                                                              style: TextStyle(
                                                                color: AppColor
                                                                    .primaryColor,
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 6,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      height: 25,
                                                      width: 80,
                                                      child: Center(
                                                        child: Text(
                                                          // 'Quantity: ${orderHistory.orderShowData[0].order!.items![index].quantity.toString()}',
                                                          'Số lượng: ${orderHistory.orderShowData[0].order!.items![index].quantity.toString()}',
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Color(
                                                                0xff160040),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 25,
                                                      child: Text(
                                                        orderHistory
                                                            .orderShowData[0]
                                                            .order!
                                                            .items![index]
                                                            .itemTotal
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
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
                                  //color: Colors.blue.withOpacity(.03),
                                  height: 5,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: ScreenSize(context).mainHeight / 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColor.primaryColor.withOpacity(.08),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    // 'Total Price',
                                    'Tổng giá',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    orderHistory.orderShowData[0].order!.total
                                        .toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: ScreenSize(context).mainWidth / 2,
                                height: 42,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    primary: Colors.white,
                                    onPrimary: AppColor.primaryColor,
                                    onSurface: AppColor.primaryColor,
                                    // background
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
                                    // "Back to Order",
                                    "Quay lại đặt hàng",
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
                      );
              })),
    );
  }
}
