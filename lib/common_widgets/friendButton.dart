import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/common_button.dart';
import 'package:social_media/features/Timeline/bloc/managefriend_request/managefriendrequest_cubit.dart';
import 'package:social_media/utils/constants.dart';

class FriendButton extends StatefulWidget {
  final String status;
  final int userId;
  final int requestedBy;
  final VoidCallback refresh;
  const FriendButton(
      {Key key, this.status, this.userId, this.refresh, this.requestedBy})
      : super(key: key);

  @override
  _FriendButtonState createState() => _FriendButtonState();
}

class _FriendButtonState extends State<FriendButton> {
  String value;

  @override
  void initState() {
    super.initState();
    value = widget.status;
    if (widget.status == "pending" ||
        widget.requestedBy != null && widget.requestedBy == Constant.id)
      value = "Requested";
  }

  @override
  Widget build(BuildContext context) {
    if (widget.status == "friend") value = "Friend";
    if (widget.status == "pending") value = "Requested";
    if (widget.status == null || widget.status == "rejected") value = null;
    if (widget.status == "blocked") value = "Blocked";
    if (widget.status == "hidden") value = "Hidden";
    print(widget.status);
    print(value);
    return BlocProvider<MnageFriendrequestCubit>(
      create: (context) => MnageFriendrequestCubit(),
      child: Builder(
          builder: (context) =>
              BlocConsumer<MnageFriendrequestCubit, MnageFriendrequestState>(
                  listener: (context, state) {
                if (state is MnageFriendrequestSuccess) {
                  value = "Loading";
                  widget.refresh();
                }
              }, builder: (conte, state) {
                if (state is MnageFriendrequestLoading)
                  return CommonButtonCustom(
                    child: CircularProgressIndicator(),
                    onPressed: () {},
                  );
                if (value != "Friend" &&
                    value != "Hidden" &&
                    widget.status != "rejected" &&
                    widget.status != "blocked" &&
                    widget.requestedBy != null &&
                    widget.requestedBy != Constant.id)
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonButton(
                        label: "Accept",
                        onPressed: () {
                          context
                              .read<MnageFriendrequestCubit>()
                              .manageFriendrequest(
                                  "accept", widget.userId.toString());
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CommonButton(
                        // color: Colors.yellow,
                        label: "Maybe Later",
                        onPressed: () {
                          context
                              .read<MnageFriendrequestCubit>()
                              .manageFriendrequest(
                                  "hide", widget.userId.toString());
                        },
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CommonButton(
                        color: Colors.red,
                        label: "Reject",
                        onPressed: () {
                          context
                              .read<MnageFriendrequestCubit>()
                              .manageFriendrequest(
                                  "delete", widget.userId.toString());
                        },
                      ),
                    ],
                  );
                else
                  return CommonButton(
                    label: value ?? "Add Friend",
                    onPressed: () {
                      showOptions(conte);
                    },
                  );
              })),
    );
  }

  void showOptions(BuildContext con) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
          child: Wrap(
            children: [
              if (value != "Friend" &&
                  value != "Requested" &&
                  value != "Blocked" &&
                  value != "Hidden")
                options("Send Friend Request", Icons.person_add_alt_1, () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("add", widget.userId.toString());
                  Navigator.pop(con);
                }),
              if (value == "Hidden")
                options("Accept Request", Icons.person_add, () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("accept", widget.userId.toString());
                  Navigator.pop(con);
                }),
              if (value == "Requested" || value == "Hidden")
                options("Cancel Request", Icons.cancel, () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("delete", widget.userId.toString());
                  Navigator.pop(con);
                }),
              if (value == "Friend")
                options("Remove Friend", Icons.person_remove_alt_1_outlined,
                    () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("delete", widget.userId.toString());
                  Navigator.pop(con);
                }),
              if (value != "Blocked")
                options("Block", Icons.block, () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("block", widget.userId.toString());
                  Navigator.pop(con);
                }, color: Colors.red),
              if (value == "Blocked")
                options("Unblock", Icons.check_circle, () {
                  con
                      .read<MnageFriendrequestCubit>()
                      .manageFriendrequest("delete", widget.userId.toString());
                  Navigator.pop(con);
                })
            ],
          ),
        ),
      ),
    );
  }

  Widget options(String name, IconData icon, VoidCallback onClick,
      {Color color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color ?? Colors.blue,
      ),
      title: Text(name),
      onTap: onClick,
    );
  }
}
