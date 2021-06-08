import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/resources/urls.dart';
import 'package:social_media/urls.dart';
import 'package:social_media/utils/constants.dart';
import 'package:social_media/utils/repo.dart';

class Repository {
  final RemoteNetwork netowrk = RemoteNetwork();

  Future<Either<Failure, bool>> login(String token) =>
      repoExecute<bool>(() => netowrk.login(token));

  Future<Either<Failure, bool>> signout() =>
      repoExecute<bool>(() => netowrk.logout());
}

class RemoteNetwork {
  final Dio _client = Dio();

  Future<bool> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = false;
    final response = await _client.post(social,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
        data: jsonEncode({
          "token": Constant.token,
          "provider": Constant.provider,
          "device_name": Constant.devicename
        }));

    success = response.data['success'];
    if (success) {
      Constant.token = token;
      // prefs.setString('Token',token);
    }

    return success;
  }

  Future<bool> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    bool success = false;
    final response = await _client.get(
      logoutUrl,
      options: Options(headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      }),
    );

    success = response.data['success'];
    if (success == true) {
      pref.remove("Token");
      Constant.token = null;
    }
    return success;
  }
}
