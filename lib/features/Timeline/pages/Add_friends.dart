import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/circleAvatar.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/error_page.dart';
import 'package:social_media/features/Timeline/bloc/search/search_cubit.dart';
import 'package:social_media/features/profile/pages/user_profile.dart';
import 'package:social_media/model/home_models.dart';

class AddFriends extends StatefulWidget {
  const AddFriends({Key key}) : super(key: key);

  @override
  _AddFriendsState createState() => _AddFriendsState();
}

class _AddFriendsState extends State<AddFriends> {
  final TextEditingController _textcntrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
        create: (context) => SearchCubit()..searchUsers(""),
        child: Scaffold(
          appBar: AppBar(
            title: Text("Search"),
            centerTitle: true,
          ),
          body: Builder(
              builder: (context) => BlocConsumer<SearchCubit, SearchState>(
                    listener: (context, state) {
                      // if (state is SearchError)
                      //   Alerts.showErrorToast("Loading Error");
                    },
                    builder: (context, state) {
                      if (state is SearchError)
                        return ErrorPage(
                          title: state.error.title,
                          subtitle: state.error.message,
                          onRetry: () {
                            context.read<SearchCubit>().searchUsers("");
                          },
                        );
                      if (state is SearchSuccess)
                        return CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: new TextFormField(
                                  controller: _textcntrl,
                                  onEditingComplete: () {
                                    context
                                        .read<SearchCubit>()
                                        .searchUsers(_textcntrl.text);
                                  },
                                  decoration: new InputDecoration(
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        context
                                            .read<SearchCubit>()
                                            .searchUsers(_textcntrl.text);
                                      },
                                      child: Icon(
                                        Icons.search,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[800], width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[800], width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.grey[800], width: 1.0),
                                      borderRadius: const BorderRadius.all(
                                        const Radius.circular(30.0),
                                      ),
                                    ),
                                    hintText: 'Search ',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[800]),
                                  ),
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.black),
                                ),
                              ),
                            ),
                            SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (context, index) => SearchUser(
                                          user: state.users[index],
                                        ),
                                    childCount: state.users.length))
                          ],
                        );
                      return CommonFullProgressIndicator(
                        message: "Seaching..",
                      );
                    },
                  )),
        ));
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
