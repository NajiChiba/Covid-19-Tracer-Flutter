// ignore_for_file: prefer_const_constructors

import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          children: [
            Expanded(
              flex: 6,
              child: Column(
                children: [
                  Expanded(
                      flex: 4,
                      child: Center(
                          child: SvgPicture.asset('assets/svgs/alert.svg'))),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Alert !',
                      style: GoogleFonts.poppins(
                          fontSize: 32,
                          color: Color(0xFFFF3F33),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'We just got the information that one of the people you\'ve been in contact with has been tested positive to Covid',
                      style: GoogleFonts.roboto(
                          fontSize: 24, color: Color(0xFF3F3F3F)),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: GestureDetector(
                onTap: () {
                  Get.offAll(() => Home(),
                      transition: Transition.leftToRight,
                      duration: Duration(milliseconds: 300),
                      curve: Curves.bounceOut);
                },
                child: Center(
                  child: Container(
                    height: 60,
                    width: 300,
                    alignment: Alignment.center,
                    child: Text('Back To Home',
                        style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF495BFE))),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(0xFFDDE9FF)),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
