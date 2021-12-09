import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/map/components/build_detail_sheet.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';
import 'package:playmate/screens/map/datas/map_datas.dart';
import 'dart:ui' as ui;

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _filter = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchText = "";

  List<Map_data_form> map_datas = new Map_datas().map_datas;
  static const LatLng now_pos = LatLng(35.8847, 128.6111);
  List<Marker> _markers = [];
  List<Uint8List> markerIcon = [];

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
    target: now_pos,
    zoom: 14.4746,
  );

  //상세 페이지 호출함수
  _showDetailSheet(context, data) {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (BuildContext bc){
        return Wrap(children: <Widget>[
          Container(
            child: buildDetailSheet(context, data),
          )
        ],);
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
    );
  }

  void setCustomMapPin(int category) async {
   markerIcon.add(await getBytesFromAsset('assets/map/playground.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/park.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/restaurant.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/kidscafe.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/library.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/museum.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/tree.png', 130));
   markerIcon.add(await getBytesFromAsset('assets/map/more.png', 130));

  List<Marker> markers = [];
  for (var data in map_datas) {
    if(category==9 || category==data.categoryN){
      markers.add(Marker(
          markerId: MarkerId(data.name),
          draggable: false,
          onTap: () => {
            _showDetailSheet(context, data)
          },
          icon: BitmapDescriptor.fromBytes(markerIcon[data.categoryN]),
          position: data.position
      ));
    }
  }

  setState(() {
    _markers = markers;
  });
}

	Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    setCustomMapPin(9);
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
              child: GoogleMap(
                mapType: MapType.normal,
                markers: Set.of(_markers),
                initialCameraPosition: _kGooglePlex,
                onCameraMove: (_) {},
                myLocationButtonEnabled: false,
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
                        Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: ElevatedButton.icon(
                            onPressed: () {
                              //이동 동작
                              setCustomMapPin(0);
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
                            onPressed: () {
                              setCustomMapPin(1);
                            },
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
                            onPressed: () {
                              setCustomMapPin(2);
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
                            onPressed: () {
                              setCustomMapPin(3);
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
                            onPressed: () {
                              setCustomMapPin(4);
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
                            onPressed: () {
                              setCustomMapPin(5);
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
                            onPressed: () {
                              setCustomMapPin(6);
                            },
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
                            onPressed: () {
                              setCustomMapPin(7);
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
                            onPressed: () {
                              setCustomMapPin(9);
                            },
                            icon: Image.asset(
                              'assets/home/more.png',
                              width: iconSize,
                            ),
                            label: Text(
                              '모두 보기',
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
