import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/category/category_screen.dart';
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
              title: '실외놀이터',
              image: 'assets/home/playground.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 0, category_name: "실외놀이터"),
                    ));
              },
            ),
            CategoryButton(
              title: '학교',
              image: 'assets/home/school.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 1, category_name: "학교"),
                    ));
              },
            ),
            CategoryButton(
              title: '학교',
              image: 'assets/home/restaurant.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 2, category_name: "식당(놀이방)"),
                    ));
              },
            ),
            CategoryButton(
              title: '키즈카페',
              image: 'assets/home/kidscafe.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 3, category_name: "키즈카페"),
                    ));
              },
            ),
            CategoryButton(
              title: '공공도서관',
              image: 'assets/home/library.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 4, category_name: "공공도서관"),
                    ));
              },
            ),
            CategoryButton(
              title: '박물관/미술관',
              image: 'assets/home/museum.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 5, category_name: "박물관/미술관"),
                    ));
              },
            ),
            CategoryButton(
              title: '실내놀이터',
              image: 'assets/home/mat.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 6, category_name: "실내놀이터"),
                    ));
              },
            ),
            CategoryButton(
              title: '기타시설',
              image: 'assets/home/more.png',
              fontSize: fontSize,
              iconSize: iconSize,
              onPressed: () {
                //이동하도록
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CategoryScreen(
                          category_num: 7, category_name: "기타시설"),
                    ));
              },
            ),
          ],
        ),
      ],
    );
  }
}
