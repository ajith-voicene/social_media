import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import 'package:path_provider/path_provider.dart';
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

  Future<Either<Failure, String>> editProfile(
    File file,
    String name,
  ) {
    return repoExecute<String>(() => netowrk.editProfile(
          file,
          name,
        ));
  }

  Future<Either<Failure, User>> getProfile(String id) {
    return repoExecute<User>(() => netowrk.getProfile(id));
  }

  Future<Either<Failure, void>> logout() {
    return repoExecute<void>(() => netowrk.logout());
  }

  Future<Either<Failure, File>> downloadFile(url, String postid, String ext) {
    return repoExecute<File>(() => netowrk.downloadFile(url, postid, ext));
  }

  Future<Either<Failure, List<User>>> searchUsers(String name) {
    return repoExecute<List<User>>(() => netowrk.searchUsers(name));
  }

  Future<Either<Failure, bool>> manageFriendrequest(
      String type, String userID) {
    return repoExecute<bool>(() => netowrk.manageFriendrequest(type, userID));
  }

  Future<Either<Failure, TripleResponse>> getFriendrequests() {
    return repoExecute<TripleResponse>(() => netowrk.getFriendrequests());
  }

  Future<Either<Failure, List<User>>> getfriendsList() {
    return repoExecute<List<User>>(() => netowrk.getfriendsList());
  }

  Future<Either<Failure, List<User>>> getFollowingsList() {
    return repoExecute<List<User>>(() => netowrk.getfollowingList());
  }

  Future<Either<Failure, List<User>>> getFollowersList() {
    return repoExecute<List<User>>(() => netowrk.getfollowersList());
  }

  Future<Either<Failure, bool>> manageFollow(String type, String id) {
    return repoExecute<bool>(() => netowrk.manageFollow(type, id));
  }

  Future<Either<Failure, bool>> sendMessage(String message, String userId) {
    return repoExecute<bool>(() => netowrk.sendMessage(message, userId));
  }

  Future<Either<Failure, List<Message>>> getMessage(String userId) {
    return repoExecute<List<Message>>(() => netowrk.getMessages(userId));
  }

  Future<Either<Failure, List<User>>> getMessageHistory() {
    return repoExecute<List<User>>(() => netowrk.getMessageHistory());
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
          "fcm_token": Constant.fcmToken,
          "token": token,
          "provider": Constant.provider,
          "device_name": Constant.devicename
        }));
    print(token);
    success = response.data['success'];
    if (success) {
      Constant.token = response.data['token'];
      Constant.photoUrl = response.data['data']['profile_photo_url'];
      Constant.id = response.data['data']['id'];
      prefs.setString('Token', Constant.token);

      prefs.setString('name', Constant.name);
      prefs.setString('email', Constant.email);
      prefs.setString('provider', Constant.provider);
      prefs.setString('photo', Constant.photoUrl);
      prefs.setInt('id', Constant.id);
    }
    return success;
  }

  Future<bool> logout() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
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
      try {
        googleSignIn.signOut();

        await FacebookAuth.instance.logOut();
        pref.remove("Token");
        Constant.token = null;
      } catch (err) {
        print(err);
      }
    }
    return success;
  }

  Future<bool> createPost(File file, String text) async {
    FormData formData;
    if (file != null) {
      final mime = lookupMimeType(file.path).split("/");
      final fileData = await MultipartFile.fromFile(
        file.path,
        contentType: MediaType(mime.first, mime.last),
      );
      formData = FormData.fromMap({
        "attachment[0]": fileData,
        "content": text,
      });
    } else
      formData = FormData.fromMap({
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

  Future<String> editProfile(File file, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FormData formData;
    if (file != null) {
      final mime = lookupMimeType(file.path).split("/");
      final fileData = await MultipartFile.fromFile(
        file.path,
        contentType: MediaType(mime.first, mime.last),
      );
      formData =
          FormData.fromMap({"avatar": fileData, "name": name, "gender": 20});
    } else
      formData = FormData.fromMap({"name": name, "gender": 20});

    final response = await _client.post(myProfileUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    String msg = response.data['message'];
    bool success = response.data['success'];
    if (success) {
      Constant.photoUrl = response.data['data']['profile_photo_url'];
      Constant.username = name;
      prefs.setString('photo', Constant.photoUrl);

      prefs.setString('username', name);
    }
    return success ? msg : null;
  }

  Future<User> getProfile(String id) async {
    String path =
        id == Constant.id.toString() ? myProfileUrl : singleUserUrl + id;
    final response = await _client.get(path,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    User user = User.fromMap(response.data['data']);
    return user;
  }

  Future<File> downloadFile(url, String postid, String ext) async {
    File file;
    Directory dir = await getTemporaryDirectory();
    String filepath = dir.path + "/" + postid + ".$ext";
    final response = await _client.download(
      url,
      filepath,
    );
    if (response.statusCode != 200) throw NetworkFailure();
    file = File(filepath);
    file.readAsBytes();
    return file;
  }

  Future<List<User>> searchUsers(String name) async {
    String filter = name == null ? null : "?search=$name";
    final response = await _client.get(searchUserUrl + filter,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(User.fromMap(element));
    });
    return list;
  }

  Future<bool> manageFriendrequest(String type, String userID) async {
    // type="accept","add","reject","block","delete";
    FormData formData = FormData.fromMap({"user_id": userID, "type": type});
    final response = await _client.post(manageFriendUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    // String msg = response.data['message'];

    bool success = response.data['success'];
    return success;
  }

  Future<TripleResponse> getFriendrequests() async {
    final response = await _client.get(getFriendRequestsUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<User> received = [];
    (response.data['received'] as List).forEach((element) {
      received.add(User.fromMap(element));
    });
    List<User> send = [];
    (response.data['sent'] as List).forEach((element) {
      send.add(User.fromMap(element));
    });
    List<User> hide = [];
    (response.data['hidden'] as List).forEach((element) {
      hide.add(User.fromMap(element));
    });
    return TripleResponse(send, received, hide);
  }

  Future<List<User>> getfriendsList() async {
    final response = await _client.get(viewAllFriendsUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<User> list = [];
    (response.data['data']['data'] as List).forEach((element) {
      list.add(User.fromMap(element));
    });
    return list;
  }

  Future<List<User>> getfollowersList() async {
    final response = await _client.get(getFollowersUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(User.fromMap(element));
    });
    return list;
  }

  Future<List<User>> getfollowingList() async {
    final response = await _client.get(getFollowingUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(User.fromMap(element));
    });
    return list;
  }

  Future<void> getnotifications() async {
    final response = await _client.get(getNotificationUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    print(response.data['data']);
    // List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      // list.add(User.fromMap(element));
    });
    // return list;
  }

  Future<void> setnotificationReaded(String id) async {
    final response = await _client.get(setNotificationReadUrl + id,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    print(response.data['data']);
    // List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      // list.add(User.fromMap(element));
    });
    // return list;
  }

  Future<bool> manageFollow(String type, String id) async {
    // type="accept","add","reject","block","delete";
    FormData formData = FormData.fromMap({"user_id": id, "type": type});
    final response = await _client.post(manageFollowUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    // String msg = response.data['message'];
    bool success = response.data['success'];
    return success;
  }

  Future<bool> sendMessage(String message, String id) async {
    // type="accept","add","reject","block","delete";
    FormData formData =
        FormData.fromMap({"receiver_id": id, "message": message});
    final response = await _client.post(sendMessageUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));

    // String msg = response.data['message'];
    // print(response.data);
    bool success = response.data['success'];
    return success;
  }

  Future<bool> deleteMessage(String messageId) async {
    // type="accept","add","reject","block","delete";
    FormData formData = FormData.fromMap({"message_id": messageId});
    final response = await _client.post(deleteMesssageUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    // String msg = response.data['message'];
    bool success = response.data['success'];
    return success;
  }

  Future<List<Message>> getMessages(String id) async {
    final response = await _client.get(getMessagesUrl + id,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    // print(response.data['data']);
    List<Message> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(Message.fromMap(element));
    });
    return list;
  }

  Future<List<User>> getMessageHistory() async {
    final response = await _client.get(chatHistoryUrl,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ${Constant.token}'
          },
        ));
    print(response.data['data']);
    List<User> list = [];
    (response.data['data'] as List).forEach((element) {
      list.add(User.fromMap(element));
    });
    return list;
  }
}
