// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:waiter_app/constants/constants.dart';
import 'package:get/get.dart';
import 'package:waiter_app/logic/controller/profile_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waiter_app/views/widgets/loader.dart';

class UpdateProfilePage extends StatelessWidget {
  UpdateProfilePage({Key? key, this.name, this.phone, this.email})
      : super(key: key);
  String? name;
  String? phone;
  String? email;

  ProfileController profileController = Get.put(ProfileController());
  final _formKey = GlobalKey<FormState>();
  File? _image;

  @override
  Widget build(BuildContext context) {
    Future getImage() async {
      var image = await ImagePicker().pickImage(source: ImageSource.gallery);
      _image = File(image!.path);
      (context as Element).markNeedsBuild();
    }

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: const Text(
              // 'Update Profile',
              'Cập nhật hồ sơ',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            centerTitle: true,
            backgroundColor: AppColor.primaryColor,
          ),
          body: GetBuilder<ProfileController>(
              init: ProfileController(),
              builder: (profile) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                      child: Column(children: [
                    Center(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: ScreenSize(context).mainHeight / 5.2,
                            width: double.infinity,
                            child: Stack(
                              children: [
                                Positioned(
                                  right: ScreenSize(context).mainWidth / 4,
                                  child: CircleAvatar(
                                    radius: 68,
                                    backgroundColor: AppColor.primaryColor,
                                    child: ClipOval(
                                      child: SizedBox(
                                          width: 133.0,
                                          height: 133.0,
                                          child: (_image != null)
                                              ? Image.file(
                                                  _image!,
                                                  fit: BoxFit.fill,
                                                )
                                              : Image.network(
                                                  profile.image,
                                                  fit: BoxFit.fill,
                                                )),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  right: ScreenSize(context).mainWidth / 3.4,
                                  top: ScreenSize(context).mainHeight / 6.7,
                                  child: GestureDetector(
                                    onTap: () {
                                      getImage();
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(50),
                                        image: DecorationImage(
                                          image: AssetImage(
                                            Images.editPic,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  // 'Name',
                                  'Tên',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xff160040),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 68,
                                  child: TextFormField(
                                    controller: profile.nameController
                                      ..text = name.toString()
                                      ..selection = TextSelection.collapsed(
                                          offset: profile
                                              .nameController.text.length),
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      name = value!.trim();
                                    },
                                    onChanged: (value) {
                                      name = value;
                                    },
                                    keyboardType: TextInputType.text,
                                    cursorColor: AppColor.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 0,
                                        left: 15,
                                      ),
                                      fillColor: const Color(0xffF2CDD4),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xffF2CDD4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  // 'Phone',
                                  'Điện thoại',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xff160040),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 68,
                                  child: TextFormField(
                                    controller: profile.phoneController
                                      ..text = phone.toString()
                                      ..selection = TextSelection.collapsed(
                                          offset: profile
                                              .phoneController.text.length),
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      phone = value!.trim();
                                    },
                                    onChanged: (value) {
                                      phone = value;
                                    },
                                    keyboardType: TextInputType.number,
                                    cursorColor: AppColor.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 0,
                                        left: 15,
                                      ),
                                      fillColor: const Color(0xffF2CDD4),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xffF2CDD4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Email',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12,
                                    color: Color(0xff160040),
                                  ),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                SizedBox(
                                  height: 68,
                                  child: TextFormField(
                                    controller: profile.emailController
                                      ..text = email.toString()
                                      ..selection = TextSelection.collapsed(
                                          offset: profile
                                              .emailController.text.length),
                                    textInputAction: TextInputAction.done,
                                    validator: (value) {
                                      email = value!.trim();
                                    },
                                    onChanged: (value) {
                                      email = value;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: AppColor.primaryColor,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.only(
                                        top: 0,
                                        left: 15,
                                      ),
                                      fillColor: const Color(0xffF2CDD4),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: AppColor.primaryColor,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        borderSide: const BorderSide(
                                          width: 1,
                                          color: Color(0xffF2CDD4),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 45,
                            width: double.infinity,
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
                                if (_image == null) {
                                  profile.updateUserProfile(
                                      context: context,
                                      filepath: profile.image,
                                      type: false);
                                } else {
                                  profile.updateUserProfile(
                                      context: context,
                                      filepath: _image!.path,
                                      type: true);
                                }
                              },
                              child: const Text(
                                // 'Update',
                                'Cập nhật',
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
                    profile.isLoading
                        ? Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white60,
                            child: const Center(child: Loader()))
                        : const SizedBox.shrink(),
                  ])),
                );
              })),
    );
  }
}
