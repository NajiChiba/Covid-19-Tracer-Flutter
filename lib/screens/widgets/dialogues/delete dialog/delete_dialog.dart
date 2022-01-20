// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, use_key_in_widget_constructors, unrelated_type_equality_checks, must_be_immutable

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:covid_19_tracer/screens/home/wallet/wallet.dart';
import 'package:covid_19_tracer/screens/widgets/dialogues/langues%20dialog/langue_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DeleteDialog extends StatelessWidget {
  QrCode qrCode;
  DeleteDialog(this.qrCode);
  QrController qrController = Get.find();
  LangueDialogController lgctrl = Get.put(LangueDialogController());

  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        height: height_ * 0.4,
        width: width_ * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/svgs/delete.svg'),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "delete_title".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "delete_subtitle".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 18, color: Color(0xFF9F9F9F)),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: ['cancel', 'delete']
                    .map((title) => Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              if (title == 'cancel') {
                                Get.back();
                              } else {
                                // delete
                                qrController.removeQr(qrCode);
                                Get.off(Wallet());
                              }
                            },
                            child: Obx(() {
                              return Container(
                                decoration: BoxDecoration(
                                    color: title == 'cancel'
                                        ? Color(0xFFE0E5FF)
                                        : Color(0xFFFFC8C8),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(
                                            (lgctrl.langue == 'Ar')
                                                ? ((title == 'delete') ? 12 : 0)
                                                : // ar
                                                ((title == 'delete')
                                                    ? 0
                                                    : 12) //en

                                            ),
                                        bottomRight: Radius.circular(
                                            (lgctrl.langue == 'Ar')
                                                ? ((title == 'cancel') ? 12 : 0)
                                                : //ar
                                                ((title == 'cancel')
                                                    ? 0
                                                    : 12) //en

                                            ))),
                                child: Center(
                                  child: Text(
                                    title.tr,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: (title == 'cancel')
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
