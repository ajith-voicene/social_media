import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: camel_case_types
class user_profile extends StatefulWidget {
  @override
  user_profile_State createState() {
    return new user_profile_State();
  }
}

class user_profile_State extends State<user_profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;
  String userId, userName, userEmail, userPhoto;
  final _namecntrl = TextEditingController();
  final _usercntrl = TextEditingController();

  // ignore: missing_return
  Future<bool> _onWillPop() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    user_profile();
    getnames();
    super.initState();
  }

  Future getnames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('User_Id');
    userName = prefs.getString('User_Name');
    userEmail = prefs.getString('userEmailId');
    userPhoto = prefs.getString('User_profile_photo_url');
  }

  @override
  Widget build(BuildContext context) {
    if (userName == null) {
      userName = " ";
    } else {
      _namecntrl.value = TextEditingValue(
        text: userName,
        selection: TextSelection.collapsed(offset: userName.length),
      );

      if (userEmail == null) {
        userEmail = " ";
      } else {
        _usercntrl.value = TextEditingValue(
            text: userEmail,
            selection: TextSelection.collapsed(offset: userEmail.length));
      }
      if (userPhoto == null) {
        userPhoto = "https://picsum.photos/250?image=9";
      } else {
        userPhoto = userPhoto;
      }
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(title: Text("Social Media")),
          body: SingleChildScrollView(
            // shrinkWrap: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blue,
                    child: _image != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              _image,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Container(
                            decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: new DecorationImage(
                                image: NetworkImage(userPhoto),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 100,
                            height: 100,
                            // child: Icon(
                            //   Icons.camera_alt,
                            //   color: Colors.grey[800],
                            // ),
                          ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new Form(
                  key: _formKey,
                  child: formUI(),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget formUI() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Stack(alignment: Alignment.topRight, children: <Widget>[
            TextFormField(
              controller: _namecntrl,
              keyboardType: TextInputType.text,
              maxLines: 1,
              enabled: false,
              validator: (String arg) {
                if (arg.length < 3)
                  return 'Enter Name';
                else
                  return null;
              },
              cursorColor: Colors.blue,
              enableInteractiveSelection: false,
              autocorrect: true,
              decoration: new InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                labelText: 'Name :',
                labelStyle: TextStyle(color: Colors.grey[800]),
              ),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ]),
          SizedBox(
            height: 15.0,
          ),
          Stack(alignment: Alignment.topRight, children: <Widget>[
            TextFormField(
              controller: _usercntrl,
              keyboardType: TextInputType.text,
              maxLines: 1,
              enabled: false,
              validator: (String arg) {
                if (arg.length < 3)
                  return 'Enter User name';
                else
                  return null;
              },
              cursorColor: Colors.blue,
              enableInteractiveSelection: false,
              autocorrect: true,
              decoration: new InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey[800]),
                ),
                labelText: 'User Name :',
                labelStyle: TextStyle(color: Colors.grey[800]),
              ),
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ]),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use
                RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.blue[800],
                  onPressed: () {
                    Navigator.pop(context);
                    // _validateInputs();
                  },
                  child: Text(
                    "  Ok  ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
