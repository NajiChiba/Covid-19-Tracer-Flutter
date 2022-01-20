// ignore_for_file: prefer_final_fields, unused_field, unnecessary_new, unused_local_variable, prefer_const_constructors

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class LocalNotificationService {
  // create notification
  static FlutterLocalNotificationsPlugin _notificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  // initialize notification
  static void initialize(BuildContext context) {
    // settings
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    // initialize
    _notificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? route) async {
      // on select notif function
      if (route != null) {
        print('=========== LocalNotification  $route');

        Get.toNamed(route);
        // Navigator.of(context).pushNamed(route);
      }
    });
  }

  // display the notif
  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      // create notif
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        "easyapproach",
        "easyapproach channel",
        importance: Importance.max,
        priority: Priority.high,
      ));

      // show
      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["route"], // onSelectNotification
      );
    } on Exception catch (e) {
      print(e);
    }
  }
}
