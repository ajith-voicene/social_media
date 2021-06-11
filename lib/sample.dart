import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/Timeline/pages/create_post.dart';

class Data {
  final String profilePhotoUrl;
  final String name;
  final int id;
  final String email;

  Data({this.profilePhotoUrl, this.name, this.id, this.email});
  factory Data.fromJson(Map<String, dynamic> parsedJson) {
    return Data(
      profilePhotoUrl: parsedJson['profile_photo_url'],
      name: parsedJson['name'],
      id: parsedJson['id'],
      email: parsedJson['email'],
    );
  }
}

class Users extends StatefulWidget {
  const Users({Key key}) : super(key: key);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FutureBuilder<List<Data>>(
                    future: getRequest(),
                    builder: (ctx, snapshot) {
                      if (snapshot.hasData) {
                        List data = snapshot.data;
                        print(data);
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: InkWell(
                                  onTap: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('User_Id',
                                        snapshot.data[index].id.toString());
                                    prefs.setString(
                                        'User_Name', snapshot.data[index].name);
                                    prefs.setString('User_EmailId',
                                        snapshot.data[index].email);
                                    prefs.setString('User_profile_photo_url',
                                        snapshot.data[index].profilePhotoUrl);
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return CreatePost();
                                        },
                                      ),
                                    );
                                  },
                                  child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      child: Container(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.blue,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    child: new Container(
                                                      height: 50,
                                                      decoration:
                                                          new BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              image:
                                                                  new DecorationImage(
                                                                image: NetworkImage(
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .profilePhotoUrl),
                                                                fit: BoxFit
                                                                    .cover,
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
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .fromLTRB(
                                                                15, 18, 0, 0),
                                                        child: Text(
                                                          snapshot
                                                              .data[index].name,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      // Padding(
                                                      //   padding: const EdgeInsets.fromLTRB(15, 5, 0, 0),
                                                      //   child: Text(
                                                      //     "8 mutal friends",
                                                      //     style: TextStyle(fontSize: 12, color: Colors.black,),
                                                      //   ),
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: const EdgeInsets.fromLTRB(0, 5, 5, 10),
                                              //   child:   RaisedButton(
                                              //     shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                                              //     color: Colors.blue[900],
                                              //     onPressed: () {
                                              //
                                              //       // _validateInputs();
                                              //     },
                                              //     child: Text(
                                              //       "Add Friend",
                                              //       style: TextStyle(
                                              //         color: Colors.white,
                                              //         fontSize: 16.0,
                                              //       ),
                                              //     ),
                                              //   ),
                                              // ),
                                            ]),
                                      )),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return AlertDialog(
                          title: Text(
                            'An Error Occured!',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                          content: Text(
                            "${snapshot.error}",
                            // 'Please try again later',
                            style: TextStyle(
                              color: Colors.blueAccent,
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                'Go Back',
                                style: TextStyle(
                                  color: Colors.redAccent,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                      // By default, show a loading spinner.
                      return Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.blue[900]),
                              ),
                            ),
                            SizedBox(width: 20),
                            Text('Loading....')
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  Future<List<Data>> getRequest() async {
    // print('Bearer $token');
    // final response = await http.get(View_all_Users,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    // );
    // Map<String, dynamic> responseData = json.decode(response.body);
    // var list = responseData['data']['data'] as List;
    // print("aaaaaa");
    // print(list);
    // List<Data> imagesList = list.map((i) => Data.fromJson(i)).toList();
    // return imagesList;
  }
}
