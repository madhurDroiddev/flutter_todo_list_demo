import 'dart:async';

import 'package:firebasechat/src/utils/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final int SPLASH_TIME_OUT = 3;

  @override
  void initState() {
    super.initState();

    initTimer(context);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: FlutterLogo(
        size: 100,
      ),
    );
  }

  initTimer(BuildContext context) {
    Future.delayed(Duration(seconds: SPLASH_TIME_OUT)).then((value) {
      Navigator.of(context).pushReplacementNamed(Routes.homeDashBoard);
    });
  }
}
