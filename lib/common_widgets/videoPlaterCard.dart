import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class VideoPlayCard extends StatefulWidget {
  final String url;
  final bool isAsset;
  final bool autoPlay;
  VideoPlayCard(this.url, {this.isAsset = false, this.autoPlay = true});

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayCardState();
  }
}

class _VideoPlayCardState extends State<VideoPlayCard> {
  BetterPlayerController _betterPlayerController;
  String url;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  Future initialization() async {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        widget.isAsset
            ? BetterPlayerDataSourceType.file
            : BetterPlayerDataSourceType.network,
        widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    initialization();
    if (widget.autoPlay) _betterPlayerController.play();
    return BetterPlayer(
      controller: _betterPlayerController,
    );
  }
}
