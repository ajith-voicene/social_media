
import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:social_media/Homepages.dart';
import 'package:social_media/profile_api.dart';
import 'urls.dart';

void main() {
  runApp(user_profile());
}





// ignore: camel_case_types
class user_profile extends StatefulWidget {
  @override
  user_profile_State createState() {
    return new user_profile_State();
  }
}

class user_profile_State extends State<user_profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  File _image;
  String user_id,user_name,user_email,user_photo;
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

  Future getnames() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    user_id = prefs.getString('User_Id');
    user_name=prefs.getString('User_Name');
    user_email=prefs.getString('User_EmailId');
    user_photo=prefs.getString('User_profile_photo_url');
    setState(() {
      user_id=user_id;
      user_name=user_name;
      user_email=user_email;
      user_photo=user_photo;
      print(user_id);
    });
  }
  @override
  Widget build(BuildContext context) {
    if(user_name==null){
      user_name=" ";
    }
    else{
      _namecntrl.value=TextEditingValue(text: user_name,selection: TextSelection.collapsed(offset: user_name.length),);
    }
    if(user_email==null){
      user_email=" ";
    }
    else{
      _usercntrl.value=TextEditingValue(text: user_email,selection: TextSelection.collapsed(offset: user_email.length));

    }
    if(user_photo==null){
      user_photo="https://picsum.photos/250?image=9";
    }else{
      user_photo=user_photo;
    }
    return  WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
              title:Text("Social Media")
          ),
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
                          image: NetworkImage(
                              user_photo),
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



          Stack(
              alignment: Alignment.topRight,
              children: <Widget>[
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
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0)),
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

  Future<String> user_profilesss() async { // <------ CHANGED THIS LINE

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");
    user_id = prefs.getString('User_Id');
    print("token123");
    print(token);
    final response = await http.get(
      single_user+user_id,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      },
    );
    Map<String, dynamic> responseJson = json.decode(response.body);
    print(responseJson);
    var message,success;
    message = responseJson["message"];
    success = responseJson["success"];
    if (success == true) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('User_Name', responseJson['data']['name']);
      prefs.setString('User_EmailId', responseJson['data']['email']);
      prefs.setString('User_profile_photo_url', responseJson['data']['profile_photo_url']);
      // print('RETURNING: ' + response.body);
      // Fluttertoast.showToast(
      //     msg:message,
      //     toastLength: Toast.LENGTH_LONG,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIos: 1,
      //     backgroundColor: Colors.black,
      //     textColor: Colors.white,
      //     fontSize: 14.0
      // );



    } else {
      Fluttertoast.showToast(
          msg:message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
      throw Exception('Failed to load post');

    }
  }

}

