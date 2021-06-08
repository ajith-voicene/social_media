import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'timeline.dart';
import 'urls.dart';

class SingleView extends StatefulWidget {
  const SingleView({ Key key }) : super(key: key);

  @override
  _SingleViewState createState() => _SingleViewState();
}

class _SingleViewState extends State<SingleView> {
  
  String profilePhotoUrl,comments,first_attachment_type,post_user_photo,Post_Id,user_name,content,first_attachment_url,likes,is_liked,type="0";
  
  Future getnames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    profilePhotoUrl = prefs.getString('profile_photo_url');
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

    
  }
  // ignore: missing_return
  Future<bool> _onWillPop() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return TimeLine();
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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // if(first_attachment_type=="video/mp4") {
    //   _videoPlayerController1 =
    //       VideoPlayerController.network(
    //           first_attachment_url);
    //   _chewieController = ChewieController(
    //     videoPlayerController: _videoPlayerController1,
    //     aspectRatio: 3 / 2,
    //     autoPlay: true,
    //     looping: false,
    //   );
    // }
    // if(content==null){
    //   content=" ";
    // }else{
    //   content=content;
    // }
    return  WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return TimeLine();
                      },
                    ),
                  );
                },
                child: Icon(Icons.arrow_back,size:25,)),
            title:Text("Social Media")
        ),
        body: Center(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
            child: Center(
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
SizedBox(height: 10,),
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
                        height: 300,
                        fit: BoxFit.fill

                    ):
                    Container(
                      height: 0,
                    ),

                    (first_attachment_type=="video/mp4")?

                    Container(
                      height: 400,
                      // child: Chewie(
                      //   controller: _chewieController,
                      // ),
                    ):
                    Container(
                      height: 0,
                    ),


                  ],
                ),
              ),
            ),
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
    //   Fluttertoast.showToast(
    //       msg: message,
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 14.0
    //   );


    // } else {
    //   Fluttertoast.showToast(
    //       msg: message,
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
}

