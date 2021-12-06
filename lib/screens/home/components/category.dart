import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/home/components/category_button.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 45.sp;
    double fontSize = 12.sp;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10.w, 0, 0, 10.h),
          child: Text(
            '카테고리',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GridView.count(
          primary: false, //scroll 없애기
          shrinkWrap: true,
          // physics: const ClampingScrollPhysics(),
          crossAxisCount: 4,
          childAspectRatio: Platform.isIOS ? 1.0 : 1.3,
          children: [
            CategoryButton(
              title: '놀이터',
              image: 'assets/home/playground.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '공원',
              image: 'assets/home/park.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '식당(놀이방)',
              image: 'assets/home/restaurant.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '키즈카페',
              image: 'assets/home/kidscafe.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '공공도서관',
              image: 'assets/home/library.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '박물관',
              image: 'assets/home/museum.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '휴양림',
              image: 'assets/home/tree.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
            CategoryButton(
              title: '기타시설',
              image: 'assets/home/more.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
