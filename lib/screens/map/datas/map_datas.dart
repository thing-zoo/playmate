import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';

class Map_datas{
  List<Map_data_form> map_datas = [];
  
  Map_datas(){ 
    map_datas.add(new Map_data_form(
      name:"대현 어린이공원 놀이터",
      arr:"대구 북구 대현동112-41",
      position: LatLng(35.8847749,128.6088774),
      category:"도시공원",
      categoryN: 0,
      facilityInfo: ["그네", "흔들놀이기구", "조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2006-06-25",
      checkDate: "2020-07-20",
    ));
    
    map_datas.add(new Map_data_form(
      name:"대현3 LH아파트 어린이놀이터",
      arr:"대구광역시 북구 대현남로6길 20\n(대현동, 대구대현엘에이치3단지)",
      position: LatLng(35.879864,128.6041938),
      category:"놀이터",
      categoryN: 0,
      facilityInfo: ["그네", "흔들놀이기구", "조합놀이대", "고무바닥재"],
      good: true,
      insurnace: true,
      firstDate: "2016-03-23",
      checkDate: "2020-03-16",
    ));
    
    map_datas.add(new Map_data_form(
      name:"임꺽정 숯불화로",
      arr:"대구광역시 북구 대현남로 40-1 (대현동)",
      position: LatLng(35.8815718,128.5987889),
      category:"식당(놀이방)",
      categoryN: 2,
      facilityInfo: ["흔들놀이기구", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2020-02-13",
      checkDate: "2020-04-21",
    ));
    
    map_datas.add(new Map_data_form(
      name:"대현휴먼시아 어린이 놀이터",
      arr:"대구광역시 북구 대현남로 25\n(대현동, 대현휴먼시아2단지)",
      position: LatLng(35.8816567,128.5964942),
      category:"놀이터",
      categoryN: 0,
      facilityInfo: ["조합놀이대","미끄럼틀","흔들놀이기구", "모래바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2010-08-05",
      checkDate: "2020-07-09",
    ));
    
    map_datas.add(new Map_data_form(
      name:"대현뜨란채아파트 놀이시설",
      arr:"대구광역시 북구 대현남로 28 (대현동)",
      position: LatLng(35.8801571,128.5974657),
      category:"놀이터",
      categoryN: 0,
      facilityInfo: ["흔들놀이기구", "조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2006-04-23",
      checkDate: "2020-12-07",
    ));

    map_datas.add(new Map_data_form(
      name:"침산하늘채 어린이공원 놀이터",
      arr:"대구 북구 침산동105-87",
      position: LatLng(35.8848472,128.5865487),
      category:"도시공원",
      categoryN: 1,
      facilityInfo: ["조합놀이대", "모래바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2006-04-28",
      checkDate: "2020-06-23",
    ));
    map_datas.add(new Map_data_form(
      name:"그린빌2단지 어린이놀이터",
      arr:"대구 북구 침산동105-87",
      position: LatLng(35.940205, 128.564474),
      category:"놀이터",
      categoryN: 0,
      facilityInfo: ["조합놀이대", "모래바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2008-03-28",
      checkDate: "2020-06-23",
    ));

    map_datas.add(new Map_data_form(
      name:"노원보성타운 어린이놀이터",
      arr:"대구 북구 침산동105-87",
      position: LatLng(35.8896582,128.5737296),
      category:"놀이터",
      categoryN: 0,
      facilityInfo: ["조합놀이대", "모래바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2010-04-28",
      checkDate: "2020-06-23",
    ));

    map_datas.add(new Map_data_form(
      name:"라라코스트 침산점 실내놀이터",
      arr:"대구광역시 북구 침산남로 96 (침산동)2층",
      position: LatLng(35.8889516, 128.586259),
      category:"식당",
      categoryN: 2,
      facilityInfo: ["조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2014-05-15",
      checkDate: "2020-05-14",
    ));

    map_datas.add(new Map_data_form(
      name:"누리마을복현점놀이시설",
      arr:"대구광역시 북구 공항로 9 (복현동)",
      position: LatLng(35.8981871,128.616103),
      category:"식당",
      categoryN: 2,
      facilityInfo: ["조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2016-04-01",
      checkDate: "2020-06-23",
    ));
    map_datas.add(new Map_data_form(
      name:"대박집경대점 실내놀이터",
      arr:"대구광역시 북구 대학로 144 (복현동)",
      position: LatLng(35.8964108, 128.614173),
      category:"식당",
      categoryN: 2,
      facilityInfo: ["조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2012-12-17",
      checkDate: "2020-04-09",
    ));
    map_datas.add(new Map_data_form(
      name:"정다운갈비",
      arr:"대구광역시 북구 성북로9길 9 (침산동)1,2층",
      position: LatLng(35.8922118, 128.587775),
      category:"식당",
      categoryN: 2,
      facilityInfo: ["조합놀이대", "고무바닥재"],
      good: false,
      insurnace: true,
      firstDate: "2017-12-08",
      checkDate: "2020-06-23",
    ));
  }
}