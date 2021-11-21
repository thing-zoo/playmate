import 'package:xml/xml.dart';
import '../utils/xml_utils.dart';

class PlayInfoModel{
  String? ciCode1;
  String? ciCode2;
  String? ciInstall;
  String? ciNaddr2;
  String? ciName;
  String? ciRaddr1;
  String? ciSeq;
  String? ciTakeover;
  String? ciZip;
  String? code1;
  String? code15;
  String? code2;
  String? code21;
  String? code3;
  String? code4;
  String? name1;
  String? name15;
  String? name2;
  String? name21;
  String? name3;
  String? name4;

  PlayInfoModel({
    this.ciCode1,
    this.ciCode2,
    this.ciInstall,
    this.ciNaddr2,
    this.ciName,
    this.ciRaddr1,
    this.ciSeq,
    this.ciTakeover,
    this.ciZip,
    this.code1,
    this.code15,
    this.code2,
    this.code21,
    this.code3,
    this.code4,
    this.name1,
    this.name15,
    this.name2,
    this.name21,
    this.name3,
    this.name4,
  });

  factory PlayInfoModel.fromXml(XmlElement xml){
    return PlayInfoModel(
      ciCode1 : XmlUtils.searchResult(xml, 'ciCode1'),
      ciCode2 : XmlUtils.searchResult(xml, 'ciCode2'),
      ciInstall : XmlUtils.searchResult(xml, 'ciInstall'),
      ciNaddr2 : XmlUtils.searchResult(xml, 'ciNaddr2'),
      ciName : XmlUtils.searchResult(xml, 'ciName'),
      ciRaddr1 : XmlUtils.searchResult(xml, 'ciRaddr1'),
      ciSeq : XmlUtils.searchResult(xml, 'ciSeq'),
      ciTakeover : XmlUtils.searchResult(xml, 'ciTakeover'),
      ciZip : XmlUtils.searchResult(xml, 'ciZip'),
      code1 : XmlUtils.searchResult(xml, 'code1'),
      code15 : XmlUtils.searchResult(xml, 'code15'),
      code2 : XmlUtils.searchResult(xml, 'code2'),
      code21 : XmlUtils.searchResult(xml, 'code21'),
      code3 : XmlUtils.searchResult(xml, 'code3'),
      code4 : XmlUtils.searchResult(xml, 'code4'),
      name1 : XmlUtils.searchResult(xml, 'name1'),
      name15 : XmlUtils.searchResult(xml, 'name15'),
      name2 : XmlUtils.searchResult(xml, 'name2'),
      name21 : XmlUtils.searchResult(xml, 'name21'),
      name3 : XmlUtils.searchResult(xml, 'name3'),
      name4 : XmlUtils.searchResult(xml, 'name4'),
    );
  }

  String get standardNameString => '시설이름 : $ciName';
}