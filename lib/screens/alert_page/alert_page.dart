// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This is an alert comming from notification'),
      ),
    );
  }
}
