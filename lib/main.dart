import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playmate/controller/play_info_controller.dart';
import 'package:playmate/screens/home/home_screen.dart';
import 'package:playmate/screens/splash_screen.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Init.instance.initialize(),
      builder: (context, AsyncSnapshot snapshot) {
        // Show splash screen while waiting for app resources to load:
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ScreenUtilInit(
            designSize:
                Platform.isIOS ? const Size(360, 690) : const Size(460, 690),
            builder: () => const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Splash(),
            ),
          );
        } else {
          // Loading is done, return the app:
          return ScreenUtilInit(
            designSize:
                Platform.isIOS ? const Size(360, 690) : const Size(460, 690),
            builder: () => GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'PLAYMATE',
              initialBinding : BindingsBuilder((){
                Get.put(PlayInfoController());
              }),
              theme: ThemeData(
                primarySwatch: Colors.lightGreen,
                // textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
              ),
              builder: (context, widget) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!,
                );
              },
              home: const HomeScreen(),
            ),
          );
        }
      },
    );
  }
}
