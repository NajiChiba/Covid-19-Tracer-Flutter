// ignore_for_file: avoid_print, unnecessary_overrides, unused_local_variable

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;

class UdidController extends GetxController {
  static RxString myUdid = ''.obs;
  static RxString myToken = ''.obs;

  static Future<String?> getUdid() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var myDeviceInfo = await deviceInfoPlugin.androidInfo;
        myUdid(myDeviceInfo.androidId);
        return myUdid.value;
      } else if (Platform.isIOS) {
        var myDeviceInfo = await deviceInfoPlugin.iosInfo;
        myUdid(myDeviceInfo.identifierForVendor);
        return myUdid.value;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  static getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    UdidController.myToken(token);
  }

  static Future<void> sendUdidToServer() async {
    getToken();
    getUdid();
    final response = await http
        .post(Uri.parse('http://10.0.2.2:8000/api/v1/svae'),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: jsonEncode({"udid": myUdid.value, "token": myToken.value}))
        .then((res) => print("=============== SET RESPONSE : ==> ${res.body}"));
  }

  // static setGetUdIdSP() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setBool('udid', true);
  // }

  @override
  void onInit() {
    super.onInit();
    getUdid()
        .then((udid) => print('================== $udid ================='));
  }
}
