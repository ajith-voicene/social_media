import 'dart:convert';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/Home.dart';
import 'package:social_media/create_post.dart';
import 'package:social_media/timeline.dart';
import 'package:video_player/video_player.dart';

import 'Homepages.dart';
import 'urls.dart';
class Data {
  final String created_at;
  final String user_name;
 final String content;


  Data({this.created_at, this.user_name,this.content});
  factory Data.fromJson(Map<String, dynamic> parsedJson){
    return Data(
        created_at:parsedJson['created_at'],
        user_name:parsedJson['user_name'],
        content:parsedJson['content'],

    );

  }
}
void main() {
  runApp(comment_page());
}



class comment_page extends StatefulWidget {
  @override
  comment_page_State createState() {
    return new comment_page_State();
  }
}
class comment_page_State extends State<comment_page> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textcntrl = TextEditingController();
  final _commentcntrl =TextEditingController();
  String profile_photo_url,comments,first_attachment_type,created_at,post_user_photo,Post_Id,user_name,content,first_attachment_url,likes,is_liked,type="0";
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  Future getnames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profile_photo_url = prefs.getString('profile_photo_url');
    post_user_photo = prefs.getString('post_user_photo');
    Post_Id = prefs.getString('Post_Id');
    post_user_photo = prefs.getString('post_user_photo');
    user_name = prefs.getString('user_name');
    content = prefs.getString('content');
    first_attachment_url = prefs.getString('first_attachment_url');
    likes = prefs.getString('likes');
    is_liked = prefs.getString('is_liked');
    comments=prefs.getString('comments');
    first_attachment_type=prefs.getString('first_attachment_type');
    created_at=prefs.getString('created_at');

    setState(() {
      profile_photo_url=profile_photo_url;
      post_user_photo = post_user_photo;
      Post_Id=Post_Id;
      user_name=user_name;
      content=content;
      first_attachment_url=first_attachment_url;
      likes=likes;
      is_liked=is_liked;
      comments=comments;
      first_attachment_type=first_attachment_type;
      created_at=created_at;
    });
  }
  // ignore: missing_return
  Future<bool> _onWillPop() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Timeline();
        },
      ),
    );
  }
  @override
  void initState() {
    getnames();
    super.initState();
  }
  @override
  void dispose() {
    _videoPlayerController1.dispose();
    // _videoPlayerController2.dispose();
    _chewieController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(first_attachment_type=="video/mp4") {
      _videoPlayerController1 =
          VideoPlayerController.network(
              first_attachment_url);
      _chewieController = ChewieController(
        videoPlayerController: _videoPlayerController1,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
      );
    }
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return Timeline();
                  },
                ),
              );
            },
              child: Icon(Icons.arrow_back,size:25,)),
            title:Text("Social Media")
        ),
              body: SingleChildScrollView(
                child: Column(

                  children: [
    // SizedBox(height:5),
                    Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                                  child: Card(
                                    margin: EdgeInsets.zero,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(0.0))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .stretch,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      8.0),
                                                  child: CircleAvatar(
                                                    radius: 20,
                                                    backgroundColor: Colors.blue,
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius
                                                          .circular(50),
                                                      child: new Container(
                                                        height: 50,
                                                        decoration: new BoxDecoration(
                                                            borderRadius: BorderRadius
                                                                .circular(50),
                                                            image: new DecorationImage(
                                                              image: NetworkImage(
                                                                 post_user_photo),
                                                              fit: BoxFit.cover,
                                                            )),
                                                        // width: 60,

                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Center(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .stretch,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              15, 10, 0, 0),
                                                          child: Text(
                                                          user_name,
                                                            style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .bold),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              15, 2, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                created_at+"   ",
                                                                style: TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black,),
                                                              ),
                                                              Icon(Icons.group,
                                                                color: Colors
                                                                    .black,
                                                                size: 20,),
                                                            ],
                                                          ),
                                                        ),

                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                            child: Text(content, style: TextStyle(
                                                fontSize: 16.0, color: Colors.black),),
                                          ),
                                        ),
                                        // ignore: unrelated_type_equality_checks
                                        (first_attachment_type=="image/jpeg")?
                                        Image.network(
                                            first_attachment_url,
                                            // width: 300,
                                            height: 250,
                                            fit: BoxFit.fill

                                        ):
                                        Container(
                                          height: 0,
                                        ),

                                        (first_attachment_type=="video/mp4")?

                                        Container(
                                          height: 250,
                                          child: Chewie(
                                            controller: _chewieController,
                                          ),
                                        ):
                                        Container(
                                          height: 0,
                                        ),
                                        // Row(mainAxisAlignment: MainAxisAlignment
                                        //     .spaceBetween, children: [
                                        //
                                        //   Padding(
                                        //     padding: const EdgeInsets.fromLTRB(
                                        //         10, 5, 10, 0),
                                        //     child: Row(
                                        //
                                        //       children: [
                                        //         Icon(Icons.thumb_up_alt,
                                        //           color: Colors.lightBlue,
                                        //           size: 20,),
                                        //         Text(
                                        //           "  "+ likes.toString(),
                                        //           style: TextStyle(fontSize: 15.0,
                                        //             color: Colors.black,
                                        //             fontWeight: FontWeight.bold,),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        //   Padding(
                                        //     padding: const EdgeInsets.fromLTRB(
                                        //         0, 5, 5, 0),
                                        //     child: Text(
                                        //       comments+" Comments",
                                        //       style: TextStyle(fontSize: 15.0,
                                        //         color: Colors.black,
                                        //         fontWeight: FontWeight.bold,),
                                        //     ),
                                        //   ),
                                        // ]),
                                        // Padding(
                                        //   padding: const EdgeInsets.fromLTRB(
                                        //       5, 4, 5, 4),
                                        //   child: Divider(
                                        //     color: Colors.grey,
                                        //     thickness: 1,
                                        //   ),
                                        // ),
                                        // Row(
                                        //     mainAxisAlignment: MainAxisAlignment
                                        //         .spaceBetween,
                                        //     children: [
                                        //       InkWell(
                                        //         onTap:() async {
                                        //           SharedPreferences prefs = await SharedPreferences.getInstance();
                                        //           prefs.setString('Post_Id',Post_Id.toString() );
                                        //           reaction();
                                        //           if (is_liked=="0"){
                                        //             setState(() {
                                        //               type="1";
                                        //             });
                                        //           }else{
                                        //             setState(() {
                                        //               type="0";
                                        //             });
                                        //           }
                                        //         },
                                        //         child:Padding(
                                        //           padding: const EdgeInsets
                                        //               .fromLTRB(2, 5, 0, 8),
                                        //           child: Row(
                                        //             children: [
                                        //               // ignore: unrelated_type_equality_checks
                                        //               (is_liked=="0")?  Icon(Icons.thumb_up_alt,
                                        //                 color: Colors.grey,
                                        //                 size: 20,): Icon(Icons.thumb_up_alt,
                                        //                 color: Colors.blue,
                                        //                 size: 20,),
                                        //               Text(
                                        //                 "   Like",
                                        //                 style: TextStyle(
                                        //                   fontSize: 15.0,
                                        //                   color: Colors.black,
                                        //                   fontWeight: FontWeight
                                        //                       .bold,),
                                        //               ),
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets
                                        //             .fromLTRB(0, 5, 0, 8),
                                        //         child: Row(
                                        //
                                        //           children: [
                                        //             Icon(Icons.comment,
                                        //               color: Colors.blue,
                                        //               size: 20,),
                                        //             Text(
                                        //               "   Comment",
                                        //               style: TextStyle(
                                        //                 fontSize: 15.0,
                                        //                 color: Colors.black,
                                        //                 fontWeight: FontWeight
                                        //                     .bold,),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       Padding(
                                        //         padding: const EdgeInsets
                                        //             .fromLTRB(0, 5, 8, 2),
                                        //         child: Row(
                                        //
                                        //           children: [
                                        //             Icon(Icons.share_sharp,
                                        //               color: Colors.blue,
                                        //               size: 20,),
                                        //             Text(
                                        //               "   Share",
                                        //               style: TextStyle(
                                        //                 fontSize: 15.0,
                                        //                 color: Colors.black,
                                        //                 fontWeight: FontWeight
                                        //                     .bold,),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //     ]),


                                      ],
                                    ),
                                  ),
                                ),
                    FutureBuilder<List<Data>>(
                      future: comment(),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData) {
                          List data = snapshot.data;
                          print(data);
                          return ListView.builder(
                              // controller: _scrollController,
                              shrinkWrap: true,
                               scrollDirection: Axis.vertical,
                               physics: NeverScrollableScrollPhysics(),
                              // physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {
                                var item = snapshot.data[index];
                                return InkWell(
                                  child: Container(
                                    child: Row(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [

                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .stretch,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    constraints: BoxConstraints(minWidth: 50, maxWidth: 250),
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      color: Colors.grey.shade200),
                                                    child: ListTile(
                                                      title: Padding(
                                                        padding: const EdgeInsets.all(4.0),
                                                        child: Text(
                                                          snapshot.data[index]
                                                              .user_name,
                                                          textAlign: TextAlign
                                                              .start,
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 12.0,
                                                          ),
                                                        ),
                                                      ),
                                                      subtitle: Column(
                                                        crossAxisAlignment: CrossAxisAlignment
                                                            .stretch,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment
                                                                .spaceBetween,
                                                            children: [
                                                              // Text(
                                                              //   snapshot
                                                              //       .data[index]
                                                              //       .user_name +
                                                              //       " : ",
                                                              //   textAlign: TextAlign
                                                              //       .start,
                                                              //   style: TextStyle(
                                                              //     color: Colors
                                                              //         .white,
                                                              //     fontSize: 18.0,
                                                              //   ),
                                                              // ),
                                                              Expanded(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(4.0),
                                                                  child: Text(
                                                                    snapshot
                                                                        .data[index]
                                                                        .content,
                                                                    textAlign: TextAlign
                                                                        .start,
                                                                    style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize: 16.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),
                                        ]),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return AlertDialog(
                            title: Text(
                              'An Error Occured!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.redAccent,
                              ),
                            ),
                            content: Text(
                              "${snapshot.error}",
                              // 'Please try again later',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text(
                                  'Go Back',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            ],
                          );
                        }
                        // By default, show a loading spinner.
                        return Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue[900]),
                              ),
                              SizedBox(width: 20),
                              Text('Loading....')
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
          bottomNavigationBar:   Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.blue,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: new Container(
                      height: 50,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(50),

                          image: new DecorationImage(
                            image: NetworkImage(
                                profile_photo_url),
                            fit: BoxFit.cover,
                          )),
                      // width: 60,

                    ),
                  ),
                ),
              ),
              Container(
                child: Expanded(
                  child: new TextFormField(
                    controller:_commentcntrl,
                    keyboardType: null,
                    maxLines: 5,
                    minLines: 1,
                    cursorColor: Colors.black,
                    enableInteractiveSelection: false,
                    autocorrect: true,
                    decoration: new InputDecoration(

                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Colors.grey[800], width: 1.0),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Colors.grey[800], width: 1.0),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),

                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(
                            color: Colors.grey[800], width: 1.0),
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(10.0),

                        ),
                      ),
                      hintText: 'Write a comment..... ',
                      labelStyle: TextStyle(color: Colors.grey[800]),

                    ),
                    style: TextStyle(
                        fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('Post_Id',Post_Id.toString() );
                  post_comment();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                  child:   Icon(Icons.send,color: Colors.blue,size: 20,),
                ),
              ),
            ]),
      ),
    ),
        resizeToAvoidBottomInset: false,
          ),
    );
  }


  Future<String> reaction() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    String post_id = pref.getString("Post_Id");
    print("post_id==");
    print(post_id);
    print(type);
    final response = await http.post(react_postss,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "post_id": post_id,
          "type":type,

        }));

    Map<String, dynamic> responseJson = json.decode(response.body);
    var message, success, user_type, name;
    message = responseJson["message"];
    success = responseJson["success"];

    if (success == true) {
      print('RETURNING: ' + response.body);
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );


    } else {
      Fluttertoast.showToast(
          msg: message,
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
  Future<String> post_comment() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    String post_id = pref.getString("Post_Id");
    print("post_id==");
    print(post_id);
    final response = await http.post(comment_post,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode({
          "post_id": post_id,
          "content":_commentcntrl.text

        }));

    Map<String, dynamic> responseJson = json.decode(response.body);
    var message, success, user_type, name;
    message = responseJson["message"];
    success = responseJson["success"];

    if (success == true) {
      print('RETURNING: ' + response.body);
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('is_liked',is_liked.toString() );
      _commentcntrl.clear();
    } else {
      Fluttertoast.showToast(
          msg: message,
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
  Future<List<Data>> comment() async {
    //replace your restFull API here.
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token= pref.getString("Token");

    print('Bearer $token');
    final response = await http.get(get_commentss+Post_Id,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    Map<String, dynamic> responseData = json.decode(response.body);
    var list = responseData['data'] as List;
    print("list====");
    print(list);
    List<Data> imagesList = list.map((i) => Data.fromJson(i)).toList();
    return imagesList;

  }
}

