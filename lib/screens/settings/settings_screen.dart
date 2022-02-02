// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:covid_19_tracer/controllers/langues_controller.dart';
import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        height: _size.height,
        width: _size.width,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 34,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text('settings'.tr,
                        style: GoogleFonts.poppins(
                            fontSize: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Text(
              'account'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF272727)),
            ),
            SizedBox(
              height: 25,
            ),
            Obx(() {
              return myCard(
                  QrController.userName.value,
                  [Color(0xFFE8F2FF), Color(0xFF469BFF)],
                  Icons.person,
                  () => changeNameDialog(context),
                  'personal_info'.tr);
            }),
            SizedBox(
              height: 60,
            ),
            Text(
              'settings'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF272727)),
            ),
            SizedBox(
              height: 25,
            ),
            myCard('languages'.tr, [Color(0xFFFFE7D6), Color(0xFFFA6D24)],
                Icons.language, () => languageDialog(), null),
            SizedBox(
              height: 30,
            ),
            myCard('delete_all'.tr, [Color(0xFFFFE8E8), Color(0xFFFF5247)],
                Icons.delete, () => deleteDialog(), null),
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

  void changeNameDialog(BuildContext context) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.all(0),
      // backgroundColor: Colors.,
      content: ChangeNameDialog(),
    );
  }

  Widget myCard(String title, List<Color> colors, IconData icon, Function func,
      String? sub) {
    return InkWell(
      onTap: () {
        func();
      },
      child: Row(
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
                    // overflow: TextOverflow.ellipsis,
                  ),
                  !(sub == null)
                      ? Text(
                          sub,
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
              "languages".tr,
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
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 45),
                            decoration: BoxDecoration(
                                color: Color(0xFFF4F5FF),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e['name'] as String,
                                  style: GoogleFonts.poppins(
                                    fontSize: 19,
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

class DeleteAllDialog extends StatelessWidget {
  QrController qrController = Get.find();
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
                    "delete_all_title".tr,
                    style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  Text(
                    "delete_all_sub".tr,
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
                                qrController.removeAll();
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
                                            (LanguesController.langue.value ==
                                                    'Ar')
                                                ? ((title == 'delete') ? 12 : 0)
                                                : // ar
                                                ((title == 'delete')
                                                    ? 0
                                                    : 12) //en

                                            ),
                                        bottomRight: Radius.circular(
                                            (LanguesController.langue.value ==
                                                    'Ar')
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

class ChangeNameDialog extends StatelessWidget {
  ChangeNameDialog({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final double height_ = MediaQuery.of(context).size.height;
    final double width_ = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 40, left: 40, right: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "change_name".tr,
            style: GoogleFonts.poppins(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 35,
          ),
          Container(
            height: height_ * 0.065,
            width: width_ * 0.6,
            decoration: BoxDecoration(
                color: Color(0xFFEDEFFF),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: nameController,
              textAlign: TextAlign.center,
              style:
                  GoogleFonts.poppins(color: Color(0xFF4152F3), fontSize: 18),
              autocorrect: false,
              decoration: InputDecoration(
                  hintText: "new_name".tr,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.poppins(
                      color: Color(0xFF7380FF), fontSize: 16)),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          InkWell(
            onTap: () {
              if (nameController.text.isNotEmpty) {
                updateUserName(nameController.text);
              }
              Get.back();
            },
            child: Container(
              height: height_ * 0.06,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xFF5063FF), Color(0xFF5F6EE3)]),
                  borderRadius: BorderRadius.circular(18)),
              child: Center(
                child: Text('save_btn'.tr,
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void updateUserName(String userName) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString('user', userName);
    QrController.initUserName();
  }
}
