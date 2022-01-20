// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable, unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print, library_prefixes

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/models/qr_code.dart' as myQ;
import 'package:covid_19_tracer/screens/certificat_details/certificat_details.dart';
import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:covid_19_tracer/screens/scan_page/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Wallet extends StatelessWidget {
  final QrController qrController = Get.find();

  @override
  Widget build(BuildContext context) {
    var qrList = qrController.qrDataList;

    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;
    List itm = [1, 2, 3, 4];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ScanPage());
        },
        backgroundColor: Colors.transparent,
        elevation: 4,
        child: Container(
          width: width_,
          height: height_,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF5063FF),
                  Color(0xFF5F6EE3),
                ]),
          ),
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: Color(0xFFF8F9FF),
      body: Container(
        width: width_,
        height: height_,
        child: Stack(children: [
          Positioned(
            top: height_ * 0.22,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: height_ * 0.8,
              width: width_,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Obx(() {
                      return Column(
                        children: (qrList.isEmpty)
                            ? [
                                SizedBox(
                                  height: height_ * 0.1,
                                ),
                                Center(
                                  child: Text(
                                    "add_certif".tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 23,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF4755BE)),
                                  ),
                                ),
                                SizedBox(
                                  height: height_ * 0.09,
                                ),
                                Container(
                                  height: height_ * 0.3,
                                  child: SvgPicture.asset(
                                      "assets/svgs/add_data.svg"),
                                )
                              ]
                            : qrList.reversed.map((e) => Certif(e)).toList(),
                      );
                    }),
                    SizedBox(
                      height: 80,
                    )
                  ],
                ),
              ),
            ),
          ),
          // app bar
          customAppBar(width_, height_),
        ]),
        // body
      ),
    );
  }

  Widget customAppBar(double width_, double height_) {
    return Container(
      height: height_ * 0.25,
      width: width_,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/appbar.png"),
              fit: BoxFit.cover)),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () {
                Get.to(() => Home());
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 34,
              ),
            ),
          ),
          Expanded(
            flex: 7,
            child: Center(
              child: Text(
                'wallet'.tr,
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Expanded(flex: 1, child: SizedBox()),
        ],
      ),
    );
  }
}

class Certif extends StatelessWidget {
  myQ.QrCode qrCode;
  Certif(this.qrCode);

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;

    TextStyle ts = GoogleFonts.poppins(
      fontSize: 18,
    );

    return Container(
      margin: EdgeInsets.only(top: 30),
      width: width_,
      height: (height_ < 684) ? height_ * 0.38 : height_ * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Color(0xFF5668F5).withOpacity(0.1), blurRadius: 8)
        ],
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: QrImage(
                          data: qrCode.content as String,
                          size: 100,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: height_ * 0.006,
                            ),
                            Text(
                              "AYMANE OULAD BENHAMMOU",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w800),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                                "Date:  ${DateFormat('dd MMM yyyy').format(qrCode.date)}",
                                style: ts),
                            Text("Type:  ${qrCode.type}", style: ts),
                            (qrCode.type == "Test PCR")
                                ? ((qrCode.pcr as bool)
                                    ? Text("Positive - PCR",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFFFF536D)))
                                    : Text("Negative - PCR",
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xFF0ACB57))))
                                : SizedBox(
                                    height: 0,
                                  ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: displayQrBtn(width_, height_, qrCode),
          )
        ],
      ),
    );
  }

  Widget displayQrBtn(double width_, double height_, myQ.QrCode qrCode) {
    return GestureDetector(
      onTap: () {
        // navigate to qr details page
        Get.to(() => CertificatDetails(qrCode));
      },
      child: Container(
        width: width_,
        decoration: BoxDecoration(
          color: Color(0xFFC8CFFF),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12)),
        ),
        child: Center(
          child: Text(
            "display_certif".tr,
            style: GoogleFonts.poppins(
                color: Color(0xFF4156FF),
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
