import 'package:get/get.dart';
import 'package:playmate/model/play_info.dart';
import 'package:playmate/repository/play_info_repository.dart';

class PlayInfoController extends GetxController {
  late PlayInfoRepository _playInfoRepository;
  Rx<PlayInfoModel> _playInfo1 = PlayInfoModel().obs;
  RxList<PlayInfoModel> _playInfos = <PlayInfoModel>[].obs;

  PlayInfoController(code1){
    _playInfoRepository = PlayInfoRepository();
    fetchPlayInfo(code1);
  }

  @override
  void onInit(){
    super.onInit();
    _playInfoRepository = PlayInfoRepository();
    fetchPlayInfo("A003");
  }

  void fetchPlayInfo(String?code1) async{
    var result = await _playInfoRepository.fetchPlayInfo(code1:code1);
    if(result!=null && result.isNotEmpty == true){
      _playInfos.addAll(result);
      _playInfo1(_playInfos.first);
    }
  }

  PlayInfoModel get playInfo1 => _playInfo1.value;
}