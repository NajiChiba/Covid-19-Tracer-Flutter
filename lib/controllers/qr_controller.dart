// ignore_for_file: unused_local_variable, prefer_final_fields, unnecessary_cast

import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:get/get.dart';

import '../objectbox.g.dart';

class QrController extends GetxController {
  final _qrDataList = <QrCode>[].obs;
  var box = null;

  @override
  void onInit() {
    super.onInit();
    initializeQrOB();
  }

  Future<void> initializeQrOB() async {
    if (box == null) {
      final store = await openStore();
      box = store.box<QrCode>();
    }
    List<QrCode> lst = box.getAll();
    _qrDataList.assignAll(lst);
  }

  List<QrCode> get qrDataList {
    return _qrDataList;
  }

  void addQr(QrCode qrCode) {
    if (qrCode != null) {
      box.put(qrCode);
      _qrDataList.assignAll(box.getAll());
    } else {
      print('Null $qrCode');
    }
  }

  void removeQr(QrCode qrCode) async {
    await box.remove(qrCode.id);
    _qrDataList.assign(box.getAll());
  }
}
