
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({ Key key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 
  File _image;
  String name,email, base64Image,profilePhotoUrl;
  final _namecntrl = TextEditingController();
  final _usercntrl = TextEditingController();


  @override
  void initState() {
    getnames();
    super.initState();

  }

  Future getnames() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('Name');
     email = prefs.getString('EmailId');
    profilePhotoUrl=prefs.getString('profile_photo_url');
   
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
    if(profilePhotoUrl==null){
      profilePhotoUrl="https://picsum.photos/250?image=9";
    }else{
      }
    return Scaffold(
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
                              profilePhotoUrl),
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
                child: formUI(),
              ),
              SizedBox(
                height: 30,
              ),

            ],
          ),
        ],
      ),

    );
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

