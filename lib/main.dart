// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/timeline.dart';
import 'Homepages.dart';



void main() async {
  runApp(new MaterialApp(
    home: new SplashScreen(),
    debugShowCheckedModeBanner: false,
  ));
}



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen>{
  startTime()  {
    var _duration = new Duration(seconds: 3);

    return new Timer(_duration, navigationPage);

  }


  Future<void> navigationPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('Token');
    // if (token == null) {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => Homepages()),
    //   );
    // }
    // else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Timeline()),
      );
    // }
  }
  @override
  void initState(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.blue, // Color for Android
        statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
    ));
    super.initState();

    startTime();
//    setValue();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            new Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
            Container(
            color: Colors.white,
            child:FlutterLogo(size:150)
        ),

                  ],
                )
            ),

          ],
        )
    );
  }
}





