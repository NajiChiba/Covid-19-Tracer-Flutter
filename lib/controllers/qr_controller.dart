// ignore_for_file: unused_local_variable, prefer_final_fields, unnecessary_cast, avoid_init_to_null, unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:covid_19_tracer/models/contact.dart';
import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../objectbox.g.dart';
import 'package:http/http.dart' as http;

class QrController extends GetxController {
  final _qrDataList = <QrCode>[].obs;
  final _contactDataList = <Contact>[].obs;
  var qrCodeBox = null;
  var contactBox = null;
  var store = null;
  static var userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    initializeQrOB();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  //   store.close();
  //   print('============= onClose Store');
  // }

  // initialiser l'object qrCodeBox
  Future<void> initializeQrOB() async {
    _qrDataList.clear();
    _contactDataList.clear();

    if (store == null) {
      print('============= open Store');
      store = await openStore();
      qrCodeBox = store.box<QrCode>();
      contactBox = store.box<Contact>();
    }

    // ajouter la liste des qrcodes dans notre liste _qrDataList a partir de l'OB
    List<QrCode> qrLst = qrCodeBox.getAll();
    _qrDataList.assignAll(qrLst);

    // ajouter la liste des contact dans notre liste _contactDataList a partir de l'OB
    List<Contact> contactLst = contactBox.getAll();
    _contactDataList.assignAll(contactLst);

    //
    initUserName();
  }

  static Future<void> initUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var un = pref.getString('user');

    print('=================== SET NAME ONBOARDING =====================');
    print("=========================================");
    print(un);
    print("=========================================");
    userName(un);
  }

  // get qrDataList
  List<QrCode> get qrDataList {
    return _qrDataList;
  }

  // inserer un qrcode dans l'OB
  void addQr(QrCode qrCode) {
    // restartStore();
    try {
      if (qrCode != null) {
        qrCodeBox.put(qrCode);
        _qrDataList.assignAll(qrCodeBox.getAll());
        checkTest(qrCode);
      } else {
        print('Null $qrCode');
      }
    } catch (e) {
      print("================== add QR catch");
    }
  }

  // supprimer qrcode
  void removeQr(QrCode qrCode) async {
    await qrCodeBox.remove(qrCode.id);
    _qrDataList.clear();
    _qrDataList.assignAll(qrCodeBox.getAll());
    _qrDataList.length;
  }

  //
  void removeAll() async {
    try {
      await qrCodeBox.removeAll();
      _qrDataList.clear();
    } catch (e) {
      print(e);
    }
  }

  List<Contact> get contactList {
    return _contactDataList;
  }

  // inserer un contact dans l'OB
  void addContact(Contact myContact) {
    // restartStore();
    try {
      if (myContact != null) {
        contactBox.put(myContact);
        _contactDataList.assignAll(contactBox.getAll());
      } else {
        print('Null $myContact');
      }
    } catch (e) {
      print("================== add Contact catch");
    }
  }

  void checkTest(QrCode qrCode) {
    (qrCode.pcr as bool) ? sendContactListToServer() : null;
  }

  // send data to the server
  Future<void> sendContactListToServer() async {
    // post _contactDataList to the server
    try {
      http
          .post(
              Uri.parse(
                  "http://192.168.1.6:8000/api/v1/send-notif-after-positive"),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
              },
              body: jsonEncode({
                // TODO: send _contactDataList
                'contactList': [
                  {"udid": "5f1b34b0b5a912e8"},
                ],
              }))
          .then((res) => print(
              "=============== SEND RESPONSE STATUSCODE : ==> ${res.statusCode}"));
    } catch (e) {
      print(e);
    }
  }

  // supprimer contact
  void removeContact(Contact myContact) async {
    await contactBox.remove(myContact.id);
    _contactDataList.clear();
    _contactDataList.assignAll(contactBox.getAll());
  }
}
