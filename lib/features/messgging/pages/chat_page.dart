import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/features/messgging/bloc/get_messages/getmessage_cubit.dart';
import 'package:social_media/features/messgging/bloc/send_message/sendmessage_cubit.dart';
import 'package:social_media/model/home_models.dart';
import 'package:social_media/utils/alerts.dart';
import 'package:social_media/utils/constants.dart';

class ChatPage extends StatefulWidget {
  final int userId;
  final String userName;
  const ChatPage({Key key, this.userId, this.userName}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final textCont = TextEditingController();
  List<Message> messages = [];
  Message msg;
  Timer timer;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SendmessageCubit>(
          create: (context) => SendmessageCubit(),
        ),
        BlocProvider<GetmessageCubit>(
          create: (context) =>
              GetmessageCubit()..getMessages(widget.userId.toString()),
        )
      ],
      child: Builder(
        builder: (context) => Scaffold(
            appBar: AppBar(
              actions: [
                InkWell(
                    onTap: () {
                      context
                          .read<GetmessageCubit>()
                          .getMessages(widget.userId.toString());
                    },
                    child: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 10,
                ),
              ],
              title: Text(widget.userName),
            ),
            body: BlocListener<SendmessageCubit, SendmessageState>(
              listener: (context, state) {
                if (state is SendmessageSuccess) {
                  messages.insert(0, msg);
                  msg = null;
                  setState(() {});
                }
                if (state is SendmessageError)
                  Alerts.showErrorToast("Message sending error");
              },
              child: BlocConsumer<GetmessageCubit, GetmessageState>(
                listener: (context, state) {
                  if (state is GetmessageSuccess) {
                    messages = state.data;
                  }
                },
                builder: (cont, bstate) {
              
                  if (bstate is GetmessageLoading) return child(context);
                  if (bstate is GetmessageSuccess) {
                   
                    return child(context);
                  }
                  return CommonFullProgressIndicator(
                    message: "Loading messages",
                  );
                },
              ),
            )),
      ),
    );
  }

  Widget child(BuildContext co) => SingleChildScrollView(
        child: Column(
          
          children: [
           
            Container(
                height: MediaQuery.of(context).size.height * .8,
                child: ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return messageTile(messages[index].message,
                        messages[index].senderId, messages[index].createdAt);
                  },
                )),
            Container(
              alignment: Alignment.bottomCenter,
              child: bottomMessageBar(co),
            )
          ],
        ),
      );

  messageTile(String message, int sendBy, String ts) {
    DateTime time;
    if (ts != null) time = DateTime.tryParse(ts);
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width * .6,

      // alignment: widget.userId == sendBy
      //     ? Alignment.bottomLeft
      //     : Alignment.bottomRight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (widget.userId != sendBy) Expanded(child: Text("")),
          if (widget.userId != sendBy)
            Text(
              ts == null ? "justnow" : "${time.hour}:${time.minute}",
              style: TextStyle(color: Colors.grey),
            ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .8),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: widget.userId == sendBy ? Colors.grey[300] : Colors.blue,
              child: Text(
                message,
                maxLines: null,
                softWrap: true,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          if (widget.userId == sendBy)
            Text(
              "${time.toUtc().hour}:${time.toUtc().minute}",
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }

  bottomMessageBar(BuildContext co) => Container(
        child: ListTile(
          tileColor: Colors.grey[800],
          title: TextFormField(
            minLines: 1,
            keyboardType: TextInputType.multiline,
            maxLines: 2,
            style: TextStyle(color: Colors.white),
            controller: textCont,
            decoration: InputDecoration(
              labelText: "Message",
              labelStyle: TextStyle(color: Colors.blue),
            ),
          ),
          trailing: InkWell(
            onTap: () {
              // sendMessage();
              if (textCont.text != null) {
                msg = Message(
                    senderId: Constant.id, message: textCont.text.trim());
                co.read<SendmessageCubit>().editProfile(
                    widget.userId.toString(), textCont.text.trim());

                textCont.clear();
              }
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      );
}
