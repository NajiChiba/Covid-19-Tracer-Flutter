// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Cerificat extends StatelessWidget {
  final QrController qrController = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    qrController.initData();
    var qrList = qrController.qrDataList;

    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: height_,
          width: width_,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Cerificats',
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                  child: Obx(
                () => Container(
                    width: width_,
                    child: ListView.builder(
                      itemBuilder: (context, index) => Certif(qrList[index]),
                      itemCount: qrList.length,
                    )),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class Certif extends StatelessWidget {
  QrCode myQr;
  Certif(this.myQr);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(myQr.content as String),
      ),
    );
  }
}
