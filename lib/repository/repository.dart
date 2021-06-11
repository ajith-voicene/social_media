import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/failure.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/resources/urls.dart';
import 'package:social_media/utils/constants.dart';
import 'package:social_media/utils/repo.dart';

class Repository {
  final RemoteNetwork netowrk = RemoteNetwork();

  Future<Either<Failure, bool>> login(String token) =>
      repoExecute<bool>(() => netowrk.login(token));

  Future<Either<Failure, bool>> signout() =>
      repoExecute<bool>(() => netowrk.logout());

  Future<Either<Failure, bool>> createPost(File file, String text) =>
      repoExecute<bool>(() => netowrk.createPost(file, text));
  Future<Either<Failure, List<Data>>> getPosts() =>
      repoExecute<List<Data>>(() => netowrk.getPosts());
}

class RemoteNetwork {
  final Dio _client = Dio();

  Future<bool> login(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool success = false;
    Response response = await _client.post(social,
        options: Options(
            headers: {HttpHeaders.contentTypeHeader: 'application/json'}),
        data: jsonEncode({
          "token": token,
          "provider": Constant.provider,
          "device_name": Constant.devicename
        }));

    print(response.data);
    success = response.data['success'];
    if (success) {
      Constant.token = response.data['token'];
      prefs.setString('Token', Constant.token);

      prefs.setString('name', Constant.name);
      prefs.setString('email', Constant.email);
      prefs.setString('provider', Constant.provider);
      prefs.setString('photo', Constant.photoUrl);
    }
    return success;
  }

  Future<bool> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    bool success = false;
    final response = await _client.get(logoutUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    success = response.data['success'];
    if (success == true) {
      pref.remove("Token");
      Constant.token = null;
    }
    print(response.requestOptions.headers);
    return success;
  }

  Future<bool> createPost(File file, String text) async {
    final mime = lookupMimeType(file.path).split("/");
    final fileData = await MultipartFile.fromFile(
      file.path,
      contentType: MediaType(mime.first, mime.last),
    );
    final FormData formData = FormData.fromMap({
      "attachment[0]": fileData,
      "content": text,
    });
    print(Constant.token);
    final response = await _client.post(createPostUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    return response.data['success'];
  }

  Future<List<Data>> getPosts() async {
    final response = await _client.get(timelineUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<Data> list = [];
    // print(response.data);
    (response.data['data'] as List).forEach((element) {
      print(element);
      list.add(Data.fromMap(element));
    });
    // print(list);
    return list;
  }
}
