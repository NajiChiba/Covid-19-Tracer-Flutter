// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unrelated_type_equality_checks, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print, unnecessary_null_comparison, unused_element

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CertifTest extends StatefulWidget {
  const CertifTest({Key? key}) : super(key: key);

  @override
  _CertifTestState createState() => _CertifTestState();
}

class _CertifTestState extends State<CertifTest> {
  var now = DateTime.now();
  var selectedDate = '';
  String birthDate = 'Birth date';
  TextEditingController fnController = TextEditingController();
  TextEditingController lnController = TextEditingController();
  bool status = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedDate = DateFormat('dd-MM-yyyy').format(now);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height_ = MediaQuery.of(context).size.height;
    double width_ = MediaQuery.of(context).size.width;

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
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 76),
                width: width_,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // date picker
                    GestureDetector(
                      onTap: () async {
                        // open date picker
                        await showDateDialog(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset("assets/svgs/date.svg"),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            selectedDate,
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Color(0xFF5668F5)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // QrImage
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF5668F5).withOpacity(0.1),
                              blurRadius: 8,
                            )
                          ]),
                      child: QrImage(
                        data: 'https://www.youtube.com/watch?v=Zsqm_uO_yLE',
                        size: width_ * 0.4,
                      ),
                    ),

                    SizedBox(
                      height: 25,
                    ),

                    textFieald('First name', fnController),
                    SizedBox(
                      height: 15,
                    ),
                    textFieald('Lastname', lnController),

                    SizedBox(
                      height: 15,
                    ),
                    bdPicker(birthDate),
                    SizedBox(
                      height: 15,
                    ),
                    CustomDropDown(5, 'test'),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xFF5668F5).withOpacity(0.1),
                                blurRadius: 8)
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Positive',
                            style: GoogleFonts.poppins(fontSize: 20),
                          ),
                          SizedBox(
                            width: 18,
                          ),
                          FlutterSwitch(
                            width: 45.0,
                            height: 22.0,
                            valueFontSize: 10.0,
                            toggleSize: 16.0,
                            activeColor: Color(0xFF4CBC6E),
                            value: status,
                            onToggle: (val) {
                              setState(() {
                                status = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bdPicker(String date) {
    TextStyle hintS = GoogleFonts.poppins(
        fontSize: 18,
        color: (date == 'Birth date') ? Color(0xFF9FACFF) : Colors.black);
    return Container(
      padding: EdgeInsets.only(left: 20),
      width: 500,
      height: 58,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xFF5668F5).withOpacity(0.1), blurRadius: 8)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date,
            style: hintS,
          ),
          GestureDetector(
            onTap: () async {
              await showBirthDateDialog(context);
            },
            child: Container(
              width: 55,
              // height: 80,
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: Color(0xFFD7DDFF),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: SvgPicture.asset("assets/svgs/date.svg"),
            ),
          )
        ],
      ),
    );
  }

  Widget textFieald(String hint, TextEditingController txtController) {
    TextStyle hintS =
        GoogleFonts.poppins(fontSize: 18, color: Color(0xFF9FACFF));

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xFF5668F5).withOpacity(0.1), blurRadius: 8)
          ]),
      child: TextField(
        controller: txtController,
        decoration: InputDecoration(
            border: InputBorder.none, hintText: hint, hintStyle: hintS),
      ),
    );
  }

  Future<void> showDateDialog(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022, 1),
      lastDate: DateTime(2101, 1),
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                  surface: Color(0xFF7B8AFF), onSurface: Colors.black)),
          child: child as Widget),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> showBirthDateDialog(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(1999, 1),
      firstDate: DateTime(1960, 1),
      lastDate: DateTime(2101, 1),
      builder: (context, child) => Theme(
          data: ThemeData().copyWith(
              colorScheme: ColorScheme.light(
                  surface: Color(0xFF7B8AFF), onSurface: Colors.black)),
          child: child as Widget),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        birthDate = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }
}

class CustomDropDown extends StatefulWidget {
  final int value;
  final String hint;

  CustomDropDown(this.value, this.hint);

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  var items = [
    DropdownMenuItem(
      value: 0,
      child: Text(
        'Test PCR',
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
      ),
    ),
    DropdownMenuItem(
      value: 1,
      child: Text(
        'Pass Sanitaire',
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
      ),
    ),
    DropdownMenuItem(
      value: 2,
      child: Text(
        'Autorisation',
        style: GoogleFonts.poppins(fontSize: 18, color: Colors.black),
      ),
    ),
  ].cast<DropdownMenuItem<int>>();

  int currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFF5668F5).withOpacity(0.1), blurRadius: 8)
              ]),
          child: DropdownButton(
            menuMaxHeight: 100,
            elevation: 1,
            dropdownColor: Colors.white,
            value: currentValue,
            hint: Text(
              widget.hint,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
            ),
            items: items,
            onChanged: (value) => changed(value as int),
            isExpanded: true,
            underline: Container(),
            icon: Icon(Icons.keyboard_arrow_down),
          ),
        ),
      ],
    );
  }

  void changed(int value) {
    setState(() {
      currentValue = value;
    });
    print(value);
  }
}
