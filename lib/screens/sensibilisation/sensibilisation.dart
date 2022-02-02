// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, avoid_unnecessary_containers, use_key_in_widget_constructors, must_be_immutable, prefer_const_literals_to_create_immutables

import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:covid_19_tracer/screens/scanPage/scan_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Sensitization extends StatelessWidget {
  String langue;
  Sensitization(this.langue);

  Widget card(double width_, String title, String content) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      width: width_,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 8)
          ]),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.tr,
            style:
                GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            content.tr,
            style: GoogleFonts.poppins(fontSize: 16),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () {
        Get.defaultDialog(
          title: '',
          backgroundColor: Colors.transparent,
          content: Home(),
        );
        return Future.value(false);
      },
      child: Scaffold(
          body: Container(
        height: height_,
        width: width_,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // header
              Container(
                width: width_,
                height: height_ * 0.18,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF5063FF),
                            Color(0xFF5F6EE3),
                          ]),
                    ),
                  ),
                  Container(
                    height: height_ * 0.25,
                    width: width_,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              Get.off(Home(),
                                  transition: Transition.leftToRight,
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeIn);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 34,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: Center(
                            child: Text(
                              'sensitization_tt'.tr,
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: /*langue == "Fr" ? 22 :*/ 28,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

              //body
              Expanded(
                  child: Stack(children: [
                // body
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      width: width_,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            "assets/svgs/senssible.svg",
                            height: 160,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          card(width_, 'sensitization_page_tt',
                              'sensitization_page_bd'),
                          card(width_, 'sensitization_page_tt2',
                              'sensitization_page_bd2'),
                          card(width_, 'sensitization_page_tt3',
                              'sensitization_page_bd3'),
                          SizedBox(
                            height: height_ * 0.14,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                // btn
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: width_,
                    height: height_ * 0.14,
                    decoration: BoxDecoration(color: Colors.white, boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25), blurRadius: 8)
                    ]),
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 35),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(ScanPage(),
                            transition: Transition.leftToRight,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF4B5CFF),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.25),
                                  blurRadius: 8)
                            ]),
                        child: Center(
                          child: Text(
                            "sensitization_btn".tr,
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ]))
            ]),
      )),
    );
  }
}
