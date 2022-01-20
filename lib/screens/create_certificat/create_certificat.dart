// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unrelated_type_equality_checks, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, prefer_typing_uninitialized_variables, avoid_print, unnecessary_null_comparison, unused_element, must_be_immutable, non_constant_identifier_names, library_prefixes

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/screens/wallet/wallet.dart';
import 'package:covid_19_tracer/screens/widgets/dialogues/back%20dialog/back_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:covid_19_tracer/models/qr_code.dart' as myQ;

class CreateCertificat extends StatefulWidget {
  myQ.QrCode qrCode;
  CreateCertificat(this.qrCode);

  @override
  _CreateCertificatState createState() => _CreateCertificatState();
}

class _CreateCertificatState extends State<CreateCertificat> {
  var now = DateTime.now();
  var selectedDate = '';
  DateTime selectedDate_df = DateTime.now();
  bool testRes = false;
  String qrTypeValue = 'Test PCR';

  final QrController qrController = Get.find();

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
    myQ.QrCode qrCode = widget.qrCode;

    return Scaffold(
      backgroundColor: Color(0xFFF8F9FF),
      body: SingleChildScrollView(
        child: Container(
          width: width_,
          height: height_,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // header
              Container(
                width: width_,
                height: height_ * 0.25,
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/appbar.png"),
                            fit: BoxFit.cover)),
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
                              // dialog
                              Get.defaultDialog(
                                title: '',
                                backgroundColor: Colors.transparent,
                                content: BackDialog(),
                              );
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
                              'certificates'.tr,
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 76),
                  width: width_,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
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
                          data: qrCode.content as String,
                          size: (height_ < 684) ? width_ * 0.35 : width_ * 0.4,
                        ),
                      ),

                      SizedBox(
                        height: 25,
                      ),
                      // dropdown
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xFF5668F5).withOpacity(0.1),
                                  blurRadius: 8)
                            ]),
                        child: DropdownButton<String>(
                          value: qrTypeValue,
                          isExpanded: true,
                          icon: const Icon(Icons.arrow_drop_down),
                          elevation: 16,
                          onChanged: (String? newValue) {
                            setState(() {
                              qrTypeValue = newValue!;
                            });
                          },
                          items: <String>[
                            'Test PCR',
                            'Pass Covid',
                            'Autorisation',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(value,
                                    style: GoogleFonts.poppins(fontSize: 18)),
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      qrTypeValue == 'Test PCR'
                          ? testResult()
                          : SizedBox(
                              height: 10,
                            ),
                      SizedBox(
                        height: 20,
                      ),
                      saveButton(qrCode),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveButton(myQ.QrCode qrCode) {
    return GestureDetector(
      onTap: () {
        // add qr to object-box
        qrCode.date = selectedDate_df;
        qrCode.type = qrTypeValue;
        qrCode.pcr = testRes;

        print(qrCode.type);
        print(qrCode.pcr);
        print(qrCode);

        // qrController.addQr(qrCode);
        if (qrController.box != null && qrCode != null) {
          try {
            qrController.addQr(qrCode);
            Get.off(Wallet());
          } catch (e) {
            print(e);
          }
        } else {
          print('Null ${qrController.box}');
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          decoration: BoxDecoration(
              color: Color(0xFF4CBC6E),
              borderRadius: BorderRadius.circular(14)),
          child: Text(
            "save".tr,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
          )),
    );
  }

  Widget testResult() {
    return Container(
      // fix
      // margin: EdgeInsets.only(bottom: 25),
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Color(0xFF5668F5).withOpacity(0.1), blurRadius: 8)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'positive'.tr,
            style:
                GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
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
            value: testRes,
            onToggle: (val) {
              setState(() {
                testRes = val;
              });
            },
          ),
        ],
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

    if (picked != null) {
      setState(() {
        selectedDate = DateFormat('dd-MM-yyyy').format(picked);
        selectedDate_df = picked;
      });
    }
  }
}

/* Widget textFieald(String hint, TextEditingController txtController) {
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

*/
