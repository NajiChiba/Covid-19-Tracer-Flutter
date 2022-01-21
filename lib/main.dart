// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/screens/alertPage/alert_page.dart';
import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:covid_19_tracer/screens/onBoarding/on_boarding.dart';
import 'package:covid_19_tracer/screens/wallet/wallet.dart';
import 'package:covid_19_tracer/translation/app_transtaltion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // show onboard or no
  SharedPreferences preferences = await SharedPreferences.getInstance();
  final bool? onBoard = preferences.getBool('onBoard');
  Widget _screen =
      (onBoard == null || onBoard == false) ? OnBoarding() : Home();
  runApp(MyApp(_screen));
}

class MyApp extends StatelessWidget {
  final Widget _screen;
  MyApp(this._screen);
  final QrController qrController = Get.put(QrController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xFF5668F5)),
      home: _screen,
      translations: AppTranslation(),
      locale: Get.deviceLocale,
      debugShowCheckedModeBanner: false,
      routes: {
        "alertPage": (_) => AlertPage(),
        "wallet": (_) => Wallet(),
      },
    );
  }
}
