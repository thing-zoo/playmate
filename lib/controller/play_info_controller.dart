import 'package:get/get.dart';
import 'package:playmate/model/play_info.dart';
import 'package:playmate/repository/play_info_repository.dart';

class PlayInfoController extends GetxController {
  late PlayInfoRepository _playInfoRepository;
  Rx<PlayInfoModel> _playInfo1 = PlayInfoModel().obs;
  RxList<PlayInfoModel> _playInfos = <PlayInfoModel>[].obs;

  @override
  void onInit(){
    super.onInit();
    _playInfoRepository = PlayInfoRepository();
    fetchPlayInfo("키즈카페");
  }

  void fetchPlayInfo(String?name1) async{
    var result = await _playInfoRepository.fetchPlayInfo(name1:name1);
    if(result.isNotEmpty){
      _playInfos.addAll(result);
      _playInfo1(_playInfos.first);
    }
  }

  PlayInfoModel get playInfo1 => _playInfo1.value;
}