import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/features/messgging/bloc/get_messages/getmessage_cubit.dart';
import 'package:social_media/features/messgging/bloc/send_message/sendmessage_cubit.dart';
import 'package:social_media/model/home_models.dart';

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
  Timer timer;
  @override
  void dispose() {
    super.dispose();
    print("dispose");
    // timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // int count = 20;
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
            body: BlocBuilder<GetmessageCubit, GetmessageState>(
              builder: (cont, bstate) {
                // return

                // Future.delayed(Duration(seconds: 10), () {
                //   cont
                //       .read<GetmessageCubit>()
                //       .getSoftMessages(widget.userId.toString());
                // });
                // print(state);
                print(bstate);
                if (bstate is GetmessageLoading) return child(bstate, context);
                if (bstate is GetmessageSuccess) {
                  // timer = Timer.periodic(Duration(seconds: 20), (Timer t) {
                  //   print("reapeater");
                  //   cont
                  //       .read<GetmessageCubit>()
                  //       .getSoftMessages(widget.userId.toString());
                  // });
                  return child(bstate, context);
                }
                return CommonFullProgressIndicator(
                  message: "Loading messages",
                );
              },
            )),
      ),
    );
  }

  Widget child(bstate, BuildContext co) => Stack(
        fit: StackFit.expand,
        children: [
          // Container(
          //   alignment: Alignment.topCenter,
          //   child: Chip(
          //     label: Text("data"),
          //   ),
          // ),
          Container(
              child: ListView.builder(
            reverse: true,
            itemCount: bstate.data.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                );
              }

              return messageTile(bstate.data[index].message,
                  bstate.data[index].senderId, bstate.data[index].createdAt);
            },
          )),
          Container(
            alignment: Alignment.bottomCenter,
            child: bottomMessageBar(co),
          )
        ],
      );

  messageTile(String message, int sendBy, String ts) {
    DateTime time = DateTime.tryParse(ts);
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.all(5),
      // width: MediaQuery.of(context).size.width * .6,

      alignment: widget.userId == sendBy
          ? Alignment.bottomLeft
          : Alignment.bottomRight,
      child: Row(
        children: [
          if (widget.userId != sendBy) Expanded(child: Text("")),
          if (widget.userId != sendBy)
            Text(
              "${time.hour}:${time.minute}",
              style: TextStyle(color: Colors.grey),
            ),
          SizedBox(
            width: 5,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              // width: MediaQuery.of(context).size.width * .8,
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              color: widget.userId == sendBy ? Colors.grey[300] : Colors.blue,
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
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
            maxLines: 3,
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
              if (textCont.text != null)
                co.read<SendmessageCubit>().editProfile(
                    widget.userId.toString(), textCont.text.trim());
              textCont.clear();
            },
            child: Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      );
}
