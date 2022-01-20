// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, must_be_immutable

import 'package:covid_19_tracer/screens/widgets/dialogues/langues%20dialog/langue_dialog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LangueDialog extends StatelessWidget {
  // Widget myChild;
  int duration;
  LangueDialog(this.duration);

  LangueDialogController fadeCtr = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      bool visible = fadeCtr.isVisible.value;
      return AnimatedOpacity(
        duration: Duration(milliseconds: duration),
        opacity: visible ? 1 : 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          // width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8)
              ]),
          child: Column(
            children: fadeCtr.locales
                .map((e) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: GestureDetector(
                            onTap: () {
                              fadeCtr.changeLang(e);
                            },
                            child: Text(
                              e['name'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color(0xFF6374F8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
                .toList(),
          ),
        ),
      );
    });
  }
}
