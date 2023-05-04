import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:waiter_app/logic/controller/profile_controller.dart';
import 'package:waiter_app/views/pages/profile/update_profile_page.dart';
import 'package:get/get.dart';
import 'package:waiter_app/views/widgets/custom_drawer.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);
  final ProfileController profileController = Get.put(ProfileController());
  final String password = '******';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Profile',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
        ),
        drawer: CustomDrawer(
          indexClicked: 0,
        ),
        body: GetBuilder<ProfileController>(
            init: ProfileController(),
            builder: (profile) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
                child: SizedBox(
                  height: ScreenSize(context).mainHeight / 2.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Container(
                          //   height: 80,
                          //   width: 80,
                          //   decoration: BoxDecoration(
                          //     borderRadius: BorderRadius.circular(50),
                          //     image: DecorationImage(
                          //       image: NetworkImage(profile.image.toString()),
                          //       fit: BoxFit.cover,
                          //     ),
                          //   ),
                          // ),
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: CachedNetworkImage(
                                height: 80,
                                width: 80,
                                imageUrl: profile.image.toString(),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          const SizedBox(
                            width: 12,
                          ),
                          Text(
                            profile.name.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color(0xff160040),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        // 'Phone',
                        'Điện thoại',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff706881),
                        ),
                      ),
                      Text(
                        profile.phone.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff160040),
                        ),
                      ),
                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff706881),
                        ),
                      ),
                      Text(
                        profile.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff160040),
                        ),
                      ),
                      const Text(
                        // 'Password',
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff706881),
                        ),
                      ),
                      Text(
                        password,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff160040),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 42,
                        width: double.infinity,
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
                            Get.to(() => UpdateProfilePage(
                                  name: profileController.name,
                                  phone: profileController.phone,
                                  email: profileController.email,
                                ));
                          },
                          child: const Text(
                            // "Edit Profile",
                            'Chỉnh sửa hồ sơ',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
