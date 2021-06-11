import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/model/home_models.dart';

import 'features/Timeline/pages/timeline.dart';

class SingleView extends StatefulWidget {
  final Data data;
  const SingleView(this.data, {Key key}) : super(key: key);

  @override
  _SingleViewState createState() => _SingleViewState();
}

class _SingleViewState extends State<SingleView> {
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
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: AppBar(
      //     leading: InkWell(
      //         onTap: () {
      //           Navigator.of(context).push(
      //             MaterialPageRoute(
      //               builder: (context) {
      //                 return TimeLine();
      //               },
      //             ),
      //           );
      //         },
      //         child: Icon(
      //           Icons.arrow_back,
      //           size: 25,
      //         )),
      //     title: Text("Social Media")),
      body: Center(
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
          child: Center(
            child: Card(
              margin: EdgeInsets.zero,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(0.0))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Text(
                        widget.data.content,
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ),
                  // ignore: unrelated_type_equality_checks
                  (widget.data.firstAttachmentType == "image/jpeg")
                      ? Image.network(widget.data.firstAttachmentUrl,
                          // width: 300,
                          height: 300,
                          fit: BoxFit.fill)
                      : Container(
                          height: 0,
                        ),

                  (widget.data.firstAttachmentType == "video/mp4")
                      ? Container(
                          height: 400,
                          // child: Chewie(
                          //   controller: _chewieController,
                          // ),
                        )
                      : Container(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  Future<String> reaction() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    String post_id = pref.getString("Post_Id");

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
