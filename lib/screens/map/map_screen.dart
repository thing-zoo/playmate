import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/map/components/build_detail_sheet.dart';
import 'package:playmate/screens/map/components/map_category_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _filter = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final Completer<GoogleMapController> _controller = Completer();

  //초기 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: const LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //상세 페이지
  _showDetailSheet(context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: buildDetailSheet,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  @override
  void initState() {
    //상태바 투명하게
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double iconSize = 25.sp;
    double fontSize = 15.sp;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //이렇게 호출하면됨,,
          _showDetailSheet(context);
        },
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            Positioned.fill(
              child: GoogleMap(
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
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
                        MapCategoryButton(
                          title: '놀이터',
                          image: 'assets/home/playground.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '공원',
                          image: 'assets/home/park.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '식당(놀이방)',
                          image: 'assets/home/restaurant.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '키즈카페',
                          image: 'assets/home/kidscafe.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '공공도서관',
                          image: 'assets/home/library.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '박물관/미술관',
                          image: 'assets/home/museum.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '휴양림',
                          image: 'assets/home/tree.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '공원',
                          image: 'assets/home/park.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
                        ),
                        MapCategoryButton(
                          title: '기타시설',
                          image: 'assets/home/more.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {},
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
