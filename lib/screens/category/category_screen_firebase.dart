import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class CategoryTestScreen extends StatefulWidget {
  const CategoryTestScreen({Key? key, required this.category_num}) : super(key: key);
  
  final String category_num;
  @override
  State<CategoryTestScreen> createState() => _CategoryTestScreenState();
}

class _CategoryTestScreenState extends State<CategoryTestScreen> {
  Firestore firestore = Firestore.instance;

  
  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("hello world"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              color: Colors.blue,
              child: Text("create button",style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 추가해준다.
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("read button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 읽어준다
                String title = "";
                firestore.collection("detail").document("101동 피로티").get().then((DocumentSnapshot ds){
                    title = ds.data["area"];
                    print(title);
                  });
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("update button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 갱신해준다.
              },
            ),
            FlatButton(
              color: Colors.blue,
              child: Text("delete button", style: TextStyle(color : Colors.white)),
              onPressed: (){
                //클릭시 데이터를 삭제해 준다.
              },
            ),
          ],
        ),
      ),
    );
  }
}