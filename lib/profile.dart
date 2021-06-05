
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:social_media/Homepages.dart';
import 'package:social_media/profile_api.dart';
import 'package:social_media/timeline.dart';
import 'urls.dart';

void main() => runApp(new MaterialApp(
    home: new profile()));




class profile extends StatefulWidget {
  @override
  profile_State createState() {
    return new profile_State();
  }
}

class profile_State extends State<profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  File _image;
  String name,email, base64Image,profile_photo_url;
  final _namecntrl = TextEditingController();
  final _usercntrl = TextEditingController();

  // ignore: missing_return
  Future<bool> _onWillPop() {

   Navigator.of(context).pop();
  }

  @override
  void initState() {
    my_profile();
    getnames();
    super.initState();

  }

  Future getnames() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
     email = prefs.getString('EmailId');
    profile_photo_url=prefs.getString('profile_photo_url');
    setState(() {
      name=name;
      email=email;
      profile_photo_url=profile_photo_url;
      print(name);
    });
  }
  @override
  Widget build(BuildContext context) {
    if(name==null){
      name=" ";
    }
    else{
      _namecntrl.value=TextEditingValue(text: name,selection: TextSelection.collapsed(offset: name.length),);
    }
    if(email==null){
      email=" ";
    }
    else{
      _usercntrl.value=TextEditingValue(text: email,selection: TextSelection.collapsed(offset: email.length));

    }
    if(profile_photo_url==null){
      profile_photo_url="https://picsum.photos/250?image=9";
    }else{
      profile_photo_url=profile_photo_url;
    }
    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                    },
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
                            image: NetworkImage(
                                profile_photo_url),
                            fit: BoxFit.cover,

                          ),),
                        width: 100,
                        height: 100,
                        // child: Icon(
                        //   Icons.camera_alt,
                        //   color: Colors.grey[800],
                        // ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                new Form(
                  key: _formKey,
                  child: FormUI(),
                ),
                SizedBox(
                  height: 30,
                ),

              ],
            ),
          ],
        ),

      ),
    );
  }
  Widget FormUI() {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),

          Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                TextFormField(
                  controller: _namecntrl,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
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



          Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
                TextFormField(
                  controller: _usercntrl,
                  keyboardType: TextInputType.text,
                  maxLines: 1,
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
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
                  color: Colors.blue[800],
                  onPressed: () {

                    // _validateInputs();
                  },
                  child: Text(
                    "  Submit  ",
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

