// ignore_for_file: avoid_print, unnecessary_overrides

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:device_info/device_info.dart';

class UdidController extends GetxController {
  RxString myUdid = ''.obs;

  Future<String?> getUdid() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var myDeviceInfo = await deviceInfoPlugin.androidInfo;
        myUdid(myDeviceInfo.androidId);
        print('udid: $myUdid');
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

  Future<void> sendUdidToServer() async {}

  @override
  void onInit() {
    super.onInit();
    getUdid();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
