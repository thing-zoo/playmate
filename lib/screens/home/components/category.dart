import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/playground.png',
                    width: iconSize,
                  ),
                  Text(
                    '놀이터',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/park.png',
                    width: iconSize,
                  ),
                  Text(
                    '공원',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/restaurant.png',
                    width: iconSize,
                  ),
                  Text(
                    '식당(놀이방)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/kidscafe.png',
                    width: iconSize,
                  ),
                  Text(
                    '키즈카페',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/library.png',
                    width: iconSize,
                  ),
                  Text(
                    '공공도서관',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/museum.png',
                    width: iconSize,
                  ),
                  Text(
                    '박물관/미술관',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/tree.png',
                    width: iconSize,
                  ),
                  Text(
                    '휴양림',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //이동하도록
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset(
                    'assets/home/more.png',
                    width: iconSize,
                  ),
                  Text(
                    '기타시설',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
