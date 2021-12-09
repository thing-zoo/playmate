import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:playmate/screens/category/category_detail_screen.dart';
import 'package:playmate/screens/map/datas/map_data_form.dart';
import 'package:playmate/screens/map/datas/map_datas.dart';

class CategoryScreen extends StatefulWidget {
  final String category_name;
  final int category_num;

  const CategoryScreen({Key? key, required this.category_num, required this.category_name}) : super(key: key);
  
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> logoPicture = ["playground", "park", "restaurant", "kidscafe", "library", "museum", "tree", "more"];
  List<Map_data_form> _map_datas = Map_datas().map_datas;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String categoryName = widget.category_name;
    _setDatas(widget.category_num);
  }

  _setDatas(categoryNum) {
    List<Map_data_form> map_datas = [];
    _map_datas.forEach((data){
      if(data.categoryN == categoryNum) map_datas.add(data);
    });
    setState(() {
      _map_datas = map_datas;
    });
  }

  @override
  Widget build(BuildContext context) {
    int categoryNum = widget.category_num;
    
    var _listView = ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: _map_datas.length,
      itemBuilder: (context, index){
        if(_map_datas.length == 0){
          return Text("데이터가 없습니다.");
        }else{
          return Row(
                children: [
                  TextButton(
                    onPressed:() {
                      Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoryDetailScreen(data : _map_datas[index]),
                      ));
                    }, 
                    child: Row(
                      children: [
                        Column(
                          children: [
                        Image.asset(
                        'assets/map/${logoPicture[categoryNum]}.png',
                        width: 55.w,
                        ),
                        Text("10m"),
                       ],),
                  SizedBox(
                    height: 10.w,
                    
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_map_datas[index].name),
                      Text(_map_datas[index].arr),
                      Text(_map_datas[index].firstDate),
                    ],
                  ),
                  
                      ],
                    )
                  ),                  
                ],
              );
        }
      }, 
      separatorBuilder: (BuildContext context, int index) { 
        return Divider();
      },
    );

    return Scaffold(
      
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Container(
                  child: _listView
                )
          ),
        ),
    );
  }
}