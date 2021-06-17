import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common_widgets/circleAvatar.dart';
import '../../../common_widgets/commonLoading.dart';
import '../../../common_widgets/error_page.dart';
import '../../../utils/constants.dart';
import '../../profile/pages/user_profile.dart';
import '../bloc/timelineFeed/timelineFeed_cubit.dart';
import '../widget/postCard.dart';
import 'create_post.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textcntrl = TextEditingController();
  String profilePhotoUrl = Constant.photoUrl, type = "0", myId;
  MaterialColor color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => RefreshIndicator(
          onRefresh: () async {
            context.read<TimelineFeedCubit>().getPosts();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: BlocConsumer<TimelineFeedCubit, TimelineFeedState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TimelineFeedError)
                      return ErrorPage(
                        title: state.error.title,
                        subtitle: state.error.message,
                        onRetry: () {
                          context.read<TimelineFeedCubit>().getPosts();
                        },
                      );
                    if (state is TimelineFeedSuccess) return child(state);
                    return CommonFullProgressIndicator(
                      message: "Loading posts...",
                    );
                  }))),
    );
  }

  Widget child(state) => CustomScrollView(slivers: [
        SliverToBoxAdapter(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: CommonAvatar(
                size: 25,
                url: profilePhotoUrl,
                onClick: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserProfile(
                          userId: Constant.id.toString(),
                          name: Constant.name,
                        ),
                      ));
                },
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
                    ).then((value) {
                      context.read<TimelineFeedCubit>().getPosts();
                    });
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
                          BorderSide(color: Colors.grey[800], width: 1.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[800], width: 1.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey[800], width: 1.0),
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(30.0),
                      ),
                    ),
                    hintText: 'Write something here..... ',
                    labelStyle: TextStyle(color: Colors.grey[800]),
                  ),
                  style: TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
          ]),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 5,
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) => PostCard(
                      state.list[index],
                      onLiked: (v) {},
                    ),
                childCount: state.list.length)),
      ]);
}
