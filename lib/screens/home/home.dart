// ignore_for_file: prefer_const_literals_to_create_immutables, unused_local_variable, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, avoid_print, unused_import, unused_field

import 'package:covid_19_tracer/controllers/langues_controller.dart';
import 'package:covid_19_tracer/controllers/qr_controller.dart';
import 'package:covid_19_tracer/controllers/statistics.dart';
import 'package:covid_19_tracer/controllers/udid_controller.dart';
import 'package:covid_19_tracer/models/push_notification.dart';
import 'package:covid_19_tracer/screens/scanPage/scan_screen.dart';
import 'package:covid_19_tracer/screens/wallet/wallet.dart';
import 'package:covid_19_tracer/screens/widgets/dialogues/langues%20dialog/langues_dialog.dart';
import 'package:covid_19_tracer/services/local_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// 3 for background notif
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LanguesController ldController = Get.put(LanguesController());
  final UdidController udidController = Get.put(UdidController());
  final StatisticsController statisticsController =
      Get.put(StatisticsController());

  // notifications
  // 1
  late final FirebaseMessaging _messaging;

  // 2
  void registerNotification() async {
    // 2-1 initialize firebase app
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;

    // 2-2 For handling the received notifications "forground"
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      LocalNotificationService.initialize(context);

      // Parse the message received
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataBody: message.data['route'],
      );

      // show notification
      LocalNotificationService.display(message);
    });

    // 3 to handle notification when the app is runing on background
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 3-2 onClick open notif when the app is on "background" or "terminated"
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataBody: message.data['route'],
      );

      Get.toNamed(notification.dataBody ?? 'wallet');
    });

    String? token = await FirebaseMessaging.instance.getToken();
    // setState(() {
    //   token_ = token!;
    // });
    print('====================== $token ');
  }

  // 4
  // For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    await Firebase.initializeApp();
    RemoteMessage? message =
        await FirebaseMessaging.instance.getInitialMessage();

    if (message != null) {
      PushNotification notification = PushNotification(
        title: message.notification?.title,
        body: message.notification?.body,
        dataBody: message.data['route'],
      );
    }
  }

  @override
  void initState() {
    super.initState();
    registerNotification();
    checkForInitialMessage();
  }

  @override
  void dispose() {
    super.dispose();
    ldController.onClose();
    udidController.onClose();
    statisticsController.onClose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var height_ = size.height;
    var width_ = size.width;

    List cards = [
      {
        'color': [
          Color(0xFFFFB251),
          Color(0xFFFFD166),
        ],
        'title': 'Scan a venue QR code',
        'description': 'Be aletred in case of\nexpoure in venue',
        'svgImg': 'phone_qr',
        'reverse': false,
        'func': func
      },
      {
        'color': [
          Color(0xFFEF476F),
          Color(0xFFFF6086),
        ],
        'title': 'You are COVID-19\npositive ?',
        'description': 'Tap here to scan the QR code',
        'svgImg': 'test',
        'reverse': true,
        'func': func
      },
      {
        'color': [
          Color(0xFF00CDAC),
          Color(0xFF06D6A0),
        ],
        'title': 'You are COVID-19\npositive ?',
        'description': 'Tap here to scan the QR code',
        'svgImg': 'phone_verif',
        'reverse': false,
        'func': func
      },
      {
        'color': [
          Color(0xFF00B9F6),
          Color(0xFF40CFFF),
        ],
        'title': 'Scan a venue QR code',
        'description': 'Be aletred in case of\nexpoure in venue',
        'svgImg': 'phone_qr',
        'reverse': true,
        'func': func
      }
    ];

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ScanPage(),
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 300),
              curve: Curves.bounceOut);
        },
        backgroundColor: Colors.transparent,
        elevation: 4,
        child: Container(
          width: width_,
          height: height_,
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  // Color(0xFF3BB2B8),
                  // Color(0xFF42E695),

                  Color(0xFF5063FF),
                  Color(0xFF5F6EE3),
                ]),
          ),
          child: SvgPicture.asset("assets/svgs/scan.svg"),
        ),
      ),
      backgroundColor: Color(0xFFFAF9FF),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          header(height_, width_),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title('health_pass'.tr),
                space(15),
                card(
                  context,
                  [
                    Color(0xFF6374F8),
                    Color(0xFF6374F8),
                    Color(0xFF697AFF),
                  ],
                  'card1_title'.tr,
                  'card1_subtitle'.tr,
                  'wallet',
                  true,
                  navToWallete,
                ),
                space(20),
                title('news'.tr),
                space(15),
                Obx(() {
                  return vaccinationPrc(size);
                }),
                Obx(() {
                  return statistics(size);
                }),
                space(20),
                title('contact_tracing'.tr),
                space(25),
                Column(
                  children: cards
                      .map((card_) => card(
                            context,
                            card_['color'],
                            card_['title'],
                            card_['description'],
                            card_['svgImg'],
                            card_['reverse'],
                            card_['func'],
                          ))
                      .toList(),
                ),
                space(60)
              ],
            ),
          )
        ]),
      ),
    );
  }

  void func(String svgName, {double height = 600}) {
    print('height = $height');
  }

  void navToWallete() {
    Get.off(() => Wallet(),
        transition: Transition.rightToLeft,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn);
  }

  Widget newsTitle(
      String title, Color color, double fontSize, FontWeight fontWeight) {
    return Text(
      title,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: fontWeight, color: color),
    );
  }

  Widget vaccinationPrc(Size size) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
            ]),
        margin: EdgeInsets.only(bottom: 20),
        width: size.width,
        height: (size.height < 684) ? size.height * 0.26 : size.height * 0.22,
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFF52AEBC)),
                  child: Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                newsTitle(
                    "statistics1".tr, Color(0xFF52AEBC), 20, FontWeight.w600),
              ],
            ),
            space(2),
            newsTitle('update'.tr, Color(0xFF4B4848), 16, FontWeight.normal),
            space(8),
            newsTitle(statisticsController.getVaccinatedPerc, Colors.black, 48,
                FontWeight.w600),
          ],
        ));
  }

  Widget statistics(Size size) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(11),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)
            ]),
        margin: EdgeInsets.only(bottom: 20),
        width: size.width,
        height: (size.height < 684) ? size.height * 0.26 : size.height * 0.22,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xFFED7470)),
                  child: Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                newsTitle(
                    "statistics2".tr, Color(0xFFED7470), 20, FontWeight.w600),
              ],
            ),
            space(4),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newsTitle("completed".tr, Color(0xFF6FC76D), 14,
                            FontWeight.w500),
                        Builder(builder: (context) {
                          return newsTitle(
                              "${statisticsController.getVaccinated}",
                              Colors.black,
                              24,
                              FontWeight.w700);
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newsTitle(
                            "new_cases".tr,
                            Color(0xFFFF536D),
                            (ldController.langue.value == 'Fr') ? 14 : 16,
                            FontWeight.w500),
                        newsTitle("${statisticsController.getNewCases}",
                            Colors.black, 24, FontWeight.w700),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        newsTitle(
                            "cases".tr, Color(0xFF5364FF), 16, FontWeight.w500),
                        newsTitle("${statisticsController.getRecovered}",
                            Colors.black, 24, FontWeight.w700),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Widget space(double h) {
    return SizedBox(
      height: h,
    );
  }

  Widget title(String title) {
    return Text(
      title,
      style: GoogleFonts.roboto(
          fontSize: 26,
          fontWeight: FontWeight.w700,
          color: Colors.black.withOpacity(0.8)),
    );
  }

  Widget card(
    BuildContext context,
    List<Color> colors,
    String title,
    String description,
    String svgName,
    bool reverse,
    Function func,
  ) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        try {
          func(svgName);
        } catch (e) {
          func();
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        width: size.width,
        height: (size.height < 684) ? size.height * 0.2 : size.height * 0.18,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: colors),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 15)
            ]),
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reverse
                ? textColumn(title, description)
                : svgImg(svgName, size.width),
            SizedBox(
              width: 8,
            ),
            !reverse
                ? textColumn(title, description)
                : svgImg(svgName, size.width),
          ],
        ),
      ),
    );
  }

  Widget textColumn(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
        ),
        Text(
          description,
          style: GoogleFonts.poppins(
              color: Colors.white.withOpacity(0.65), fontSize: 16),
        ),
      ],
    );
  }

  Widget svgImg(String svgName, double width_) {
    return Expanded(
      flex: 2,
      child: Container(
          padding: EdgeInsets.only(bottom: (svgName == 'wallet') ? 20 : 0),
          child: SvgPicture.asset("assets/svgs/$svgName.svg")),
    );
  }

  Widget header(double height_, double width_) {
    return Container(
      // header
      height: height_ * 0.5,
      child: Stack(
        children: [
          //background
          Container(
            width: width_,
            height: height_ * 0.4,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/bg4.png'),
                    fit: BoxFit.fill)),
          ),
          // svgs
          Positioned(
            right: width_ * 0.4,
            bottom: -(height_ * 0.06),
            child: Container(
              width: width_ * 0.7,
              child: SvgPicture.asset("assets/svgs/virus.svg"),
            ),
          ),
          Positioned(
            right: width_ * 0.3,
            bottom: (height_ < 684) ? -(height_ * 0.1) : -(height_ * 0.06),
            child: Container(
              width: (height_ < 684) ? width_ * 0.7 : width_ * 0.75,
              child: SvgPicture.asset("assets/svgs/doc2.svg"),
            ),
          ),
          // title
          Positioned(
              top: (height_ < 684) ? height_ * 0.06 : height_ * 0.1,
              right: width_ * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "COVID-19",
                    style: GoogleFonts.poppins(
                        fontSize: 38,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "Contact Tracing",
                    style:
                        GoogleFonts.poppins(fontSize: 24, color: Colors.white),
                  ),
                ],
              )),
          // langue button
          Positioned(
              top: height_ * 0.23,
              right: width_ * 0.11,
              child: GestureDetector(
                onTap: () {
                  ldController.toggleIsVisible();
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  child: Obx(() {
                    return Text(
                      ldController.langue.value,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          fontSize: 18,
                          color: Color(0xFF6374F8),
                          fontWeight: FontWeight.w500),
                    );
                  }),
                ),
              )),
          // langue dialog
          Positioned(
            top: (height_ < 684) ? height_ * 0.22 : height_ * 0.24,
            right: width_ * 0.22,
            child: LangueDialog(400),
          )
        ],
      ),
    );
  }
}
