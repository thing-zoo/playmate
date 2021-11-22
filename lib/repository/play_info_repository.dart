import 'package:dio/dio.dart';
import 'package:xml/xml.dart';
import '../model/play_info.dart';

class PlayInfoRepository{
  late var _dio;
  PlayInfoRepository() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://openapi.cpf.go.kr', 
        queryParameters: {
          'ServiceKey' : 
            'gHibR78/zKSyCv+4Pri85/vdXaVaejCaX5XMVQpAht9v1cRA43CqklDyYyyNsXUiUIhoh0sqbiRTmNKASFakPQ==', //간단한 구현을 위해 이렇게 함. 원래는 확인된 데이터를 DB에 넣어놓고 쓰는 방식이 맞음
        },
      ),
    );
  }

  Future<List<PlayInfoModel>> fetchPlayInfo({String? code1}) async{
    var query = Map<String, String>();
    if(code1!=null) query.putIfAbsent('code1', () => code1);

    var res = await _dio.get(
      '/openapi/service/rest/ChildPlyFcltInfoService/getFcltInfo',
      queryParameters: query,
    );
    
    final document = XmlDocument.parse(res.data);
    final results = document.findAllElements('item');
    if(results.isNotEmpty){
      return results.map<PlayInfoModel>((element)=>PlayInfoModel.fromXml(element)).toList();
    }else{
      return Future.value(null);
    }
  }  
}