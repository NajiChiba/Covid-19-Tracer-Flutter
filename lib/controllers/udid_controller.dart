// ignore_for_file: avoid_print, unnecessary_overrides, unused_local_variable, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UdidController extends GetxController {
  static RxString myUdid = ''.obs;
  static RxString myToken = ''.obs;
  static SharedPreferences? pref;

  @override
  void onInit() {
    initializePreference().whenComplete(() {
      checkTokenChanges();
    });
    super.onInit();
  }

  Future<void> initializePreference() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> getUdid() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var myDeviceInfo = await deviceInfoPlugin.androidInfo;
        myUdid(myDeviceInfo.androidId);
        // return myUdid.value;
      } else if (Platform.isIOS) {
        var myDeviceInfo = await deviceInfoPlugin.iosInfo;
        myUdid(myDeviceInfo.identifierForVendor);
        // return myUdid.value;
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
  }

  static getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    UdidController.myToken(token);
  }

  static Future<void> getDeviceInfo() async {
    await getToken();
    await getUdid();
  }

  static Future<void> sendDeviceInfoToServer() async {
    getDeviceInfo().then((_) => {
          http
              .post(Uri.parse('http://192.168.1.6:8000/api/v1/devices'),
                  headers: {
                    HttpHeaders.contentTypeHeader: 'application/json',
                  },
                  body: jsonEncode(
                      {"udid": myUdid.value, "token": myToken.value}))
              .then((res) => print(
                  "=============== Response STATUS CODE : ==> ${res.statusCode}"))
        });
    // final response =
  }

  static Future<void> checkTokenChanges() async {
    String? spToken = pref!.getString('token');
    var udid = pref!.getString('udid');

    getDeviceInfo().then((_) => {
          if (myToken != spToken)
            {
              sendDeviceInfoToServer(),
              pref!.setString("token", spToken as String)
            }
        });
  }
}
