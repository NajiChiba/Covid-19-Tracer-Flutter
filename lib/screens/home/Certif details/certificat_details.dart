// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unrelated_type_equality_checks, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print, unnecessary_null_comparison, unused_element, must_be_immutable, non_constant_identifier_names

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/screens/home/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:covid_19_tracer/models/qr_code.dart' as myQ;

class CertificatDetails extends StatelessWidget {
  myQ.QrCode qrCode;
  CertificatDetails(this.qrCode);
  QrController qrController = Get.put(QrController());

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;
    TextStyle ts = GoogleFonts.poppins(
      fontSize: 18,
    );
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        child: Container(
          height: height_,
          width: width_,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // header
              Expanded(
                flex: 1,
                child: Container(
                  width: width_,
                  // height: height_ * 0.25,
                  child: Stack(children: [
                    Container(
                      height: height_ * 0.25,
                      width: width_,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/appbar.png"),
                              fit: BoxFit.fill)),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: GestureDetector(
                              onTap: () {
                                Get.back();
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
                                'certificates'.tr,
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
                    ),
                  ]),
                  // body
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: width_,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            (height_ < 684) ? height_ * 0.02 : height_ * 0.03,
                      ),
                      Container(
                        height:
                            (height_ < 684) ? height_ * 0.68 : height_ * 0.62,
                        margin: EdgeInsets.symmetric(
                          horizontal: 30,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF5668F5).withOpacity(0.1),
                                blurRadius: 8,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 20),
                                      QrImage(
                                        data: qrCode.content as String,
                                        size: width_ * 0.44,
                                      ),
                                      SizedBox(
                                        height: 18,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            "AYMANE OULAD BENHAMMOU",
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700),
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                              "Date:  ${DateFormat('dd MMM yyyy').format(qrCode.date)}",
                                              style: ts),
                                          Text("Type:  ${qrCode.type}",
                                              style: ts),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          (qrCode.type == "Test PCR")
                                              ? ((qrCode.pcr as bool)
                                                  ? Text("Positive - COVID PCR",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFFFF0202)))
                                                  : Text(
                                                      "Negative - COVID PCR",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                  0xFF0ACB57))))
                                              : SizedBox(
                                                  height: 0,
                                                ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   height: 24,
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // remove certif
                                qrController.removeQr(qrCode);
                                Get.off(() => Wallet());
                              },
                              child: Container(
                                height: height_ * 0.1,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xFFFFDDDD),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(16),
                                        bottomRight: Radius.circular(16))),
                                child: Center(
                                    child: Text(
                                  "delete".tr,
                                  style: GoogleFonts.poppins(
                                      color: Color(0xFFFF0202),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
