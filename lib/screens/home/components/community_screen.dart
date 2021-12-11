import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);
  
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<String> contents = [
    "Q. 대현동 늦게까지 보육가능한 유치원이나 놀이시설 추천 가능한가요~?^^",
    "Q. 회원님들~~ 아이 옷 보통 어디서 구매하시나용~?",
    "침산동 근교에 놀이시설 있는 식당 아시는분~~ 정보좀 주세요^^ 생일이라 외식좀 하고싶은데ㅜ 맘편히 밥 좀 한 번 먹고싶어서요;;",
    "아이유, 윤하 킬링보이스 들어보세요~~"
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextButton(
            onPressed: (){
              Navigator.pop(context);
            }, 
            child: Image.asset(
          'assets/logo.png',
          width: 120.w,
        ),),
        elevation:0.0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(

            scrollDirection: Axis.vertical,
            itemCount: contents.length,
            itemBuilder: (context, index){
              return(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "정보",
                        style: TextStyle(
                          backgroundColor: Colors.grey.shade200,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 120.w,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Text(contents[index]),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline
                        ),
                        Icon(
                          Icons.favorite_border
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 8,
                      color: Colors.grey[250],
                    )
                  ],
                )
              );
            }
          ),
      )));
  }
}