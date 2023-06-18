import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ngetrip/controllers/main_controller.dart';
import 'package:ngetrip/core/colors.dart';
import 'package:ngetrip/core/themes.dart';
import 'package:ngetrip/pages/take_photo.dart';

class UploadCameraScreen extends StatefulWidget {
  const UploadCameraScreen({super.key});

  @override
  State<UploadCameraScreen> createState() => _UploadCameraScreenState();
}

class _UploadCameraScreenState extends State<UploadCameraScreen> {
  final controller = Get.find<MainController>();
  var place = Get.find<MainController>().place;
  List<File> images = [];

  void addImage(File file) {
    if (images.length > 2) {
      images.clear();
      images.add(file);
    } else {
      images.add(file);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: false,
        titleSpacing: 0,
        leadingWidth: 16,
        title: Text(
          place?.name ?? '',
          style: textBold14,
        ),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.close,
              color: AppColor.greyColor,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          Container(
            width: Get.width,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              boxShadow: appShadowSmooth,
              color: Colors.grey[200],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: Get.width / 2.5,
                      height: Get.width / 2.5,
                      decoration: BoxDecoration(
                        color: AppColor.greyColor,
                        image: images.isNotEmpty
                            ? DecorationImage(
                                image: FileImage(images.first),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: images.isEmpty
                          ? Icon(
                              Icons.add,
                              color: AppColor.greyFont,
                              size: 64,
                            )
                          : null,
                    ),
                    Container(
                      width: Get.width / 2.5,
                      height: Get.width / 2.5,
                      decoration: BoxDecoration(
                        color: AppColor.greyColor,
                        image: images.length > 1
                            ? DecorationImage(
                                image: FileImage(images.last),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: images.length < 2
                          ? Icon(
                              Icons.add,
                              color: AppColor.greyFont,
                              size: 64,
                            )
                          : null,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () async {
                    if (images.isNotEmpty) {
                      await controller.post(image: images);
                    }
                  },
                  child: Text(
                    'Post',
                    style: textPrimaryBold14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: [
              InkWell(
                onTap: () async {
                  File? file = await Get.to(() => TakePhotoView());
                  if (file != null) {
                    addImage(File(file.path));
                  }
                },
                child: Container(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.photo_camera,
                        color: AppColor.blackFont,
                      ),
                      Text(
                        'Camera',
                        style: text14,
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  var file = await controller.picker
                      .pickImage(source: ImageSource.gallery);
                  if (file != null) {
                    addImage(File(file.path));
                  }
                },
                child: Container(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.folder_open,
                        color: AppColor.blackFont,
                      ),
                      Text(
                        'Folder',
                        style: text14,
                      ),
                    ],
                  ),
                ),
              ),
              for (var item in (place?.thumbnails ?? <String>[]))
                Container(
                  width: Get.width / 4,
                  height: Get.width / 4,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor,
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(item),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
