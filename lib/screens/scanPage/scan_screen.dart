// ignore_for_file: avoid_init_to_null, unused_local_variable, prefer_const_constructors, avoid_print, import_of_legacy_library_into_null_safe, sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:io';
import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:covid_19_tracer/objectbox.g.dart';
import 'package:covid_19_tracer/screens/createCertificat/create_certificat.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_tools/qr_code_tools.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  var lastScan = null;
  QRViewController? controller;

  QrController qrController = Get.find();

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    double height_ = MediaQuery.of(context).size.height;
    double width_ = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height_,
        width: width_,
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderWidth: 10,
                  borderRadius: 12,
                  cutOutSize: width_ * 0.7,
                  borderColor: Colors.greenAccent),
            ),
            Positioned(
              top: height_ * 0.07,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: width_,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        child: Text('cancel'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles(
                          type: FileType.custom,
                          allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
                        );

                        if (result != null) {
                          String? code = await QrCodeToolsPlugin.decodeFrom(
                                  result.files.single.path.toString())
                              .onError((dynamic error, dynamic stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("No code found")));
                            return '';
                          }).then((code) {
                            if (code == '') {
                              return;
                            }
                            QrCode qrCode = QrCode(
                                content: code,
                                date: DateTime.now(),
                                type: 'qrCode',
                                id: 0);

                            Get.off(() => CreateCertificat(qrCode));
                          });
                        } else {
                          // User canceled the picker
                        }
                      },
                      child: Container(
                        child: Text('upload'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      final currentScan = DateTime.now();
      if (lastScan == null ||
          currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
        lastScan = currentScan;
        result = scanData;
        final query = qrController.qrCodeBox
            .query(QrCode_.content.equals(result!.code.toString()))
            .build();
        final qrCodes = query.find();
        if (qrCodes.length == 0) {
          QrCode qrCode = QrCode(
              content: result!.code,
              date: DateTime.now(),
              type: 'qrCode',
              id: 0);
          Get.off(() => CreateCertificat(qrCode));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Key already exists")));
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
