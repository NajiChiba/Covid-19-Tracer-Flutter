// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:covid_19_tracer/controllers/langues_controller.dart';
import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/screens/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BackDialog extends StatelessWidget {
  QrController qrController = Get.find();
  LanguesController lgctrl = Get.put(LanguesController());

  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        height: height_ * 0.25,
        width: width_ * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "discard_title".tr,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        // fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: ['no', 'yes']
                    .map((title) => Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              if (title == 'no') {
                                Get.back();
                              } else {
                                // yes
                                Get.back();
                                Get.off(Wallet());
                              }
                            },
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                    color: title == 'no'
                                        ? Color(0xFFE0E5FF)
                                        : Color(0xFFFFC8C8),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            (lgctrl.langue == 'Ar')
                                                ? ((title == 'yes') ? 12 : 0)
                                                : // ar
                                                ((title == 'yes') ? 0 : 12) //en

                                            ),
                                        bottomRight: Radius.circular(
                                            (lgctrl.langue == 'Ar')
                                                ? ((title == 'no') ? 12 : 0)
                                                : //ar
                                                ((title == 'no') ? 0 : 12) //en

                                            ))),
                                child: Center(
                                  child: Text(
                                    title.tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: (title == 'no')
                                            ? Color(0xFF4156FF)
                                            : Color(0xFFFF0000)),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
