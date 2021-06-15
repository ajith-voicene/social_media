import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/robustImage.dart';
import 'package:social_media/features/Timeline/bloc/like_button/likebutton_cubit.dart';
import 'package:social_media/features/Timeline/pages/comment_page.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/utils/alerts.dart';

import '../../../single_view.dart';

class PostCard extends StatefulWidget {
  final Data data;
  final bool isComment;

  final Function(Data) onLiked;
  const PostCard(this.data, {Key key, this.isComment = false, this.onLiked})
      : super(key: key);

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  Data newData;

  @override
  void initState() {
    super.initState();
    newData = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.data.content);
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
                                      image:
                                          NetworkImage(newData.postUserPhoto),
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
                                    //     newData
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
                                      newData.userName,
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
                                        newData.createdAt.split("T")[0] + "   ",
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
                      newData.content,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ),
                // ignore: unrelated_type_equality_checks
                (newData.firstAttachmentType == "image/jpeg" ||
                        newData.firstAttachmentType == "image/gif")
                    ? InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SingleView(newData)));
                        },
                        child: SizedBox(
                          height: 250,
                          child: Image.network(newData.firstAttachmentUrl),
                          // RobustFadeInImage(
                          //     imageUrl: newData.firstAttachmentUrl,
                          //     fit: BoxFit.contain),
                        ),
                      )
                    : Container(
                        height: 0,
                      ),

                (newData.firstAttachmentType == "video/mp4")
                    ? InkWell(
                        onTap: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => SingleView(newData)));
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
                              "  " + "${newData.likes}",
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
                          newData.comments.toString() + " Comments",
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
                      LikeButton(
                        liked: newData.isLiked,
                        id: newData.id,
                        onLiked: (like) {
                          if (like == 1)
                            newData = newData.copyWith(
                                likes: newData.likes += 1, isLiked: 1);
                          else
                            newData = newData.copyWith(
                                likes: newData.likes -= 1, isLiked: 0);
                          widget.onLiked(newData);
                          if (!widget.isComment) setState(() {});
                        },
                      ),
                      InkWell(
                        onTap: () async {
                          if (!widget.isComment)
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => CommentPage(
                                          data: newData,
                                        )))
                                .then((value) {
                              newData = value;
                              setState(() {});
                            });
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

class LikeButton extends StatefulWidget {
  final int liked;
  final Function(int) onLiked;
  final int id;
  const LikeButton({Key key, this.liked, this.onLiked, this.id})
      : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {
  bool isLiked;
  Color color;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isLiked = widget.liked == 1;
    color = isLiked ? Colors.blue : Colors.grey;
    return BlocProvider<LikebuttonCubit>(
      create: (context) => LikebuttonCubit(),
      child: Builder(
        builder: (context) => BlocConsumer<LikebuttonCubit, LikebuttonState>(
          listener: (context, state) {
            if (state is LikebuttonError) {
              Alerts.showErrorToast(null);
            }
          },
          builder: (cont, state) {
            return InkWell(
              onTap: () {
                if (isLiked) {
                  widget.onLiked(0);
                  cont.read<LikebuttonCubit>().onLiked(0, "${widget.id}");
                } else {
                  widget.onLiked(1);
                  cont.read<LikebuttonCubit>().onLiked(1, "${widget.id}");
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 0, 8),
                child: Row(
                  children: [
                    Icon(
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
            );
          },
        ),
      ),
    );
  }
}
