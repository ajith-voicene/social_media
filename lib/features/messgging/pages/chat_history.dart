import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/circleAvatar.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/error_page.dart';
import 'package:social_media/features/messgging/bloc/chatHistory/chathistory_cubit.dart';
import 'package:social_media/features/messgging/pages/chat_page.dart';
import 'package:social_media/model/home_models.dart';

class ChatHistory extends StatelessWidget {
  const ChatHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChathistoryCubit>(
      create: (context) => ChathistoryCubit()..getMessages(),
      child: Builder(
        builder: (context) => RefreshIndicator(
          onRefresh: () async {
            context.read<ChathistoryCubit>().getMessages();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("Messages"),
            ),
            body: BlocBuilder<ChathistoryCubit, ChathistoryState>(
              builder: (con, state) {
                if (state is ChathistoryError)
                  return ErrorPage(
                    onRetry: () {
                      con.read<ChathistoryCubit>().getMessages();
                    },
                  );
                if (state is ChathistorySuccess) if (state.list.isEmpty)
                  return Container(
                    child: Center(child: Text("You have no chats")),
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
              builder: (context) => ChatPage(
                userName: user.name,
                userId: user.id,
              ),
            ));
      },
      child: ListTile(
        leading: CommonAvatar(
          url: user.profilePhotoUrl,
        ),
        title: Text(user.name),
        subtitle: Text(user.email ?? ""),
        trailing: Icon(
          Icons.message,
          color: Colors.blue,
        ),
      ),
    );
  }
}
