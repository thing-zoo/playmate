import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapCategoryButton extends StatelessWidget {
  const MapCategoryButton(
      {Key? key,
      required this.title,
      required this.image,
      required this.fontSize,
      required this.iconSize,
      this.onPressed})
      : super(key: key);
  final String title;
  final String image;
  final double iconSize;
  final double fontSize;
  final Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: ElevatedButton.icon(
        onPressed: () {
          onPressed;
        },
        icon: Image.asset(
          image,
          width: iconSize,
        ),
        label: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: fontSize,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
      ),
    );
  }
}
