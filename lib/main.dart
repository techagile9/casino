import 'package:casinocoin/layout/splash_screen.dart';
import 'package:casinocoin/service/services.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Services.performInitialSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        builder: () {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Casino Coins Daily',
            theme: ThemeData(
              primaryColor: Colors.purpleAccent,
              primarySwatch: Colors.blue,
            ),
            navigatorObservers: [
              FirebaseAnalyticsObserver(analytics: analytics),
            ],
            home: const SplashScreen(),
          );
        });
  }
}
