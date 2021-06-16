import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/Timeline/bloc/timelineFeed/timelineFeed_cubit.dart';
import '../../../Drawers.dart';
import 'Home.dart';

class TimeLine extends StatefulWidget {
  const TimeLine({Key key}) : super(key: key);

  @override
  _TimeLineState createState() => _TimeLineState();
}

class _TimeLineState extends State<TimeLine> {
  @override
  void initState() {
    super.initState();
  }

  Widget appBarTitle = new Text(
    " Social Media",
    style: TextStyle(
        color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: new AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.menu))
                ],
              ),
              title: appBarTitle,
              centerTitle: true,
              actions: <Widget>[
                Icon(Icons.notifications),
                SizedBox(
                  width: 5,
                )
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<TimelineFeedCubit>(
                    create: (context) => TimelineFeedCubit()..getPosts())
              ],
              child: TabBarView(
                children: [
                  Container(child: Home()),
                  Container(child: Drawers()),
                ],
              ),
            ),
          ),
        ));
  }
}
