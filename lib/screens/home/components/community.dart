import 'package:flutter/material.dart';
import 'package:playmate/screens/home/components/community_screen.dart';
import 'package:playmate/screens/map/map_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Community extends StatelessWidget {
  const Community({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CommunityScreen(),
            ));
      },
      icon: Icon(
        Icons.textsms,
        size: 70.w,
        color: Colors.lightGreen,
      ),
      label: Text(
        '커뮤니티',
        style: TextStyle(
          fontSize: 15.sp,
          color: Colors.black54,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 20.w, 10.h),
        primary: Colors.lightGreen[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
