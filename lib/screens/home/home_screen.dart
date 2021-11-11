import 'package:flutter/material.dart';
import 'package:playmate/screens/home/components/category.dart';
import 'package:playmate/screens/home/components/map_search.dart';
import 'package:playmate/screens/home/components/poster.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/logo.png',
                  width: 120.w,
                ),
              ),
              const MapSearch(),
              const Category(),
              const Poster(),
            ],
          ),
        ),
      ),
    );
  }
}
