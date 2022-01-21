// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:covid_19_tracer/controllers/langues_controller.dart';
import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/screens/widgets/dialogues/delete%20dialog/delete_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: _size.height,
        width: _size.width,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 30,
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Settings',
              style: GoogleFonts.poppins(
                  fontSize: 40, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'Account',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF272727)),
            ),
            SizedBox(
              height: 25,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     Row(
            //       children: [
            //         Container(
            //           height: 55,
            //           width: 55,
            //           decoration: BoxDecoration(
            //               color: Color(0xFFE8F2FF), shape: BoxShape.circle),
            //           child: Icon(
            //             Icons.person,
            //             color: Color(0xFF469BFF),
            //           ),
            //         ),
            //         SizedBox(
            //           width: 20,
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Text(
            //               'Chiba Abdenaji',
            //               style: GoogleFonts.poppins(
            //                 fontSize: 19,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //             Text(
            //               'Personal Info',
            //               style: GoogleFonts.poppins(
            //                 fontSize: 16,
            //                 fontWeight: FontWeight.w400,
            //                 color: Color(0xFF9D9D9D),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     ),
            //     GestureDetector(
            //       onTap: () {},
            //       child: Container(
            //           height: 45,
            //           width: 45,
            //           child: Icon(
            //             Icons.arrow_forward_ios_rounded,
            //             color: Color(0xFF5063FF),
            //           ),
            //           decoration: BoxDecoration(
            //               color: Color(0xFFECEEFF),
            //               borderRadius: BorderRadius.circular(12))),
            //     )
            //   ],
            // ),

            myCard('Chiba Abdenaji', [Color(0xFFE8F2FF), Color(0xFF469BFF)],
                Icons.person, () {}, 'Personal Info'),
            SizedBox(
              height: 60,
            ),
            Text(
              'Settings',
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF272727)),
            ),
            SizedBox(
              height: 25,
            ),
            myCard('Languages', [Color(0xFFFFE7D6), Color(0xFFFA6D24)],
                Icons.language, () => languageDialog(), null),
            SizedBox(
              height: 30,
            ),
            myCard(
                'Delete All Certificates',
                [Color(0xFFFFE8E8), Color(0xFFFF5247)],
                Icons.delete,
                () => deleteDialog(),
                null),
            SizedBox(
              height: 45,
            ),
          ],
        ),
      ),
    );
  }

  void languageDialog() {
    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.transparent,
      content: LanguageDialog(),
    );
  }

  void deleteDialog() {
    Get.defaultDialog(
      title: '',
      backgroundColor: Colors.transparent,
      content: DeleteAllDialog(),
    );
  }

  Widget myCard(String title, List<Color> colors, IconData icon, Function func,
      String? sub) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 55,
              width: 55,
              decoration:
                  BoxDecoration(color: colors[0], shape: BoxShape.circle),
              child: Icon(
                icon,
                color: colors[1],
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                !(sub == null)
                    ? Text(
                        sub as String,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF9D9D9D),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            func();
          },
          child: Container(
              height: 45,
              width: 45,
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xFF5063FF),
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFECEEFF),
                  borderRadius: BorderRadius.circular(12))),
        )
      ],
    );
  }
}

class DeleteAllDialog extends StatelessWidget {
  QrController qrController = Get.find();
  LanguesController lgctrl = Get.put(LanguesController());

  DeleteAllDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        height: height_ * 0.42,
        width: width_ * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
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
                    "Delete All ?",
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "All certificates will be deleted",
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
                                // TODO: delete all
                                // qrController.removeQr(qrCode);
                                Get.back();
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

class LanguageDialog extends StatelessWidget {
  LanguesController langCtrl = Get.put(LanguesController());
  LanguageDialog({Key? key}) : super(key: key);

  final flagList = ['English', 'Arabic', 'Français'];
  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;

    return Center(
      child: Container(
        height: height_ * 0.42,
        width: width_ * 0.8,
        padding: EdgeInsets.symmetric(vertical: 35, horizontal: 35),
        // width: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Languages",
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: langCtrl.locales
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(6),
                        child: GestureDetector(
                          onTap: () {
                            langCtrl.changeLang(e);
                            Get.back();
                            print("assets/svgs/${e['name']}.svg");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 45),
                            decoration: BoxDecoration(
                                color: Color(0xFFECEEFF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e['name'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    color: Color(0xFF5063FF),
                                  ),
                                ),
                                // flag
                                SizedBox(
                                    height: 20,
                                    child: SvgPicture.asset(
                                        "assets/svgs/${e['name']}.svg"))
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
