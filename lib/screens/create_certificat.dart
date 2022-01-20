// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, prefer_const_constructors, sized_box_for_whitespace

import 'package:covid_19_tracer/models/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart' show QrImage;

class CreateCertificat extends StatefulWidget {
  QrCode qrCode;
  CreateCertificat(this.qrCode);

  @override
  _CreateCertificatState createState() => _CreateCertificatState();
}

class _CreateCertificatState extends State<CreateCertificat> {
  @override
  Widget build(BuildContext context) {
    double height_ = MediaQuery.of(context).size.height;
    double width_ = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: height_,
        width: width_,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: widget.qrCode.content as String,
              size: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text(widget.qrCode.content as String),
            Text(widget.qrCode.type as String),
          ],
        ),
      ),
    );
  }
}
