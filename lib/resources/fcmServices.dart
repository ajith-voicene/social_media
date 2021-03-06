import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:social_media/features/Timeline/pages/Add_friends.dart';
import 'package:social_media/features/auth/pages/login_page.dart';
import 'package:social_media/features/messgging/pages/chat_history.dart';
import 'package:social_media/features/messgging/pages/chat_page.dart';
import 'package:social_media/features/profile/pages/followersPage.dart';
import 'package:social_media/features/profile/pages/followingsPage.dart';
import 'package:social_media/features/profile/pages/friendRequests.dart';
import 'package:social_media/features/profile/pages/user_profile.dart';
import 'package:social_media/features/profile/pages/viewfriends.dart';

import 'navigator.dart';

class PushNotificationService {
  static int getInt(String num) => int.parse(num);
  static Future onPushNotificationHandling(String payload) async {
    Map map = jsonDecode(convertToMap(payload));

    if (map['page'] != null) setNavigate(map['page'], map);
  }

  static onNotificationHandling(RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification androidNotification = message.notification?.android;
    if (notification != null && androidNotification != null) {
      Map map = message.data;
      if (map['page'] != null) setNavigate(map['page'], map);
    }
  }

  static void setNavigate(String page, Map map) {
    switch (page) {
      case "login_page":
        {
          NavigationService.instance.navigateToRoute(LoginPage());
          break;
        }
      case "chat_history_page":
        {
          NavigationService.instance.navigateToRoute(ChatHistory());
          break;
        }
      case "chat_page":
        {
          NavigationService.instance.navigateToRoute(ChatPage(
            userId: getInt(map['user_id']),
            userName: map['user_name'],
          ));
          break;
        }
      case "followers_page":
        {
          NavigationService.instance.navigateToRoute(FollowersPage());
          break;
        }
      case "followings_page":
        {
          NavigationService.instance.navigateToRoute(FollowingsPage());
          break;
        }
      case "friend_requests_page":
        {
          NavigationService.instance.navigateToRoute(FriendRequestsPage());
          break;
        }
      case "user_profile_page":
        {
          NavigationService.instance.navigateToRoute(UserProfile());
          break;
        }
      case "friends_page":
        {
          NavigationService.instance.navigateToRoute(FriendsList());
          break;
        }
      case "search_friends_page":
        {
          NavigationService.instance.navigateToRoute(AddFriends());
          break;
        }

      default:
    }
  }

  static String convertToMap(String payload) {
    String map = "{";
    String text = payload.split("{")[1];
    text = text.split("}")[0];
    List<String> list = text.split(",");
    list.forEach((element) {
      map += "\"${element.split(":")[0].trim()}\"" +
          ":" +
          "\"${element.split(":")[1].trim()}\",";
    });

    if (map != null && map.length > 0) {
      map = map.substring(0, map.length - 1);
    }

    return map + "}";
  }
}

class NotificationData {
  final String page;
  final String arguments;

  NotificationData(
    this.page,
    this.arguments,
  );

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'arguments': arguments,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      map['page'],
      map['arguments'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}
