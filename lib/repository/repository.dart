import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/doubleResult.dart';
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

  Future<Either<Failure, DoubleResponse>> getSinglePost(String id) {
    return repoExecute<DoubleResponse>(() => netowrk.getSinglePost(id));
  }

  Future<Either<Failure, String>> onLiked(int like, String postId) {
    return repoExecute<String>(() => netowrk.onLiked(like, postId));
  }

  Future<Either<Failure, List<Comment>>> getComments(String postId) async {
    return repoExecute<List<Comment>>(() => netowrk.getComments(postId));
  }

  Future<Either<Failure, String>> addComment(
      String postId, String content) async {
    return repoExecute<String>(() => netowrk.addComment(postId, content));
  }
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
    (response.data['data'] as List).forEach((element) {
      list.add(Data.fromMap(element));
    });
    return list;
  }

  Future<DoubleResponse> getSinglePost(String id) async {
    final response = await _client.get(getSinglePostUrl + id,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    bool success = response.data['success'];
    String msg = response.data['message'];
    Data data = Data.fromJson(response.data['data']);
    return DoubleResponse(data, success ? msg : null);
  }

  Future<String> onLiked(int like, String postId) async {
    final response = await _client.post(reactPostUrl,
        data: FormData.fromMap({
          "post_id": postId,
          "type": like,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    String msg = response.data['message'];
    bool success = response.data['success'];
    return success ? null : msg;
  }

  Future<List<Comment>> getComments(String postId) async {
    final response = await _client.get(getCommentsUrl + postId,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<Comment> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(Comment.fromMap(element));
    });

    return list;
  }

  Future<String> addComment(String postId, String content) async {
    final response = await _client.post(commentPostUrl,
        data: FormData.fromMap({
          "post_id": postId,
          "content": content,
        }),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    String msg = response.data['message'];
    bool success = response.data['success'];
    return success ? null : msg;
  }
}
