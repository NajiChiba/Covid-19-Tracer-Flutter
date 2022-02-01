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
  static final _contactDataList = <Contact>[].obs;
  var qrCodeBox = null;
  static var contactBox = null;
  var store = null;
  static var userName = ''.obs;

  static List<Contact> get contactDataList => _contactDataList;

  @override
  void onInit() {
    super.onInit();
    initializeQrOB();
  }

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

    // l'ajout la liste des qrcodes dans notre liste _qrDataList a partir de OB
    List<QrCode> qrLst = qrCodeBox.getAll();
    _qrDataList.assignAll(qrLst);

    // l'ajout la liste des contact dans notre liste _contactDataList a partir de l'OB
    List<Contact> contactLst = contactBox.getAll();
    _contactDataList.assignAll(contactLst);

    //
    initUserName();
  }

  // l'enregistrement du nom d'utilisateur
  static Future<void> initUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var un = pref.getString('user');
    print(un);
    userName(un);
  }

  // recuperation de la liste des qr-codes stockee dans object-box
  List<QrCode> get qrDataList {
    return _qrDataList;
  }

  // insertion un qr-code dans Object-Box
  void addQr(QrCode qrCode) {
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

  // suppression d'un qr-code
  void removeQr(QrCode qrCode) async {
    await qrCodeBox.remove(qrCode.id);
    _qrDataList.clear();
    _qrDataList.assignAll(qrCodeBox.getAll());
    _qrDataList.length;
  }

  // suppression de touts les qr-code
  void removeAll() async {
    try {
      await qrCodeBox.removeAll();
      _qrDataList.clear();
    } catch (e) {
      print(e);
    }
  }

  // recuperation de la liste des contact stockee dans object-box
  List<Contact> get contactList {
    return _contactDataList;
  }

  // inserer un contact dans l'OB
  static void addContact(Contact myContact) {
    // restartStore();
    try {
      if (myContact != null) {
        contactBox.put(myContact);
        _contactDataList.assignAll(contactBox.getAll());
      } else {
        print('Null $myContact');
      }
    } catch (e) {
      print(e);
    }
  }

  void checkTest(QrCode qrCode) {
    (qrCode.pcr as bool) ? sendContactListToServer() : null;
  }

  // envoyer les donnees au serveur
  Future<void> sendContactListToServer() async {
    try {
      http
          .post(
              Uri.parse(
                  "http://192.168.1.7:8000/api/v1/send-notif-after-positive"),
              headers: {
                HttpHeaders.contentTypeHeader: 'application/json',
              },
              body: jsonEncode({
                'contactList': _contactDataList.value
                    .map((contact) => {'udid': contact.udid})
                    .toList()
              }))
          .then((res) => {
                print("SEND RESPONSE STATUSCODE : ${res.statusCode}"),
                removeAllContacts()
              });
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

  // vider la liste des contact
  void removeAllContacts() async {
    try {
      await contactBox.removeAll();
      _contactDataList.clear();
    } catch (e) {
      print(e);
    }
  }
}
