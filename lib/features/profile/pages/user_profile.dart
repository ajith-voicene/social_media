import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/friendButton.dart';
import 'package:social_media/features/Timeline/bloc/getFriendRequests/friendrequests_cubit.dart';
import 'package:social_media/utils/constants.dart';

import '../../../common_widgets/circleAvatar.dart';
import '../../../common_widgets/commonLoading.dart';
import '../../../common_widgets/error_page.dart';
import '../blocs/get_Profile/get_profile_cubit.dart';
import 'profile.dart';

class UserProfile extends StatelessWidget {
  final String userId;
  final String name;

  const UserProfile({Key key, this.userId, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FriendrequestsCubit>(
          create: (context) => FriendrequestsCubit()..getFriendrequests(),
        ),
        BlocProvider<GetProfileCubit>(
          create: (context) => GetProfileCubit()..getProfile(userId),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(name),
        ),
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (context) => BlocBuilder<GetProfileCubit, GetProfileState>(
            builder: (context, state) {
              if (state is GetProfileError)
                return ErrorPage(
                  title: state.error.title,
                  subtitle: state.error.message,
                  onRetry: () {
                    context.read<GetProfileCubit>().getProfile(userId);
                  },
                );
              if (state is GetProfileSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                          child: CommonAvatar(
                        url: state.user.profilePhotoUrl,
                        size: 55,
                        onClick: null,
                      )),
                      if (userId == Constant.id.toString())
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Profile(),
                                  ));
                            },
                            child: Text("EditProfile")),
                      if (userId != Constant.id.toString())
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: FriendButton(
                            requestedBy: state.user.requestedUserId,
                            status: state.user.isFriend,
                            userId: state.user.id,
                            refresh: () {
                              context
                                  .read<GetProfileCubit>()
                                  .getProfile(userId);
                            },
                          ),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      buildCard(state.user.name, "Name"),
                      buildCard(state.user.email, "Email"),
                      buildCard(
                          state.user.createdAt.split("T")[0], "Created on"),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                );
              }
              return CommonFullProgressIndicator(
                message: "Fetching user profile...",
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(String value, String field) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        initialValue: value,
        enabled: false,
        keyboardType: TextInputType.text,
        maxLines: 1,
        cursorColor: Colors.blue,
        enableInteractiveSelection: false,
        autocorrect: true,
        decoration: new InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[800]),
          ),
          labelText: field,
          labelStyle: TextStyle(
              fontSize: 15,
              color: Colors.grey[600],
              fontWeight: FontWeight.w300),
        ),
        style: TextStyle(
            fontSize: 20.0, color: Colors.black, fontWeight: FontWeight.w500),
      ),
    );
  }
}
