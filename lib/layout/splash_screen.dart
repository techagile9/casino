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
    if (!Services.isAppUpdateRequired) {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const HomePage())));
    } else {
      Timer(const Duration(seconds: 2), () async {
        await Services().openAppStore(package: AppPackage.newPackage);
      });
    }

    return Scaffold(
      body: Center(
        child: !Services.isAppUpdateRequired
            ? Image.asset(
                "assets/wof1.gif",
              )
            : const Text(
                'Taking you to the Google Play..',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
