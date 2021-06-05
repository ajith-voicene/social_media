import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'urls.dart';

Future<String> my_profile() async { // <------ CHANGED THIS LINE

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString("Token");
  print("token123");
  print(token);
  final response = await http.get(
    my_Profile_url,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  Map<String, dynamic> responseJson = json.decode(response.body);
  print(responseJson);
  var message,success;
  message = responseJson["message"];
  success = responseJson["success"];
  if (success == true) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Name', responseJson['data']['name']);
    prefs.setString('EmailId', responseJson['data']['email']);
    prefs.setString('profile_photo_url', responseJson['data']['profile_photo_url']);
    print('RETURNING: ' + response.body);
    // Fluttertoast.showToast(
    //     msg:message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIos: 1,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 14.0
    // );



  } else {
    Fluttertoast.showToast(
        msg:message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0
    );
    throw Exception('Failed to load post');

  }
}
