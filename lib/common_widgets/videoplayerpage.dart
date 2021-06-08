import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'appbar.dart';
import 'drawer.dart';

class ChewieDemo extends StatefulWidget {
  final String url;
  ChewieDemo({this.title = 'Chewie Demo', this.url});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  BetterPlayerController _betterPlayerController;
  String url;

  @override
  void initState() {
    super.initState();
    initialization();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  Future initialization() async {
    BetterPlayerDataSource betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, widget.url);
    _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(),
        betterPlayerDataSource: betterPlayerDataSource);
  }

  @override
  Widget build(BuildContext context) {
    _betterPlayerController.play();
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController,
          ),
        ),
      ),
      drawer: OutsideDrawer(),
    );
  }
}
