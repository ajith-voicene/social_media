import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/circleAvatar.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/error_page.dart';
import 'package:social_media/features/Timeline/bloc/getFriendRequests/friendrequests_cubit.dart';
import 'package:social_media/model/home_models.dart';

import 'user_profile.dart';

class FriendRequestsPage extends StatefulWidget {
  const FriendRequestsPage({Key key}) : super(key: key);

  @override
  _FriendRequestsPageState createState() => _FriendRequestsPageState();
}

class _FriendRequestsPageState extends State<FriendRequestsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendrequestsCubit>(
        create: (context) => FriendrequestsCubit()..getFriendrequests(),
        child: Builder(
            builder: (context) => Scaffold(
                appBar: AppBar(
                  title: Text("Friend Requests"),
                ),
                body: BlocBuilder<FriendrequestsCubit, FriendrequestsState>(
                  builder: (con, state) {
                    if (state is FriendrequestsError)
                      return ErrorPage(
                        title: state.error.title,
                        onRetry: () {
                          con.read<FriendrequestsCubit>().getFriendrequests();
                        },
                      );
                    if (state is FriendrequestsSuccess)
                      return ListView.builder(
                        itemBuilder: (context, index) => SearchUser(
                          user: state.list[index],
                        ),
                        itemCount: state.list.length,
                      );
                    return CommonFullProgressIndicator(
                      message: "getting requests",
                    );
                  },
                ))));
  }
}

class SearchUser extends StatelessWidget {
  final User user;
  const SearchUser({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(
                userId: user.id.toString(),
                name: user.name,
              ),
            ));
      },
      child: ListTile(
        leading: CommonAvatar(
          url: user.profilePhotoUrl,
        ),
        title: Text(user.name),
        subtitle: Text(user.email ?? ""),
      ),
    );
  }
}
