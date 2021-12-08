import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import './map_body.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _filter = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        //필터가 변화를 감지하여 텍스트 변경
        _searchText = _filter.text;
      });
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  //초기위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    //네비바 숨기기
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top],
    );
    //상태바 투명하게
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  void dispose() {
    //둘다 보이게
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 25.sp;
    double fontSize = 15.sp;

    return Scaffold(
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: 
              GoogleMapBody(),
              // GoogleMap(
              //   initialCameraPosition: _kGooglePlex,
              //   onMapCreated: (GoogleMapController controller) {
              //     _controller.complete(controller);
              //   },
              // ),
            ),
            Positioned.fill(
              top: Platform.isIOS ? 35 : 20,
              child: Column(
                children: [
                  /* 검색창 */
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(20.w),
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _filter,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: '동네를 검색해보세요!',
                        prefixIcon: Icon(Icons.search),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                  /* 카테고리 버튼리스트 */
                  Container(
                    height: 30.h,
                    padding: EdgeInsets.only(left: 20.w),
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              //이동 동작
                            },
                            icon: Image.asset(
                              'assets/home/playground.png',
                              width: iconSize,
                            ),
                            label: Text(
                              '놀이터',
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/home/park.png',
                              width: iconSize,
                            ),
                            label: Text(
                              '공원',
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: Image.asset(
                              'assets/home/tree.png',
                              width: iconSize,
                            ),
                            label: Text(
                              '휴양림',
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
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {},
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
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
