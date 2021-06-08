import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/common_button.dart';
import 'package:social_media/profile.dart';
import 'package:social_media/single_view.dart';

import 'comment_page.dart';
import 'create_post.dart';
import 'user_profile.dart';
import 'urls.dart';
class Data {
  final String user_name;
  final String post_user_photo;
  final int user_id;
  final int id;
  final String content;
  final int is_liked;
  final String first_attachment_type;
  final String first_attachment_url;
  final int likes;
  final int comments;
  final String created_at;

 Data({this.user_name, this.post_user_photo,this.user_id,this.id,this.content,this.is_liked,this.comments,this.created_at,
    this.first_attachment_type,this.first_attachment_url,this.likes});
  factory Data.fromJson(Map<String, dynamic> parsedJson){
    return Data(
        user_name:parsedJson['user_name'],
        post_user_photo:parsedJson['post_user_photo'],
        user_id:parsedJson['user_id'],
        id:parsedJson['id'],
        content:parsedJson['content'],
        is_liked:parsedJson['is_liked'],
        first_attachment_type:parsedJson['first_attachment_type'],
        first_attachment_url:parsedJson['first_attachment_url'],
        likes:parsedJson['likes'],
        comments:parsedJson['comments'],
        created_at:parsedJson['formatted_time'],
        );

  }
}
class Datass {
  final String file_type;
  final String post_attachment_url;
  final int id;


  Datass({this.file_type, this.post_attachment_url,this.id});
  factory Datass.fromJson(Map<String, dynamic> parsedJson){
    return Datass(
        file_type:parsedJson['file_type'],
        post_attachment_url:parsedJson['post_attachment_url'],
        id:parsedJson['id'],

    );

  }
}
void main() => runApp(new MaterialApp(
    home: new Home()));




class Home extends StatefulWidget {
  const Home({ Key key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  final _textcntrl = TextEditingController();
  String profilePhotoUrl,type="0",myId;

  MaterialColor color;
  Future<bool> _onBackPressed() {
    print("llllll");
    Navigator.pop(context);
  }
  Future getnames() async {
    
  }

  @override
  void initState() {
    getnames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if (profile_photo_url == null) {
    //   profile_photo_url = "https://picsum.photos/250?image=9";
    // } else {
    //   profile_photo_url = profile_photo_url;
    // }
    return  WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.blue,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: new Container(
                                  height: 50,
                                  decoration: new BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),

                                      image: new DecorationImage(
                                        image: NetworkImage(
                                            profilePhotoUrl),
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
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return CreatePost();
                                      },
                                    ),
                                  );
                                },
                                controller: _textcntrl,
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
                                      const Radius.circular(30.0),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.grey[800], width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),

                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(
                                        color: Colors.grey[800], width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(30.0),

                                    ),
                                  ),
                                  hintText: 'Write something here..... ',
                                  labelStyle: TextStyle(color: Colors.grey[800]),

                                ),
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                              ),
                            ),
                          ),

                        ]),
                    SizedBox(height: 5,),
                    FutureBuilder<List<Data>>(
                      future: myHome(),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData) {
                          List data = snapshot.data;
                          print(data);
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, index) {

                                return Container(
                                  margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
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
                                                                  snapshot
                                                                      .data[index]
                                                                      .post_user_photo),
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
                                                        InkWell(
                                                          onTap:() async {
                                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                                            prefs.setString('User_Id',snapshot.data[index].user_id.toString() );
                                                            if(myId==snapshot.data[index].user_id.toString()){
                                                              Navigator.of(context).push(
                                                                MaterialPageRoute(
                                                                  builder: (context) {
                                                                    return Profile();
                                                                  },
                                                                ),
                                                              );
                                                            }else{
                                                            user_profilesss();}
                                                          },
                                                          child: Padding(
                                                            padding: const EdgeInsets
                                                                .fromLTRB(
                                                                15, 10, 0, 0),
                                                            child: Text(
                                                              snapshot.data[index]
                                                                  .user_name,
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight: FontWeight
                                                                      .bold),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets
                                                              .fromLTRB(
                                                              15, 2, 0, 0),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                snapshot.data[index].created_at+"   ",
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
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Text(snapshot.data[index].content, style: TextStyle(
                                                fontSize: 16.0, color: Colors.black),),
                                          ),
                                        ),
                                     // ignore: unrelated_type_equality_checks
                                   (snapshot.data[index]
                                            .first_attachment_type=="image/jpeg"||snapshot.data[index]
                                       .first_attachment_type=="image/gif")?
                                   InkWell(
                                     onTap:() async {
                                       SharedPreferences prefs = await SharedPreferences.getInstance();
                                       prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                       prefs.setString('content',snapshot.data[index].content);
                                       prefs.setString('first_attachment_url',snapshot.data[index].first_attachment_url);
                                       prefs.setString('first_attachment_type',snapshot.data[index].first_attachment_type);
                                       Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => SingleView()), (r) => false);
                                     },
                                     child: Image.network(
                                         snapshot.data[index]
                                             .first_attachment_url,
                                         // width: 300,
                                         height: 250,
                                         fit: BoxFit.fill

                                     ),
                                   ):
                                       Container(
                                         height: 0,
                                       ),

                                        (snapshot.data[index]
                                            .first_attachment_type=="video/mp4")?
                                        InkWell(
                                          onTap:() async {
                                            SharedPreferences prefs = await SharedPreferences.getInstance();
                                            prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                            prefs.setString('content',snapshot.data[index].content);
                                            prefs.setString('first_attachment_url',snapshot.data[index].first_attachment_url);
                                            prefs.setString('first_attachment_type',snapshot.data[index].first_attachment_type);
                                            Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => SingleView()), (r) => false);
                                          },
                                          child: Container(
                                            height: 250,
                                            decoration: new BoxDecoration(
                                              image: new DecorationImage(
                                                image: new AssetImage("images/thumbb.jpg"),
                                                fit: BoxFit.cover,),
                                            ),
                                          ),
                                        ):
                                        Container(
                                          height: 0,
                                        ),
                                        Row(mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween, children: [

                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 5, 10, 0),
                                            child: Row(

                                              children: [
                                                Icon(Icons.thumb_up_alt,
                                                  color: Colors.lightBlue,
                                                  size: 20,),
                                                Text(
                                                 "  "+ snapshot.data[index].likes.toString(),
                                                  style: TextStyle(fontSize: 15.0,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 5, 5, 0),
                                            child: Text(
                                            snapshot.data[index].comments.toString()+  " Comments",
                                              style: TextStyle(fontSize: 15.0,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,),
                                            ),
                                          ),
                                        ]),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              5, 4, 5, 4),
                                          child: Divider(
                                            color: Colors.grey,
                                            thickness: 1,
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap:() async {
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  prefs.setString('Post_Id',snapshot.data[index].id.toString() );

                                                  if (snapshot.data[index].is_liked==0){
                                                    setState(() {
                                                      type="1";
                                                      reaction();
                                                      // color=Colors.blue;

                                                    });
                                                  }else{
                                                    setState(() {
                                                      type="0";
                                                      reaction();
                                                      // color=Colors.grey;
                                                    });
                                                  }

                                                },
                                                child:Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(5, 5, 0, 8),
                                                  child: Row(
                                                    children: [
                                                      (snapshot.data[index].is_liked==0)?
                                                      Icon(Icons.thumb_up_alt,
                                                        color: Colors.grey,
                                                        size: 20,): Icon(Icons.thumb_up_alt,
                                                        color: Colors.blue,
                                                        size: 20,),
                                                      Text(
                                                        "   Like     ",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold,),
                                                      ),

                                                    ],
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  SharedPreferences prefs = await SharedPreferences.getInstance();
                                                  prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                                  prefs.setString('post_user_photo',snapshot.data[index].post_user_photo);
                                                  prefs.setString('user_name',snapshot.data[index].user_name);
                                                  prefs.setString('content',snapshot.data[index].content);
                                                  prefs.setString('first_attachment_url',snapshot.data[index].first_attachment_url);
                                                  prefs.setString('likes',snapshot.data[index].likes.toString());
                                                  prefs.setString('is_liked',snapshot.data[index].is_liked.toString());
                                                  prefs.setString('comments',snapshot.data[index].comments.toString());
                                                  prefs.setString('created_at',snapshot.data[index].created_at);
                                                  prefs.setString('first_attachment_type',snapshot.data[index].first_attachment_type);
                                                  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => CommentPage()), (r) => false);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .fromLTRB(0, 5, 0, 8),
                                                  child: Row(

                                                    children: [
                                                      Icon(Icons.comment,
                                                        color: Colors.grey,
                                                        size: 20,),
                                                      Text(
                                                        "   Comment",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight
                                                              .bold,),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets
                                                    .fromLTRB(0, 5, 8, 2),
                                                child: Row(

                                                  children: [
                                                    Icon(Icons.share_sharp,
                                                      color: Colors.grey,
                                                      size: 20,),
                                                    Text(
                                                      "   Share",
                                                      style: TextStyle(
                                                        fontSize: 15.0,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .bold,),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                        // InkWell(
                                        //   onTap: () async {
                                        //     SharedPreferences prefs = await SharedPreferences.getInstance();
                                        //     prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                        //     prefs.setString('post_user_photo',snapshot.data[index].post_user_photo);
                                        //     prefs.setString('user_name',snapshot.data[index].user_name);
                                        //     prefs.setString('content',snapshot.data[index].content);
                                        //     prefs.setString('first_attachment_url',snapshot.data[index].first_attachment_url);
                                        //     prefs.setString('likes',snapshot.data[index].likes.toString());
                                        //     prefs.setString('is_liked',snapshot.data[index].is_liked.toString());
                                        //     prefs.setString('comments',snapshot.data[index].comments.toString());
                                        //     Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => comment_page()), (r) => false);
                                        //   },
                                        //   child: Padding(
                                        //     padding: const EdgeInsets.fromLTRB(
                                        //         10, 8, 5, 8),
                                        //     child: Text(
                                        //       "View all Comments ("+snapshot.data[index].comments.toString()+")",style: TextStyle(
                                        //       color: Colors.red,fontSize: 15
                                        //     ),
                                        //     ),
                                        //   ),
                                        // ),
                                        // Padding(
                                        //   padding: const EdgeInsets.fromLTRB(8, 5, 8, 8),
                                        //   child: Row(
                                        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        //       children: [
                                        //         Padding(
                                        //           padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                        //           child: CircleAvatar(
                                        //             radius: 15,
                                        //             backgroundColor: Colors.blue,
                                        //             child: ClipRRect(
                                        //               borderRadius: BorderRadius.circular(50),
                                        //               child: new Container(
                                        //                 height: 50,
                                        //                 decoration: new BoxDecoration(
                                        //                     borderRadius: BorderRadius.circular(50),
                                        //
                                        //                     image: new DecorationImage(
                                        //                       image: NetworkImage(
                                        //                           profile_photo_url),
                                        //                       fit: BoxFit.cover,
                                        //                     )),
                                        //                 // width: 60,
                                        //
                                        //               ),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         Container(
                                        //           child: Expanded(
                                        //             child: new TextFormField(
                                        //               onTap: () async {
                                        //                 SharedPreferences prefs = await SharedPreferences.getInstance();
                                        //                 prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                        //                 prefs.setString('post_user_photo',snapshot.data[index].post_user_photo);
                                        //                 prefs.setString('user_name',snapshot.data[index].user_name);
                                        //                 prefs.setString('content',snapshot.data[index].content);
                                        //                 prefs.setString('first_attachment_url',snapshot.data[index].first_attachment_url);
                                        //                 prefs.setString('likes',snapshot.data[index].likes.toString());
                                        //                 prefs.setString('is_liked',snapshot.data[index].is_liked.toString());
                                        //                 prefs.setString('comments',snapshot.data[index].comments.toString());
                                        //                 Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => comment_page()), (r) => false);
                                        //               },
                                        //               controller:_commentcntrl,
                                        //               keyboardType: null,
                                        //               maxLines: 5,
                                        //               minLines: 1,
                                        //               cursorColor: Colors.black,
                                        //               enableInteractiveSelection: false,
                                        //               autocorrect: true,
                                        //               decoration: new InputDecoration(
                                        //
                                        //                 enabledBorder: OutlineInputBorder(
                                        //                   borderSide:
                                        //                   BorderSide(
                                        //                       color: Colors.grey[800], width: 1.0),
                                        //                   borderRadius: const BorderRadius.all(
                                        //                     const Radius.circular(10.0),
                                        //                   ),
                                        //                 ),
                                        //                 border: OutlineInputBorder(
                                        //                   borderSide:
                                        //                   BorderSide(
                                        //                       color: Colors.grey[800], width: 1.0),
                                        //                   borderRadius: const BorderRadius.all(
                                        //                     const Radius.circular(10.0),
                                        //
                                        //                   ),
                                        //                 ),
                                        //                 focusedBorder: OutlineInputBorder(
                                        //                   borderSide:
                                        //                   BorderSide(
                                        //                       color: Colors.grey[800], width: 1.0),
                                        //                   borderRadius: const BorderRadius.all(
                                        //                     const Radius.circular(10.0),
                                        //
                                        //                   ),
                                        //                 ),
                                        //                 hintText: 'Write a comment..... ',
                                        //                 labelStyle: TextStyle(color: Colors.grey[800]),
                                        //
                                        //               ),
                                        //               style: TextStyle(
                                        //                   fontSize: 16.0, color: Colors.black),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         InkWell(
                                        //           onTap: () async {
                                        //             SharedPreferences prefs = await SharedPreferences.getInstance();
                                        //             prefs.setString('Post_Id',snapshot.data[index].id.toString() );
                                        //           },
                                        //           child: Padding(
                                        //             padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                                        //             child:   Icon(Icons.send,color: Colors.blue,size: 20,),
                                        //           ),
                                        //         ),
                                        //       ]),
                                        // ),

                                      ],
                                    ),
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
                              CommonButton(
                                label:
                                  'Go Back',
                                  
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
              )
          ),
    );
  }

  Future<List<Data>> myHome() async {
    //replace your restFull API here.
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");

    print('Bearer $token');
    // final response = await http.get(Timeline_url,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    // );
    // Map<String, dynamic> responseData = json.decode(response.body);
    // var list = responseData['data'] as List;
    // // print("list====");
    // // print(list);
    // List<Data> imagesList = list.map((i) => Data.fromJson(i)).toList();
    // return imagesList;
  }
  Future<String> user_profilesss() async { // <------ CHANGED THIS LINE

    String userId;
    print("token123");
    
    // final response = await http.get(
    //   single_user+userId,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    // );
    // Map<String, dynamic> responseJson = json.decode(response.body);
    // print(responseJson);
    // var message,success;
    // message = responseJson["message"];
    // success = responseJson["success"];
    // if (success == true) {
    //   print('RETURNING: ' + response.body);
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('User_Name', responseJson['data']['name']);
    //   prefs.setString('User_EmailId', responseJson['data']['email']);
    //   prefs.setString('User_profile_photo_url', responseJson['data']['profile_photo_url']);
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return user_profile();
    //       },
    //     ),
    //   );
      // print('RETURNING: ' + response.body);
      // Fluttertoast.showToast(
      //     msg:message,
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 14.0
      // );



    // } else {
    //   Fluttertoast.showToast(
    //       msg:message,
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 14.0
    //   );
    //   throw Exception('Failed to load post');

    // }
  }
  // Future<List<Datass>> my_image() async {
  //
  //   //replace your restFull API here.
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String token = pref.getString("Token");
  //
  //   print('Bearer $token');
  //   final response = await http.get(Timeline_url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //   Map<String, dynamic> responseData = json.decode(response.body);
  //   var data = json.decode(response.body);
  //   // for (var record in recordsList) {
  //   //   var familyMembers = record["post_attachment"];
  //   //   print(familyMembers);
  //   //   for (var familyMember in familyMembers) { //prints the name of each family member
  //   //     var familyMemberName = familyMember["post_attachment_url"];
  //   //     print("familyMemberName");
  //   //     print(familyMemberName);
  //   //   }
  //   // }
  //
  //
  //   // for (var record in recordsList) {
  //   //   var familyMembers = record["post_attachment"];
  //   //   print(familyMembers);
  //   //   for (var familyMember in familyMembers) { //prints the name of each family member
  //   //     var familyMemberName = familyMember["post_attachment_url"];
  //   //     print("familyMemberName");
  //   //     print(familyMemberName);
  //   //   }
  //   var familyMembers = data["data"][0]["post_attachment"];
  //   print("familyMembers111");
  //   print(familyMembers);
  //   for (var familyMember in familyMembers) { //prints the name of each family member
  //     var familyMemberName = familyMember["post_attachment_url"];
  //     print("familyMembers222");
  //
  //     print(familyMemberName);
  //   }
  //   // try {
  //   // var list;
  //   //  list= data['data'].forEach((item){
  //   //     // mapping your family_members array
  //   //     item['post_attachment'].forEach((nestedItem){
  //   //       // list=nestedItem['post_attachment_url'];
  //   //      print(nestedItem['post_attachment_url']);
  //   //
  //   //     });
  //   //   });
  //    print("lisst");
  //    print(familyMembers["post_attachment_url"].toString());
  //   // List<Datass> imagesList = list.map((i) => Datass.fromJson(i)).toList();
  //   // return imagesList;
  //   }
  Future<String> reaction() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    // String post_id = pref.getString("Post_Id");
    // print("post_id==");
    // print(post_id);
    // print(type);
    // final response = await http.post(react_postss,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token'
    //     },
    //     body: jsonEncode({
    //       "post_id": post_id,
    //       "type":type,

    //     }));

    // Map<String, dynamic> responseJson = json.decode(response.body);
    // var message, success, user_type, name;
    // message = responseJson["message"];
    // success = responseJson["success"];

    // if (success == true) {
    //   print('RETURNING: ' + response.body);
      // Fluttertoast.showToast(
      //     msg: message,
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 14.0
      // );


    // } else {
      // Fluttertoast.showToast(
      //     msg: message,
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 14.0
      // );

      throw Exception('Failed to load post');
    // }
  }
    }

