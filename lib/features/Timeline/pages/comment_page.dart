import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/utils/alerts.dart';
import 'package:social_media/utils/constants.dart';
import '../../../common_widgets/commonLoading.dart';
import '../bloc/comment/comment_cubit.dart';
import '../widget/postCard.dart';
import '../../../model/home_models.dart';

class CommentPage extends StatefulWidget {
  final Data data;
  const CommentPage({Key key, this.data}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final _commentcntrl = TextEditingController();
  List<Comment> comments = [];
  Comment lastComment;
  Data newData;
  @override
  void initState() {
    super.initState();
    newData = widget.data;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CommentCubit>(
        create: (context) => CommentCubit()..getComments(newData.id),
        child: Builder(
          builder: (context) => WillPopScope(
            onWillPop: () async {
              Navigator.pop(context, newData);
              return true;
            },
            child: Scaffold(
              appBar: AppBar(title: Text("Social Media")),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    PostCard(newData, isComment: true, onLiked: (data) {
                      newData = data;
                      setState(() {});
                    }),
                    BlocConsumer<CommentCubit, CommentState>(
                        listener: (context, state) {
                      if (state is CommentError) Alerts.showErrorToast(null);
                      if (state is CommentCreateSuccess) {
                        newData =
                            newData.copyWith(comments: newData.comments += 1);

                        lastComment = Comment(
                            commentUserPhoto: Constant.photoUrl,
                            content: _commentcntrl.text.trim(),
                            userName: Constant.name);
                        _commentcntrl.clear();
                        setState(() {});
                      }
                    }, builder: (context, state) {
                      if (state is CommentLoading)
                        return Wrap(
                          children: [
                            LinearProgressIndicator(),
                            ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.list.length,
                                itemBuilder: (context, index) {
                                  return CommentBox(comment: state.list[index]);
                                }),
                          ],
                        );
                      if (state is CommentSuccess) {
                        comments = state.list;
                        if (lastComment != null) {
                          comments.insert(0, lastComment);
                          lastComment = null;
                        }

                        if (comments.isEmpty)
                          return Text("Be the first one to comment");
                        else
                          return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: comments.length,
                              itemBuilder: (context, index) {
                                return CommentBox(comment: comments[index]);
                              });
                      }
                      return CommonFullProgressIndicator(
                        message: "Loading comments",
                      );
                    })
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Expanded(
                            child: new TextFormField(
                              controller: _commentcntrl,
                              keyboardType: null,
                              maxLines: 5,
                              minLines: 1,
                              cursorColor: Colors.black,
                              autocorrect: true,
                              decoration: new InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[800], width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[800], width: 1.0),
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(10.0),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
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
                            if (_commentcntrl.text.trim().length > 0) {
                              context.read<CommentCubit>().addComment(
                                  newData.id, _commentcntrl.text.trim());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                            child: Icon(
                              Icons.send,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
              resizeToAvoidBottomInset: false,
            ),
          ),
        ));
  }
}

class CommentBox extends StatefulWidget {
  final Comment comment;
  const CommentBox({Key key, this.comment}) : super(key: key);

  @override
  _CommentBoxState createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 10, right: 10),
      child: ListTile(
        dense: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          // side: BorderSide(color: Colors.black),
        ),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(widget.comment.commentUserPhoto),
        ),
        tileColor: Colors.grey.shade200,
        title: Padding(
          padding: EdgeInsets.all(4.0),
          child: InkWell(
            child: Row(
              children: [
                Text(
                  widget.comment.userName,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12.0,
                  ),
                ),
                // Text(widget.comment.createdAt)
              ],
            ),
            onTap: () {
              //navigate to profile
            },
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            widget.comment.content,
            textAlign: TextAlign.start,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
