import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/logic/controller/category_controller.dart';
import 'package:waiter_app/logic/controller/search_menu_controller.dart';

import 'package:waiter_app/views/widgets/loader.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  final searchMenuController = Get.put(SearchMenuController());
  static String menuName = '';
  static int activeMenu = 0;
  final TextEditingController searchTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          // 'Search Item',
          'Mục tìm kiếm',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColor.primaryColor,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        controller: searchTextController,
                        textInputAction: TextInputAction.search,
                        keyboardType: TextInputType.text,
                        cursorColor: AppColor.primaryColor,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                            top: 0,
                            left: 15,
                          ),
                          // hintText: 'Search menu item',
                          hintText: 'mục menu tìm kiếm',
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                          prefixIcon: IconButton(
                            color: Colors.black,
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              //(context as Element).markNeedsBuild();
                            },
                          ),
                          fillColor: const Color(0xffF2CDD4),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: AppColor.primaryColor,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              width: 1,
                              color: Color(0xffF2CDD4),
                            ),
                          ),
                        ),
                        onFieldSubmitted: (value) {
                          menuName = value.toString();
                          searchMenuController.menuItem(menuName, null);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          // "Categories",
                          'Thể loại',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            activeMenu = 0;
                            (context as Element).markNeedsBuild();
                            searchMenuController.popularMenu();
                          },
                          child: const Text(
                            // "Clear All",
                            'Xóa tất cả',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColor.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GetBuilder<CategoryController>(
                        init: CategoryController(),
                        builder: (category) {
                          return SizedBox(
                            height: 30,
                            child: category.categoryData.isEmpty
                                ? Container()
                                : ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: category.categoryData.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          activeMenu =
                                              category.categoryData[index].id!;
                                          (context as Element).markNeedsBuild();
                                          searchMenuController.menuItem(
                                              null,
                                              category
                                                  .categoryData[index].title);
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: activeMenu !=
                                                    category
                                                        .categoryData[index].id
                                                ? Colors.blue.withOpacity(.03)
                                                : AppColor.primaryColor,
                                          ),
                                          child: Text(
                                            category.categoryData[index].title
                                                .toString(),
                                            style: TextStyle(
                                              color: activeMenu !=
                                                      category
                                                          .categoryData[index]
                                                          .id
                                                  ? const Color(0xff706881)
                                                  : Colors.white,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        width: 9,
                                      );
                                    },
                                  ),
                          );
                        }),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text(
                      // "Popular items",
                      'Mặt hàng phổ biến',
                      style: TextStyle(
                        color: Color(0xff160040),
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GetBuilder<SearchMenuController>(
                        init: SearchMenuController(),
                        builder: (popularMenu) {
                          return popularMenu.isLoading
                              ? Container(
                                  height: ScreenSize(context).mainHeight,
                                  width: ScreenSize(context).mainWidth,
                                  color: Colors.white60,
                                  child: const Center(child: Loader()))
                              : Container(
                                  height: ScreenSize(context).mainHeight / 1.7,
                                  color: Colors.grey.shade50,
                                  child: popularMenu.popularMenuData.isEmpty
                                      ? Container()
                                      : ListView.separated(
                                          itemCount: popularMenu
                                              .popularMenuData.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                popularMenu.menuItemAdd(
                                                    context,
                                                    popularMenu.popularMenuData[
                                                        index]);
                                              },
                                              child: Container(
                                                height: ScreenSize(context)
                                                        .mainHeight /
                                                    8.5,
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
                                                width: ScreenSize(context)
                                                        .mainWidth /
                                                    2.0,
                                                child: Row(
                                                  children: [
                                                    //item image
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        height: 70,
                                                        width: 70,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                          child: Image.network(
                                                            popularMenu
                                                                .popularMenuData[
                                                                    index]
                                                                .image
                                                                .toString(),
                                                            fit: BoxFit.cover,
                                                            loadingBuilder:
                                                                (BuildContext
                                                                        context,
                                                                    Widget
                                                                        child,
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
                                                    ),
                                                    //item description
                                                    SizedBox(
                                                      width: ScreenSize(context)
                                                              .mainWidth /
                                                          2.0,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            SizedBox(
                                                              width: ScreenSize(
                                                                          context)
                                                                      .mainWidth /
                                                                  1.7,
                                                              child: Text(
                                                                popularMenu
                                                                        .popularMenuData[
                                                                            index]
                                                                        .name
                                                                        .toString() +
                                                                    ' ( ' +
                                                                    popularMenu
                                                                        .popularMenuData[
                                                                            index]
                                                                        .menuNumber
                                                                        .toString() +
                                                                    ' )',
                                                                maxLines: 2,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: ScreenSize(
                                                                          context)
                                                                      .mainWidth /
                                                                  1.5,
                                                              child: Text(
                                                                '${popularMenu.popularMenuData[index].currencyCode}' +
                                                                    popularMenu
                                                                        .popularMenuData[
                                                                            index]
                                                                        .unitPrice
                                                                        .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    ElevatedButton(
                                                      onPressed: () {
                                                        popularMenu.menuItemAdd(
                                                            context,
                                                            popularMenu
                                                                    .popularMenuData[
                                                                index]);
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        minimumSize: Size
                                                            .zero, // Set this
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8,
                                                                right: 8,
                                                                top: 4,
                                                                bottom: 4),
                                                        primary: Colors
                                                            .white, // background
                                                        onPrimary: AppColor
                                                            .primaryColor,
                                                        // foreground
                                                        side: const BorderSide(
                                                          width: 1,
                                                          color:
                                                              Color(0xffEE1D48),
                                                        ),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  5), // <-- Radius
                                                        ),
                                                      ),
                                                      // child: const Text('Add'),
                                                      child: const Text('Thêm '),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Container(
                                              // color:
                                              //     Colors.blue.withOpacity(.08),
                                              height: 12,
                                            );
                                          },
                                        ),
                                );
                        }),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
