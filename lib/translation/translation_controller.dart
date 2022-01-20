import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TranslationController extends GetxController {
  final locales = [
    {'name': 'English', 'locale': Locale('en', 'US')},
    {'name': 'Arabic', 'locale': Locale('ar', 'MA')},
    {'name': 'Frensh', 'locale': Locale('fr', 'FR')},
  ];

  void updateLocal(int index, BuildContext context) {
    Get.updateLocale(locales[index]['locale'] as Locale);
  }
}
