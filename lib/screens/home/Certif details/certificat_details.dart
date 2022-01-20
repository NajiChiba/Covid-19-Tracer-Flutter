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
      fontSize: 20,
    );
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        child: Container(
          // height: height_,
          width: width_,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              Container(
                width: width_,
                height: height_ * 0.25,
                child: Stack(children: [
                  Container(
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
                              'Certificat',
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                padding: EdgeInsets.symmetric(horizontal: 30),
                width: width_,
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10),
                    QrImage(
                      data: qrCode.content as String,
                      size: width_ * 0.44,
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "AYMANE OULAD BENHAMMOU",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        (qrCode.type == "Test PCR")
                            ? ((qrCode.pcr as bool)
                                ? Text("Positive - COVID PCR",
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFFFF536D)))
                                : Text("Negative - COVID PCR",
                                    style: GoogleFonts.poppins(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF6FC76D))))
                            : SizedBox(
                                height: 0,
                              ),
                        Text("Type:  ${qrCode.type}", style: ts),
                        Text(
                            "Date:  ${DateFormat('dd MMM yyyy').format(qrCode.date)}",
                            style: ts),
                      ],
                    ),
                    SizedBox(
                      height: 26,
                    ),
                    GestureDetector(
                      onTap: () {
                        // remove certif
                        qrController.removeQr(qrCode);
                        Get.off(() => Wallet());
                      },
                      child: Container(
                        height: height_ * 0.09,
                        width: width_ * 0.6,
                        decoration: BoxDecoration(
                            color: Color(0xFFF93642),
                            borderRadius: BorderRadius.circular(18)),
                        child: Center(
                            child: Text(
                          "Delete Certificat",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w500),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 22,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
