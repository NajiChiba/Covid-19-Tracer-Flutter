// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:covid_19_tracer/translation/app_transtaltion.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xFF5668F5)),
      home: const Home(),
      translations: AppTranslation(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
    );
  }
}
