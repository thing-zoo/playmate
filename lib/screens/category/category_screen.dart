import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:playmate/screens/category/category_detail_screen.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';
import 'package:playmate/screens/map/datas/map_datas.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as map;

class CategoryScreen extends StatefulWidget {
  final String category_name;
  final int category_num;

  const CategoryScreen(
      {Key? key, required this.category_num, required this.category_name})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  Firestore firestore = Firestore.instance;
  List<String> logoPicture = [
    "playground",
    "park",
    "restaurant",
    "kidscafe",
    "library",
    "museum",
    "tree",
    "more"
  ];

  List<Map_data_form> _map_datas = Map_datas().map_datas;
  List<double> _dists = [];
  final nowPos = map.LatLng(35.8847, 128.6111);
  int categoryNum = 0;

  double calcDist(map.LatLng calcPos) {
    double meter = Geolocator.distanceBetween(
      nowPos.latitude,
      nowPos.longitude,
      calcPos.latitude,
      calcPos.longitude,
    );
    return (meter / 1000);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String categoryName = widget.category_name;
    categoryNum = widget.category_num;
    _setDatas(widget.category_num);
  }

  _setDatas(categoryN) {
    List<Map_data_form> map_datas = [];
    List<Map_data_form> new_data = Map_datas().map_datas;
    List<double> dists = [];
    new_data.forEach((data) {
      if (data.categoryN == categoryN) {
        dists.add(calcDist(data.position));
        map_datas.add(data);
      }
    });
    setState(() {
      _map_datas = map_datas;
      _dists = dists;
      categoryNum = categoryN;
    });
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 25.sp;
    double fontSize = 15.sp;

    var _listView = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _map_datas.length,
      itemBuilder: (context, index) {
        if (_map_datas.length == 0) {
          return Text("데이터가 없습니다.");
        } else {
          return Row(
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryDetailScreen(data: _map_datas[index]),
                        ));
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 60.w,
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/map/${logoPicture[categoryNum]}.png',
                              width: 55.w,
                            ),
                            Text('${_dists[index].toStringAsFixed(1)} km'),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100.w,
                        width: 20.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _map_datas[index].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          Text(
                            _map_datas[index].arr,
                            style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                          Text(_map_datas[index].firstDate),
                        ],
                      ),
                    ],
                  )),
            ],
          );
        }
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo_light.png',
          width: 120.w,
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            height: 40.h,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                TextButton.icon(
                  onPressed: () {
                    //이동 동작
                    _setDatas(0);
                  },
                  icon: Image.asset(
                    'assets/home/playground.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '실외놀이터',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(1);
                  },
                  icon: Image.asset(
                    'assets/home/school.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '학교',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(2);
                  },
                  icon: Image.asset(
                    'assets/home/restaurant.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '식당(놀이방)',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(3);
                  },
                  icon: Image.asset(
                    'assets/home/kidscafe.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '키즈카페',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(4);
                  },
                  icon: Image.asset(
                    'assets/home/library.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '공공도서관',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(5);
                  },
                  icon: Image.asset(
                    'assets/home/museum.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '박물관/미술관',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(6);
                  },
                  icon: Image.asset(
                    'assets/home/mat.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '실내놀이터',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    _setDatas(7);
                  },
                  icon: Image.asset(
                    'assets/home/more.png',
                    width: iconSize,
                  ),
                  label: Text(
                    '기타시설',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: fontSize,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: _listView,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
            ),
          ),
        ],
      )),
    );
  }
}
