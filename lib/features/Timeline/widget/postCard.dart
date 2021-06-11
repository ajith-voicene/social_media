import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/robustImage.dart';
import 'package:social_media/model/home_models.dart';

import '../../../profile.dart';

class PostCard extends StatefulWidget {
  final Data data;
  const PostCard(this.data, {Key key}) : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  String type = "0";
  Color color = Colors.grey;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
        child: Card(
            margin: EdgeInsets.zero,
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(0.0))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                          widget.data.postUserPhoto),
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                InkWell(
                                  onTap: () async {
                                    // SharedPreferences
                                    //     prefs =
                                    //     await SharedPreferences
                                    //         .getInstance();
                                    // prefs.setString(
                                    //     'User_Id',
                                    //     widget.data
                                    //         .userId
                                    //         .toString());
                                    // if (myId ==
                                    //    widget.data
                                    //         .userId
                                    //         .toString()) {
                                    //   Navigator.of(
                                    //           context)
                                    //       .push(
                                    //     MaterialPageRoute(
                                    //       builder:
                                    //           (context) {
                                    //         return Profile();
                                    //       },
                                    //     ),
                                    //   );
                                    // } else {
                                    //   // user_profilesss();
                                    // }
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                    child: Text(
                                      widget.data.userName,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 2, 0, 0),
                                  child: Row(
                                    children: [
                                      Text(
                                        widget.data.createdAt.split("T")[0] +
                                            "   ",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Icon(
                                        Icons.group,
                                        color: Colors.black,
                                        size: 20,
                                      ),
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
                    child: Text(
                      widget.data.content,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
                // ignore: unrelated_type_equality_checks
                (widget.data.firstAttachmentType == "image/jpeg" ||
                        widget.data.firstAttachmentType == "image/gif")
                    ? InkWell(
                        onTap: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences
                          //         .getInstance();
                          // prefs.setString(
                          //     'Post_Id',
                          //     widget.data.id
                          //         .toString());
                          // prefs.setString(
                          //     'content',
                          //     widget.data
                          //         .content);
                          // prefs.setString(
                          //     'first_attachment_url',
                          //     widget.data
                          //         .firstAttachmentType);
                          // prefs.setString(
                          //     'first_attachment_type',
                          //     widget.data
                          //         .firstAttachmentType);
                          // Navigator.of(context)
                          //     .pushAndRemoveUntil(
                          //         CupertinoPageRoute(
                          //             builder:
                          //                 (context) =>
                          //                     SingleView()),
                          //         (r) => false);
                        },
                        child: SizedBox(
                          height: 250,
                          child: RobustFadeInImage(
                              imageUrl: widget.data.firstAttachmentType,
                              // width: 300,

                              fit: BoxFit.fill),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),

                (widget.data.firstAttachmentType == "video/mp4")
                    ? InkWell(
                        onTap: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences
                          //         .getInstance();
                          // prefs.setString(
                          //     'Post_Id',
                          //     widget.data.id
                          //         .toString());
                          // prefs.setString(
                          //     'content',
                          //     widget.data
                          //         .content);
                          // prefs.setString(
                          //     'first_attachment_url',
                          //     widget.data
                          //         .firstAttachmentType);
                          // prefs.setString(
                          //     'first_attachment_type',
                          //     widget.data
                          //         .firstAttachmentType);
                          // Navigator.of(context)
                          //     .pushAndRemoveUntil(
                          //         CupertinoPageRoute(
                          //             builder:
                          //                 (context) =>
                          //                     SingleView()),
                          //         (r) => false);
                        },
                        child: Container(
                          height: 250,
                          decoration: new BoxDecoration(
                            image: new DecorationImage(
                              image: new AssetImage("images/thumbb.jpg"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.thumb_up_alt,
                              color: Colors.lightBlue,
                              size: 20,
                            ),
                            Text(
                              "  " + widget.data.likes.toString(),
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                        child: Text(
                          widget.data.comments.toString() + " Comments",
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 4, 5, 4),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences
                          //         .getInstance();
                          // prefs.setString(
                          //     'Post_Id',
                          //     widget.data.id
                          //         .toString());

                          if (widget.data.isLiked == 0) {
                            setState(() {
                              type = "1";
                              // reaction();
                              color = Colors.blue;
                            });
                          } else {
                            setState(() {
                              type = "0";
                              // reaction();
                              color = Colors.grey;
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 5, 0, 8),
                          child: Row(
                            children: [
                              (widget.data.isLiked == 0)
                                  ? Icon(
                                      Icons.thumb_up_alt,
                                      color: color,
                                      size: 20,
                                    )
                                  : Icon(
                                      Icons.thumb_up_alt,
                                      color: color,
                                      size: 20,
                                    ),
                              Text(
                                "   Like     ",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          // SharedPreferences prefs =
                          //     await SharedPreferences
                          //         .getInstance();
                          // prefs.setString(
                          //     'Post_Id',
                          //     widget.data.id
                          //         .toString());
                          // prefs.setString(
                          //     'post_user_photo',
                          //     widget.data
                          //         .postUserPhoto);
                          // prefs.setString(
                          //     'user_name',
                          //     widget.data
                          //         .userName);
                          // prefs.setString(
                          //     'content',
                          //     widget.data
                          //         .content);
                          // prefs.setString(
                          //     'first_attachment_url',
                          //     widget.data
                          //         .firstAttachmentUrl);
                          // prefs.setString(
                          //     'likes',
                          //     widget.data.likes
                          //         .toString());
                          // prefs.setString(
                          //     'is_liked',
                          //     state
                          //         .list[index].isLiked
                          //         .toString());
                          // prefs.setString(
                          //     'comments',
                          //     widget.data
                          //         .comments
                          //         .toString());
                          // prefs.setString(
                          //     'created_at',
                          //     widget.data
                          //         .createdAt);
                          // prefs.setString(
                          //     'first_attachment_type',
                          //     widget.data
                          //         .firstAttachmentType);
                          // Navigator.of(context)
                          //     .pushAndRemoveUntil(
                          //         CupertinoPageRoute(
                          //             builder:
                          //                 (context) =>
                          //                     CommentPage()),
                          //         (r) => false);
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 8),
                          child: Row(
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.grey,
                                size: 20,
                              ),
                              Text(
                                "   Comment",
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 8, 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.share_sharp,
                              color: Colors.grey,
                              size: 20,
                            ),
                            Text(
                              "   Share",
                              style: TextStyle(
                                fontSize: 15.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ],
            )));
  }
}
