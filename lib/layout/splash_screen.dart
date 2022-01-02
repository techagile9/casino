import 'dart:async';

import 'package:casinocoin/layout/homepage.dart';
import 'package:casinocoin/service/services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Services.showAppOpenAd();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const HomePage())));

    return Scaffold(
      body: Center(
        child: Image.asset(
          "assets/wof1.gif",
        ),
      ),
    );
  }
}
