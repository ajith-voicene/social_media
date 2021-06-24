import 'dart:async';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/features/Timeline/pages/timeline.dart';
import 'package:social_media/resources/fcmServices.dart';

import 'features/auth/pages/login_page.dart';
// import 'resources/fcmServices.dart';
import 'resources/navigator.dart';
import 'utils/constants.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    "id", "Social media", "staytogether",
    importance: Importance.high, playSound: true);

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  var initializationSettingsAndroid =
      new AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: PushNotificationService.onPushNotificationHandling);

  Constant.fcmToken = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, badge: true, sound: true);
  runApp(new MaterialApp(
    theme: ThemeData(primaryColor: Colors.blue),
    home: new SplashScreen(),
    navigatorKey: NavigationService.instance.navigationKey,
    debugShowCheckedModeBanner: false,
  ));
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // static final FirebaseMessaging _firebaseMessaging =
  //     FirebaseMessaging.instance;

  String token;
  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Constant.token = prefs.getString('Token');
    Constant.name = prefs.getString('name');
    Constant.email = prefs.getString('email');
    Constant.provider = prefs.getString('provider');
    Constant.photoUrl = prefs.getString('photo');
    Constant.username = prefs.getString('username');
    Constant.id = prefs.getInt('id');
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
    // final pushNotificationService = PushNotificationService(_firebaseMessaging);
    // pushNotificationService.initialise();
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
