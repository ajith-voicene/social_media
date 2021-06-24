import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_media/features/Timeline/bloc/timelineFeed/timelineFeed_cubit.dart';
import 'package:social_media/main.dart';
import 'package:social_media/resources/fcmServices.dart';
import '../../../common_widgets/Drawers.dart';
import 'Home.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification androidNotification = message.notification?.android;
      if (notification != null && androidNotification != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              color: Colors.blue,
              playSound: true,
              icon: "@mipmap/ic_launcher",
            )),
            payload: message.data.toString());
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      PushNotificationService.onNotificationHandling(message);
    });
  }

  Widget appBarTitle = new Text(
    " Social Media",
    style: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
            bottom: TabBar(
              tabs: [Tab(icon: Icon(Icons.home)), Tab(icon: Icon(Icons.menu))],
            ),
            title: appBarTitle,
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<TimelineFeedCubit>(
                    create: (context) => TimelineFeedCubit()..getPosts())
              ],
              child: TabBarView(
                children: [
                  Container(child: Home()),
                  Container(child: Drawers()),
                ],
              ),
            ),
          ),
        ));
  }
}
