// ignore_for_file: unused_local_variable, prefer_final_fields

import 'package:covid_19_tracer/helpers/qr_data_objbox.dart';
import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:get/get.dart';

class QrController extends GetxController {
  var _qrDataList = [].obs;

  @override
  void onInit() {
    super.onInit();
    _qrDataList.assign(qr_data);
  }

  get qrDataList => _qrDataList;

  void addQr(QrCode qrCode) {
    qr_data.box.put(qrCode);
    _qrDataList.assign(qr_data.initData());
  }

  void removeQr(QrCode qrCode) async {
    await qr_data.box.remove(qrCode.id);
    _qrDataList.assign(qr_data.initData());
  }

  void initData() {
    var qrCode = QrCode(
        content: 'blablabla',
        pcr: true,
        date: DateTime.now(),
        type: 'pcr',
        id: 1);

    _qrDataList.assign(qrCode);
  }
}
