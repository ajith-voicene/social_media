import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/circleAvatar.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/error_page.dart';
import 'package:social_media/features/profile/blocs/getfrients/friendslist_cubit.dart';
import 'package:social_media/model/home_models.dart';

import 'user_profile.dart';

class FriendsList extends StatelessWidget {
  const FriendsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendslistCubit>(
      create: (context) => FriendslistCubit()..getfriendsList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Friends"),
        ),
        body: Builder(
          builder: (context) => BlocBuilder<FriendslistCubit, FriendslistState>(
            builder: (con, state) {
              print(state);
              if (state is FriendslistError)
                return ErrorPage(
                  title: state.error.title,
                  onRetry: () {
                    con.read<FriendslistCubit>().getfriendsList();
                  },
                );
              if (state is FriendslistSuccess) if (state.list.isEmpty)
                return Container(
                  child: Text("You have no frientsto view"),
                );
              else
                return ListView.builder(
                  itemBuilder: (context, index) => UserCard(
                    user: state.list[index],
                  ),
                  itemCount: state.list.length,
                );
              return CommonFullProgressIndicator(
                message: "getting friends",
              );
            },
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;
  const UserCard({Key key, this.user}) : super(key: key);

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
