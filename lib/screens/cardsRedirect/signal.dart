import 'package:covid_19_tracer/screens/createCertificat/create_certificat.dart';
import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:covid_19_tracer/screens/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:google_fonts/google_fonts.dart';

class Signal extends StatefulWidget {
  const Signal({Key? key}) : super(key: key);

  @override
  _SignalState createState() => _SignalState();
}

class _SignalState extends State<Signal> {
  @override
  Widget build(BuildContext context) {
    double width_ = MediaQuery.of(context).size.width;
    double height_ = MediaQuery.of(context).size.height;
    TextStyle ts = GoogleFonts.poppins(
      fontSize: 18,
    );

    return WillPopScope(
      onWillPop: () {
        Get.off(Home(),
            transition: Transition.leftToRight,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn);
        return Future.value(true);
      },
      child: Scaffold(
          backgroundColor: Color(0xFFF8F9FF),
          body: SingleChildScrollView(
            child: Container(
              height: height_,
              width: width_,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header
                  Container(
                    width: width_,
                    height: height_ * 0.25,
                    child: Stack(children: [
                      Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/appbar.png"),
                          fit: BoxFit.cover,
                        )),
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
                              flex: 7,
                              child: Center(
                                child: Text(
                                  'Signal',
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
                      )
                    ]),
                  ),
                  // Body
                  Expanded(
                    flex: 3,
                    child: Container(
                      width: width_,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: (height_ < 684)
                                ? height_ * 0.02
                                : height_ * 0.03,
                          ),
                          Container(
                            height: (height_ < 684)
                                ? height_ * 0.02
                                : height_ * 0.03,
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF5668F5).withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 20),
                                          Text(
                                            "Lorem",
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
