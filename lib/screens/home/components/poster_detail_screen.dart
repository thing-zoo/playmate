import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class PosterDetailScreen extends StatefulWidget {
  const PosterDetailScreen({Key? key}) : super(key: key);
  
  @override
  State<PosterDetailScreen> createState() => _PosterDetailScreenState();
}

class _PosterDetailScreenState extends State<PosterDetailScreen> {
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
    padding: EdgeInsets.all(25.w),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Column(
          children: [
            //아이콘
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Image.asset(
                'assets/home/poster1.png',
                width: 220.w,
              ),
            ),
            //설명
            SizedBox(
              height: 200.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "[대구청년회의소] 아동백일장",
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      
                    ],
                  ),
                  Text(
                    "일시 : 2021년 5월 16일(수) 오후 2시"
                  ),
                  Text(
                    "장소 : 대구광역시교육청 교육연수원"
                  ), 
                  Text(
                    "참가대상 : 대구시내 초등학교 재학생(4~6학년) 40명"
                  ), 
                  Text(
                    "문의사항 : 대구청년회의소(053-0000-0000)"
                  ), 
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black45,
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.w, bottom: 10.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "대구청년회의소에서 제 55회 아동 백일장을 개최합니다."
              ),
              Text(
                "대구광역시장 표창 등 총 102개의 시상이 있을 예정입니다."
              ),
              Text(
                "대구광역시관내 학생 및 학부모님의 많은 관심 부탁드립니다."
              ),
              const Divider(
                color: Colors.black45,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green.shade50),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0)),)
                ),
                onPressed: () async {
                  const url = 'https://school.iamservice.net/articles/view/68585115?isReturnBodyJsp=true#';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                }, 
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/websiteIcon.png',
                    width: 20.w,
                  ),
                  Text(
                    '  웹사이트로 이동하기',
                      style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              )
            ],
          ),
        ),
      ],
    ))));
  }
}