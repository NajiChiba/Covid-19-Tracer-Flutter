// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'dart:io';

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/controllers/udid_controller.dart';
import 'package:covid_19_tracer/models/contact.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_nearby_connections/flutter_nearby_connections.dart';
import 'package:get/get.dart';

class NearbyConnectionsController extends GetxController {
  static List<Device> devices = [];
  static List<Device> connectedDevices = [];
  static late NearbyService nearbyService;
  static late StreamSubscription subscription;
  static late StreamSubscription receivedDataSubscription;
  static List<Contact> contacts = QrController.contactDataList;
  static String udid = UdidController.myUdid.value;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  static void init() async {
    nearbyService = NearbyService();
    String devInfo = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      devInfo = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      devInfo = iosInfo.localizedModel;
    }
    await nearbyService.init(
        serviceType: 'mp-connection',
        deviceName: devInfo,
        strategy: Strategy.P2P_CLUSTER,
        callback: (isRunning) async {
          if (isRunning) {
            await nearbyService.stopAdvertisingPeer();
            await nearbyService.stopBrowsingForPeers();
            await Future.delayed(Duration(microseconds: 200));
            nearbyService.startAdvertisingPeer();
            await nearbyService.startBrowsingForPeers();
          }
        });
    subscription =
        nearbyService.stateChangedSubscription(callback: (devicesList) {
      devicesList.forEach((element) {
        print(
            " deviceId: ${element.deviceId} | deviceName: ${element.deviceName} | state: ${element.state}");

        print("========== CONTACTS LENGTH DETECT ===========");
        print(contacts.length);

        if (Platform.isAndroid) {
          if (element.state == SessionState.connected) {
            print("============> Device already connected !!! ");
            nearbyService.stopBrowsingForPeers();
          } else {
            nearbyService.startBrowsingForPeers();
          }
        }
      });

      devices.clear();
      devices.addAll(devicesList);

      devicesList.forEach((device) async {
        print("========== CONNECTION FUNCTION ========");
        print(device.deviceId);
        switch (device.state) {
          case SessionState.notConnected:
            await nearbyService.invitePeer(
              deviceID: device.deviceId,
              deviceName: device.deviceName,
            );
            print("=========== CONNECTED ==========");
            break;
          case SessionState.connected:
            nearbyService.sendMessage(device.deviceId, udid);
            print(
                "=========== MESSAGE - $udid -  SENT TO ${device.deviceId}  ==========");
            break;
          case SessionState.connecting:
            break;
        }
      });
    });

    receivedDataSubscription =
        nearbyService.dataReceivedSubscription(callback: (data) {
      // Add udid
      if (!contacts.contains(data["message"])) {
        //TODO: add to object box
        // contacts.add(data["message"]);

        QrController.addContact(Contact(id: 0, udid: data['message']));

        print(
            "==========================================================================");
        print("========== CONTACTS LENGTH RECEIVED MSG ===========");
        print("COUNT ${contacts.length}");
        print("UDID LIST");
        contacts.forEach((element) => print(element));
        // print("COUNT ${contacts.length}");
        print(
            "==========================================================================");
      }
    });
  }
}
