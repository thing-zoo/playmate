import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Poster extends StatelessWidget {
  const Poster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(color: Colors.black54),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.fromLTRB(10.w, 10.h, 0, 10.h),
          child: Text(
            '우리 지역의 어린이 행사는 무엇이 있을까?',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {},
              child: Image.asset(
                'assets/home/poster1.png',
                width: 120.sp,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Image.asset(
                'assets/home/poster2.png',
                width: 120.sp,
              ),
            ),
            // TextButton(
            //   onPressed: () {},
            //   child: Image.asset(
            //     'assets/home/poster2.png',
            //     width: 120.sp,
            //   ),
            // ),
          ],
        )
      ],
    );
  }
}
