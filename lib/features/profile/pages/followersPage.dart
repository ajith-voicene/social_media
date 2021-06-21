import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/circleAvatar.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/error_page.dart';
import 'package:social_media/features/profile/blocs/get_followers/getfollowers_cubit.dart';
import 'package:social_media/model/home_models.dart';

import 'user_profile.dart';

class FollowersPage extends StatelessWidget {
  const FollowersPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GetfollowersCubit>(
      create: (context) => GetfollowersCubit()..getFollowingsList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Followers"),
        ),
        body: Builder(
          builder: (context) => RefreshIndicator(
            onRefresh: () async {
              context.read<GetfollowersCubit>().getFollowingsList();
            },
            child: BlocBuilder<GetfollowersCubit, GetfollowersState>(
              builder: (con, state) {
                if (state is GetfollowersError)
                  return ErrorPage(
                    title: state.error.title,
                    onRetry: () {
                      con.read<GetfollowersCubit>().getFollowingsList();
                    },
                  );
                if (state is GetfollowersSuccess) if (state.list.isEmpty)
                  return Container(
                    child: Center(child: Text("You have no friends to view")),
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
