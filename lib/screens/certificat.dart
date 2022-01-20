// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Cerificat extends StatelessWidget {
  const Cerificat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          height: height_,
          width: width_,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Cerificats',
                  style: GoogleFonts.poppins(
                      fontSize: 28, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  width: width_,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
