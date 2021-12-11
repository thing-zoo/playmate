import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/screens/map/components/build_detail_sheet.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';
import 'package:playmate/screens/map/datas/map_datas.dart';
import 'dart:ui' as ui;
import 'package:playmate/screens/map/components/map_category_button.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final TextEditingController _filter = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  String _searchText = "";
  Firestore firestore = Firestore.instance;

  List<Map_data_form> map_datas = Map_datas().map_datas;
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

  //데이터 가져오기 & 초기작업
  void getFirebase() async {
    markerIcon.add(await getBytesFromAsset('assets/map/playground.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/park.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/restaurant.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/kidscafe.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/library.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/museum.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/tree.png', 130));
    markerIcon.add(await getBytesFromAsset('assets/map/more.png', 130));

    Map<String, int> categoryMap = {
      "A010": 0,
      "A002": 0,
      "A003": 0,
      "A024": 0,
      "A011": 1,
      "A004": 2,
      "A013": 3,
      "A021": 4,
      "A022": 5,
      "A008": 6,
      "A001": 7,
      "A023": 7,
      "A090": 7,
      "A091": 7
    };
    List<Map_data_form> getDatas = [];
    Map_data_form getTemp = Map_data_form();
    double lat, lng;
    List datas;
    int size;

    firestore
        .collection("areaToaNme")
        .document("대구 북구")
        .get()
        .then((DocumentSnapshot ds) {
      print("--------------------------DB--------------");
      datas = ds.data["playground"];
      size = ds.data["playground"].length;

      for (int i = 0; i < size; i++) {
        getTemp = Map_data_form();
        getTemp.name = datas[i]["ciName"];
        if (categoryMap.containsKey(datas[i]["category"]))
          getTemp.categoryN = categoryMap[datas[i]["category"]];

        lat = datas[i]["lat"];
        lng = datas[i]["lng"];
        getTemp.position = LatLng(lat, lng);

        if (getTemp.categoryN != null &&
            getTemp.name != null &&
            getTemp.position != null) {
          map_datas.add(getTemp);
        }
      }
      setCustomMapPin(9);
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
      builder: (BuildContext bc) {
        return Wrap(
          children: <Widget>[
            Container(
              child: buildDetailSheet(context, data),
            )
          ],
        );
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
    List<Marker> markers = [];
    for (var data in map_datas) {
      if (category == 9 || category == data.categoryN) {
        //print(data.categoryN);
        markers.add(Marker(
            markerId: MarkerId(data.name),
            draggable: false,
            onTap: () => {_showDetailSheet(context, data)},
            icon: BitmapDescriptor.fromBytes(markerIcon[data.categoryN]),
            position: data.position));
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
    getFirebase();
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
                        MapCategoryButton(
                          title: '실외놀이터',
                          image: 'assets/home/playground.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(0);
                          },
                        ),
                        MapCategoryButton(
                          title: '학교',
                          image: 'assets/home/school.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(1);
                          },
                        ),
                        MapCategoryButton(
                          title: '식당(놀이방)',
                          image: 'assets/home/restaurant.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(2);
                          },
                        ),
                        MapCategoryButton(
                          title: '키즈카페',
                          image: 'assets/home/kidscafe.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(3);
                          },
                        ),
                        MapCategoryButton(
                          title: '공공도서관',
                          image: 'assets/home/library.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(4);
                          },
                        ),
                        MapCategoryButton(
                          title: '박물관/미술관',
                          image: 'assets/home/museum.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(5);
                          },
                        ),
                        MapCategoryButton(
                          title: '실내놀이터',
                          image: 'assets/home/mat.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(6);
                          },
                        ),
                        MapCategoryButton(
                          title: '기타시설',
                          image: 'assets/home/more.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(7);
                          },
                        ),
                        MapCategoryButton(
                          title: '모두보기',
                          image: 'assets/home/all.png',
                          fontSize: fontSize,
                          iconSize: iconSize,
                          onPressed: () {
                            setCustomMapPin(9);
                          },
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
