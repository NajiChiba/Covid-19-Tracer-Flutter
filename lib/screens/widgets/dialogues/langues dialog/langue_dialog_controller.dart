// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_cast

import 'dart:convert';
import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../capitalize.dart';

class LangueDialogController extends GetxController {
  final isVisible = false.obs;
  final langue = 'En'.obs;
  final locales = [
    {'name': 'English', 'ab': 'En', 'locale': Locale('en', 'US')},
    {'name': 'Arabic', 'ab': 'Ar', 'locale': Locale('ar', 'MA')},
  ];

  SharedPreferences? preferences;

  @override
  void onInit() {
    initializePreference().whenComplete(() {
      changeLangPref(getLocale());
    });
    super.onInit();
  }

  void toggleIsVisible() {
    isVisible(!(isVisible.value));
  }

  void changeLang(Map<String, Object> obj) {
    langue(obj['ab'] as String);
    changeLangPref(obj['locale'] as Locale);
    toggleIsVisible();
  }

  Future<void> changeLangPref(Locale locale) async {
    preferences = await SharedPreferences.getInstance();
    await preferences?.setString('locale_language', locale.languageCode);
    await preferences?.setString(
        'locale_country', locale.countryCode as String);
    Get.updateLocale(locale);
    String? lc2 = locale.languageCode as String?;
    langue(lc2.capitalize() as String);
  }

  Locale getLocale() {
    String language = preferences?.getString('locale_language') ?? 'en';
    String country = preferences?.getString('locale_country') ?? 'US';
    return Locale(language, country);
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }
}
