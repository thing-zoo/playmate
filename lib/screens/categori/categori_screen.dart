import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playmate/controller/play_info_controller.dart';

class CategoriScreen extends GetView<PlayInfoController> {
  final String categoryname;

  const CategoriScreen({Key? key, required this.categoryname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.fetchPlayInfo(categoryname);
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Obx(
            () => Text(
              controller.playInfo1.standardNameString,
            ),
          ),
        ),
      ),
    );
  }
}
