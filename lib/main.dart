import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/features/Timeline/pages/timeline.dart';

import 'features/login/pages/login_page.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String token;
  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constant.token = prefs.getString('Token');
    Constant.name = prefs.getString('name');
    Constant.email = prefs.getString('email');
    Constant.provider = prefs.getString('provider');
    Constant.photoUrl = prefs.getString('photo');
    token = Constant.token;
    print(token);

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      Constant.devicename = androidInfo.model;
    }
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      Constant.devicename = iosInfo.model;
    }
    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TimeLine()),
      );
    }
  }

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.blue, // Color for Android
        statusBarBrightness:
            Brightness.dark // Dark == white status bar -- for IOS.
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      navigationPage();
    });
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            new Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(color: Colors.white, child: FlutterLogo(size: 150)),
              ],
            )),
          ],
        ));
  }
}
