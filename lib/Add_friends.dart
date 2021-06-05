import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Homepages.dart';
import 'urls.dart';
void main() => runApp(new MaterialApp(
    home: new Add_friends()));




class Add_friends extends StatefulWidget {
  @override
  Add_friends_State createState() {
    return new Add_friends_State();
  }
}

class Add_friends_State extends State<Add_friends> {


  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width/1;
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(

                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),

                    child: Card(
                      elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                          "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Container(
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.blue,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: new Container(
                                        height: 50,
                                        decoration: new BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            image: new DecorationImage(
                                              image: new AssetImage("images/google.jpg"),
                                              fit: BoxFit.cover,
                                            )),
                                        // width: 60,

                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Center(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
                                          child: Text(
                                            "Arun Nair",
                                            style: TextStyle(fontSize: 18, color: Colors.black,fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                          child: Text(
                                            "8 mutal friends",
                                            style: TextStyle(fontSize: 12, color: Colors.black,),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                  child:   RaisedButton(
                                    shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                    color: Colors.blue[900],
                                    onPressed: () {

                                      // _validateInputs();
                                    },
                                    child: Text(
                                      "Add Friend",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )
                    ),
                  ),




                ],
              ),
            )
        )
    );
  }

}

