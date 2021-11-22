import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:playmate/controller/play_info_controller.dart';

class CategoriScreen extends StatelessWidget {
  final String categorycode;

  const CategoriScreen({Key? key, required this.categorycode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //controller.fetchPlayInfo(categoryname);
    PlayInfoController controller = PlayInfoController(categorycode);
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
