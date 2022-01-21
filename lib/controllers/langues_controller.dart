// ignore_for_file: prefer_const_constructors, unused_local_variable, unnecessary_cast, unnecessary_overrides

import 'dart:ui';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './capitalize.dart';

class LanguesController extends GetxController {
  final isVisible = false.obs;
  final langue = 'En'.obs;
  final locales = [
    {'name': 'English', 'ab': 'En', 'locale': Locale('en', 'US')},
    {'name': 'Arabic', 'ab': 'Ar', 'locale': Locale('ar', 'MA')},
    {'name': 'Français', 'ab': 'Fr', 'locale': Locale('fr', 'FR')},
  ];

  SharedPreferences? preferences;

  @override
  void onClose() {
    super.onClose();
  }

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
    // toggleIsVisible();
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

  Locale checkLocalLanguage() {
    Locale myLocal =
        Locale(Get.deviceLocale!.languageCode, Get.deviceLocale!.countryCode);

    List locals = [];
    List langs = [];
    for (var element in locales) {
      locals.add(element['locale']);
      langs.add((element['locale'] as Locale).languageCode);
    }

    if (locals.contains(myLocal)) {
      return myLocal;
    } else if (langs.contains(myLocal.languageCode)) {
      if (myLocal.languageCode == 'ar') {
        return Locale(myLocal.languageCode, 'MA');
      }
      if (myLocal.languageCode == 'fr') {
        return Locale(myLocal.languageCode, 'FR');
      }
      if (myLocal.languageCode == 'en') {
        return Locale(myLocal.languageCode, 'US');
      }
    }

    return locals[0];
  }

  Locale getLocale() {
    String language = preferences?.getString('locale_language') ??
        checkLocalLanguage().languageCode;
    String? country = preferences?.getString('locale_country') ??
        checkLocalLanguage().countryCode;
    return Locale(language, country);
  }

  Future<void> initializePreference() async {
    preferences = await SharedPreferences.getInstance();
  }
}
