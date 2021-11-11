import 'package:flutter/material.dart';
import 'package:playmate/screens/map/map_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MapSearch extends StatelessWidget {
  const MapSearch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const MapScreen(),
            ));
      },
      icon: Icon(
        Icons.place,
        size: 70.w,
        color: Colors.lightGreen,
      ),
      label: Text(
        '지도로\n놀이시설 찾아보기',
        style: TextStyle(
          fontSize: 20.sp,
          color: Colors.black54,
        ),
      ),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.fromLTRB(30.w, 20.h, 40.w, 20.h),
        primary: Colors.lightGreen[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
    );
  }
}
