import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/common_widgets/common_button.dart';
import 'package:social_media/features/profile/blocs/manage_follow/managefollow_cubit.dart';
import 'package:social_media/utils/alerts.dart';

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  final int userId;
  final VoidCallback refresh;
  const FollowButton(
      {Key key, this.isFollowing = false, this.userId, this.refresh})
      : super(key: key);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool isFollow;
  String label;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFollow = widget.isFollowing;
    label = (isFollow ? "Unfollow" : "Follow");
    return BlocProvider<ManagefollowCubit>(
      create: (context) => ManagefollowCubit(),
      child: Builder(
          builder: (context) =>
              BlocConsumer<ManagefollowCubit, ManagefollowState>(
                listener: (context, state) {
                  if (state is ManagefollowError) {
                    Alerts.showErrorToast(null);
                  }
                  if (state is ManagefollowSuccess) {
                    label = "Loading";
                    widget.refresh();
                  }
                },
                builder: (co, state) {
                  if (state is ManagefollowLoading)
                    return CommonButtonCustom(
                      color: Colors.blue,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    );
                  return CommonButton(
                    label: label,
                    color: Colors.blue,
                    onPressed: () {
                      if (label != "Loading")
                        co.read<ManagefollowCubit>()
                          ..manageFollow(isFollow ? "unfollow" : "follow",
                              widget.userId.toString());
                    },
                  );
                },
              )),
    );
  }
}
