// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/controllers/udid_controller.dart';
import 'package:covid_19_tracer/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  final PageController _controller = PageController();
  double buttonsOpacity = 0;

  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    _controller.dispose();
    super.dispose();
  }

  final pages = [
    {
      "svg": "page1.svg",
      "title": "What should\nwe call you ?",
    },
    {
      "svg": "page2.svg",
      "title": "Manage Wallet",
      "subtitle": "Manage your certificates wallet"
    },
    {
      "svg": "page3.svg",
      "title": "Stay Aware",
      "subtitle": "stay up to date with pandemic news"
    },
    {
      "svg": "page4.svg",
      "title": "Get Notified",
      "subtitle": "Get notified if you were a contact case"
    },
  ];

  @override
  Widget build(BuildContext context) {
    double height_ = MediaQuery.of(context).size.height;
    double width_ = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    Color darkPurple = Color(0xFF4152F3);
    Color lightPurple = Color(0xFF8995FF);

    //
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          height: height_,
          width: width_,
          padding: EdgeInsets.only(top: height_ * 0.16, right: 40, left: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                    controller: _controller,
                    // physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (int index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: pages.length,
                    itemBuilder: (_, index) => PageElem(pages[index], index,
                        size, myTextField, [darkPurple, lightPurple])
                    // Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       children: [
                    //         SvgPicture.asset(
                    //           'assets/svgs/${pages[index]["svg"]}',
                    //           height:
                    //               index != 0 ? height_ * 0.32 : height_ * 0.26,
                    //         ),
                    //         SizedBox(
                    //           height: height_ * 0.07,
                    //         ),
                    //         Text(
                    //           pages[index]["title"] as String,
                    //           style: GoogleFonts.poppins(
                    //               fontSize: 28,
                    //               fontWeight: FontWeight.w600,
                    //               color: darkPurple),
                    //         ),
                    //         SizedBox(
                    //           height: index != 0 ? 10 : 25,
                    //         ),
                    //         index != 0
                    //             ? Text(
                    //                 pages[index]["subtitle"] as String,
                    //                 textAlign: TextAlign.center,
                    //                 style: GoogleFonts.poppins(
                    //                     fontSize: 22, color: lightPurple),
                    //               )
                    //             : myTextField(height_, width_)
                    //       ],
                    //     )

                    ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    dotes(lightPurple),
                    buutons(height_, lightPurple),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buutons(double height_, Color lightPurple) {
    return Expanded(
      flex: 3,
      child: (nameController.text.isNotEmpty)
          ? Row(
              mainAxisAlignment: (currentIndex == 0 || currentIndex == 3)
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.spaceBetween,
              children: [
                (currentIndex == 0 || currentIndex == 3)
                    ? SizedBox()
                    : InkWell(
                        radius: 12,
                        onTap: () {
                          _controller.animateToPage(3,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.bounceInOut);
                        },
                        child: Text('Skip',
                            style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF5063FF)))),
                GestureDetector(
                  onTap: () {
                    if (currentIndex == 3) {
                      updateSharedPref(nameController.text);
                      //TODO: send udid to the server
                      UdidController.sendUdidToServer();
                      Get.offAll(Home(),
                          transition: Transition.rightToLeft,
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    }
                    _controller.nextPage(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceIn);
                  },
                  child: Container(
                    height: height_ * 0.06,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [Color(0xFF5063FF), Color(0xFF5F6EE3)]),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(
                      child: Text((currentIndex == 3) ? 'Get Started' : 'Next',
                          style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.white)),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: Text("Please insert your name",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      // fontWeight: FontWeight.w500,
                      color: lightPurple)),
            ),
    );
  }

  Widget myTextField(double height_, double width_) {
    return Container(
      height: height_ * 0.08,
      width: width_ * 8,
      decoration: BoxDecoration(
          color: Color(0xFFEDEFFF), borderRadius: BorderRadius.circular(26)),
      child: Center(
        child: TextField(
          controller: nameController,
          onChanged: (_) {
            if (nameController.text.isNotEmpty) {
              setState(() {
                buttonsOpacity = 1;
              });
            } else {
              setState(() {
                buttonsOpacity = 0;
              });
            }
          },
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(color: Color(0xFF4152F3), fontSize: 18),
          autocorrect: false,
          decoration: InputDecoration(
              hintText: "full name",
              border: InputBorder.none,
              hintStyle:
                  GoogleFonts.poppins(color: Color(0xFF7380FF), fontSize: 18)),
        ),
      ),
    );
  }

  Widget dotes(Color lightPurple) {
    return Expanded(
      flex: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
            pages.length,
            (index) => AnimatedContainer(
                  height: 14,
                  width: index == currentIndex ? 55 : 14,
                  margin: EdgeInsets.only(right: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: lightPurple,
                    gradient: index == currentIndex
                        ? LinearGradient(
                            colors: [Color(0xFF5063FF), Color(0xFF5F6EE3)])
                        : null,
                  ),
                  duration: Duration(milliseconds: 200),
                )),
      ),
    );
  }
}

void updateSharedPref(String userName) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  // print('=================== SET NAME ONBOARDING =====================');
  await preferences.setBool("onBoard", true);
  await preferences.setString('user', userName);
  QrController.initUserName();
}

class PageElem extends StatelessWidget {
  Map<String, String> page;
  int index;
  Size size;
  Widget Function(double height_, double width_) myTextField;
  List<Color> colors;

  PageElem(this.page, this.index, this.size, this.myTextField, this.colors,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/svgs/${page["svg"]}',
          height: index != 0 ? size.height * 0.32 : size.height * 0.26,
        ),
        SizedBox(
          height: size.height * 0.07,
        ),
        Text(
          page["title"] as String,
          style: GoogleFonts.poppins(
              fontSize: 28, fontWeight: FontWeight.w600, color: colors[0]),
        ),
        SizedBox(
          height: index != 0 ? 10 : 25,
        ),
        index != 0
            ? Text(
                page["subtitle"] as String,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(fontSize: 22, color: colors[1]),
              )
            : myTextField(size.height, size.width)
      ],
    );
  }
}
