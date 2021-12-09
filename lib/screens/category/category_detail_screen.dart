import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';

class CategoryDetailScreen extends StatefulWidget {
  final Map_data_form data;
  const CategoryDetailScreen({Key? key, required this.data}) : super(key: key);
  
  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
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

  List<Marker> _markers = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId("marker"),
      position: widget.data.position,
    ));
  }

   @override
  Widget build(BuildContext context) {
    Map_data_form data = widget.data;
    return Scaffold(
      body: SafeArea(
        child: Container(
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
              height: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        data.name,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Image.asset(
                        'assets/map/safe.png',
                        width: 20.sp,
                      ),
                      Image.asset(
                        'assets/map/good.png',
                        width: 20.sp,
                      ),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '시설 정보',
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
                      return Column(
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
                      );
                  },
                ),
                )
              ),
              const Divider(
          color: Colors.black45,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '지도로 확인하기',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height*0.40, 
               child:
              Padding(
                padding: EdgeInsets.only(bottom: 10.w),
                child: GoogleMap(
                  
                mapType: MapType.normal,
                markers: Set.from(_markers),
                initialCameraPosition: CameraPosition(
                  target: data.position,
                  zoom: 14.4746,
                ),
                onCameraMove: (_) {},
                myLocationButtonEnabled: false,
              ),
              ),

               
              )
            ],
          ),
        ),
      ],
    ))]))));
  }
}