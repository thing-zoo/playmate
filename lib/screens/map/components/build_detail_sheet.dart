import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';

Widget buildDetailSheet(BuildContext context, Map_data_form data) {
  List<String> logoPicture = ["playground", "park", "restaurant", "kidscafe", "library", "museum", "tree", "more"];
  Map<String, String> facilityPicture = {
    "미끄럼틀" : "slide",
    "그네" : "swing",
    "철봉" : "bar",
    "모래바닥재" : "sand",
    "회전놀이기구" : "rotation",
    "흔들놀이기구" : "swing2",
    "조합놀이대" : "jungle",
    "고무바닥재" : "rubber",
  };

  var index;

  

  return Padding(
    padding: EdgeInsets.all(25.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            //아이콘
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Image.asset(
                'assets/home/${logoPicture[data.categoryN]}.png',
                width: 90.w,
              ),
            ),
            //설명
            SizedBox(
              height: 120.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 240.w,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child : Text(
                              data.name,
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        ),
                      ),
                      data.insurnace ?
                      Image.asset(
                        'assets/map/safe.png',
                        width: 30.sp,
                      ) : SizedBox(),
                      data.good ?
                      Image.asset(
                        'assets/map/good.png',
                        width: 30.sp,
                      ) : SizedBox(),
                    ],
                  ),
                  Text(
                    data.arr,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '설치 일자 : ${data.firstDate}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '최근 점검 일자 : ${data.checkDate}',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black45,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '시설 정보',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.w),
                
                child: Container(
                  height: 150.0,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(10),
                    itemCount: data.facilityInfo.length,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width : 95.w,
                        child : Column(
                        children: [
                          Image.asset(
                            'assets/map/${facilityPicture[data.facilityInfo[index]]}.png',
                            width: 55.w,
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Text(data.facilityInfo[index])
                        ],
                      ));
                  },
                ),
                )
              ),
            ],
          ),
        ),
      ],
    ),
  );
}