import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/profile.dart';

import 'Add_friends.dart';
import 'Drawers.dart';
import 'Home.dart';
import 'users.dart';

void main() => runApp(new MaterialApp(
  home: new Timeline(),
));


class Timeline extends StatefulWidget {
  @override
  Timeline_State createState() {
    return new Timeline_State();
  }
}

class Timeline_State extends State<Timeline> {

  @override
  void initState() {
    super.initState();
  }
  Widget appBarTitle = new Text(" Social Media",style: TextStyle(color: Colors.white,fontSize: 22,fontWeight: FontWeight.bold),);
  Icon actionIcon = new Icon(Icons.search,size: 27,);
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 5,
      child: Scaffold(

        appBar: new AppBar(
          bottom: TabBar(
        tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.person)),
          Tab(icon: Icon(Icons.supervised_user_circle_rounded)),
          Tab(icon: Icon(Icons.person_add)),
          Tab(icon: Icon(Icons.menu))
      ],
    ),
          leading: Text(" "),
            title:appBarTitle,
            actions: <Widget>[
              new IconButton(icon: actionIcon,onPressed:(){
                setState(() {
                  if ( this.actionIcon.icon == Icons.search){
                    this.actionIcon = new Icon(Icons.close);
                    this.appBarTitle = new TextField(
                      style: new TextStyle(
                        color: Colors.white,

                      ),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search,color: Colors.white),
                          hintText: " Search...",
                          hintStyle: new TextStyle(color: Colors.white)
                      ),
                    );}
                  else {
                    this.actionIcon = new Icon(Icons.search);
                    this.appBarTitle = new Text("Social Media");
                  }


                });
              } ,),]
    ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
         child: TabBarView(
            children: [
              Container(child: Home()),
              Container(child: profile()),
              Container(child: Users()),
              Container(child: Add_friends()),
              Container(child: Drawers()),
            ],
          ),
        ),
      ),
    );
  }
}