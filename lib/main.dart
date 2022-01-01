import 'package:casinocoin/layout/homepage.dart';
import 'package:casinocoin/layout/splash_screen.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  String deviceId = androidInfo.androidId;

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('deviceId', deviceId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Casino',
      theme: ThemeData(
        primarySwatch: Colors.blue,

      ),
      home: const SplashScreen(),
    );
  }
}
