// ignore_for_file: unused_local_variable, prefer_final_fields, unnecessary_cast, avoid_init_to_null, unnecessary_null_comparison, avoid_print

import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:get/get.dart';

import '../objectbox.g.dart';

class QrController extends GetxController {
  final _qrDataList = <QrCode>[].obs;
  var box = null;
  var store = null;

  @override
  void onInit() {
    super.onInit();
    initializeQrOB();
  }

  @override
  void onClose() {
    super.onClose();
    // store.close();
    print('============= onClose Store');
  }

  // initialiser l'object box
  Future<void> initializeQrOB() async {
    _qrDataList.clear();
    if (box == null && store == null) {
      print('============= open Store');
      store = await openStore();
      box = store.box<QrCode>();
    }

    List<QrCode> lst = box.getAll();

    // ajouter la liste des qrcodes dans notre liste _qrDataList a partir de l'OB
    _qrDataList.assignAll(lst);
  }

  // getter
  List<QrCode> get qrDataList {
    return _qrDataList;
  }

  // inserer un qrcode dans l'OB
  void addQr(QrCode qrCode) {
    try {
      if (qrCode != null) {
        box.put(qrCode);
        _qrDataList.assignAll(box.getAll());
      } else {
        print('Null $qrCode');
      }
    } catch (e) {
      // initializeQrOB();
      print(store);
    }
  }

  // supprimer qrcode
  void removeQr(QrCode qrCode) async {
    await box.remove(qrCode.id);
    _qrDataList.clear();
    _qrDataList.assignAll(box.getAll());
  }
}
