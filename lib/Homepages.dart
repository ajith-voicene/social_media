import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/profile_api.dart';
import 'CustomAppBar.dart';
import 'timeline.dart';
import 'urls.dart';


void main() => runApp(new MaterialApp(
  home: new Homepages(),
));

class Homepages extends StatefulWidget {
  @override
  _State createState() {
    return new _State();
  }
}
final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _State extends State<Homepages> {
  bool isLoggedIn = false;
  bool isLoading = false;

String  provider=" ",device_name=" ",tokenss=" ";
  Future<String> signInWithGoogle() async {
    await Firebase.initializeApp();
    print("hhhhhh");
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    print("hhhhhh");
    final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
    print("hhhhhh");
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    print(googleSignInAuthentication.accessToken);
    print(googleSignInAuthentication.idToken);
    print("gooooogle");
    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User user = authResult.user;

    if (user != null) {
      print("zzzz");
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      final User currentUser = _auth.currentUser;
      assert(user.uid == currentUser.uid);
      setState(() {
        provider="google";
        tokenss=googleSignInAuthentication.accessToken;
      });
      print(user.displayName);
      print(user.email);
      print(user.phoneNumber);
      print(user.uid);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('G-Name',user.displayName);
      prefs.setString('G-PhoneNumber',user.phoneNumber);
      prefs.setString('G-Id', user.uid);
      prefs.setString('G-Email', user.email);
      return '$user';
    }

    return null;
  }
  Future get_devicename() async{
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}');  // e.g. "Moto G (4)"+
    setState(() {
      device_name =androidInfo.model;
      print(device_name);
    });
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}');

    setState(() {
      device_name =iosInfo.utsname.machine;
      print(device_name);
    });
  }
  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(

        children: [

          CircularProgressIndicator(
            valueColor:AlwaysStoppedAnimation<Color>(Colors.blue),
          ),

          Container(
              margin: EdgeInsets.only(left: 5), child: Text("Loading....")),

        ],
      ),
    );
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;

      },
    );

  }
  Future<void> signOutGoogle() async {
    await googleSignIn.signOut();

    print("User Signed Out");
  }
   final fbLogin = FacebookLogin();

  void onLoginStatusChanged(bool isLoggedIn, {profileData}) {
    setState(() {
      this.isLoggedIn = isLoggedIn;
      if(isLoggedIn==true){
       _validateInputs();
      }
    });
  }
  @override
  void initState() {
   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
       statusBarColor: Colors.blue, // Color for Android
       statusBarBrightness: Brightness.dark // Dark == white status bar -- for IOS.
   ));
   get_devicename();
    super.initState();
  }
  // ignore: missing_return
  Future<bool> _onWillPop()  {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new WillPopScope(
        onWillPop: _onWillPop,
      child: new Scaffold(
        appBar: PreferredSize(
            child: ClipPath(
              clipper: CustomAppBar(),
              child: Container(color: Colors.blue, child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center ,
                children: <Widget>[
                  Builder(
                    builder: (context) =>Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // InkWell(
                          //   onTap: (){
                          //     Scaffold.of(context).openDrawer();
                          //   },
                          //   child:
                          //   new Image.asset(
                          //     'images/menu.png',
                          //     height: 25.0,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          Text(' ', style: TextStyle(color: Colors.white, fontSize: 25),),
                          Text('Social Media', style: TextStyle(color: Colors.white, fontSize: 25),),
                          Text(' ', style: TextStyle(color: Colors.white, fontSize: 25),)
                        ]),
                  ),
                ],),),
            ),
            preferredSize: Size.fromHeight(kToolbarHeight + 50)),
backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(children: <Widget>[
          Container(

          ),
          Center(
            child: Container(
              height: 250,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 30,),
                    MaterialButton(
                      // minWidth: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)),
                      onPressed: () async {
                        print("kkkkkk");
                        // initiateFacebookLogin();
                        final result = await fbLogin.logInWithReadPermissions(['email']);
                        print("aaaa");
                        final token = result.accessToken.token;
                        print(token);
                        switch (result.status) {
                          case FacebookLoginStatus.error:
                            print("llllll");
                            onLoginStatusChanged(false);
                            break;
                          case FacebookLoginStatus.cancelledByUser:
                            print("hhhhhhh");
                            onLoginStatusChanged(false);
                            break;
                          case FacebookLoginStatus.loggedIn:
                            print(result.status);
                            setState(() {
                              provider="facebook";
                              tokenss=token;
                            });
                            final graphResponse = await http.get(
                                'https://graph.facebook.com/v2.12/me?fields=name,first_name,picture,last_name,'
                                    'email&access_token=${token}');
                            final profile = json.decode(graphResponse.body);
                            print(profile);
                            print(profile['name']);
                            print(profile['last_name']);
                            print(profile['email']);
                            print(profile['id']);
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setString('Name', profile['name']);
                            prefs.setString('FirstName', profile['first_name']);
                            prefs.setString('LastName', profile['last_name']);
                            prefs.setString('Id', profile['id']);
                            prefs.setString('Email', profile['email']);
                            onLoginStatusChanged(true, profileData: profile);
                            break;
                        }
                        },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Image.asset(
                              'images/agro_fb.jpg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8,8,8,8),
                            child: Text(
                              "Connect with Facebook",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.blueAccent,
                    ),
                    SizedBox(height: 30,),
                    MaterialButton(
                      // height: 40,b
                      // minWidth: 200,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20)),
                      onPressed: () {
                        signInWithGoogle().then((result) {
                          if (result != null) {
                           _validateInputs();
                          }
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Image.asset(
                              'images/google.jpg',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            child: Text(
                              "Connect with Google",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      color: Colors.blueAccent,
                    ),


                  ],
                ),
              ),

            ),
          )
        ]),


      ),
    );
  }

  void _validateInputs() {

      showAlertDialog(context);
      fetchPost();

  }

  Future<String> fetchPost() async {
    // <------ CHANGED THIS LINE

    final response = await http.post(social,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          "token": tokenss,
          "provider": provider,
          "device_name":device_name
        }));
    print(response);
    Map<String, dynamic> responseJson = json.decode(response.body);
    print(responseJson);
    var message, success, token, user_type, name,my_id,photo_url;
    message = responseJson["message"];
    success = responseJson["success"];
    name = responseJson['data']['name'];
    photo_url=responseJson['data']['profile_photo_url'];
    my_id=responseJson['data']['id'];
    token = responseJson["token"];
    print("token====");
    print(token);
    print(name);
    if (success == true) {
      print("provider===");
      print(provider);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('Name', responseJson['data']['name']);
      prefs.setString('Token', responseJson['token']);
      prefs.setString('EmailId', responseJson['data']['email']);
      prefs.setString('profile_photo_url', responseJson['data']['profile_photo_url']);
      prefs.setString('My_Id', responseJson['data']['id'].toString());
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
     my_profile();
      Navigator.of(context).push(

        MaterialPageRoute(
          builder: (context) {
            return Timeline();
          },
        ),
      );

    } else {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 14.0
      );
      Navigator.of(context, rootNavigator: true).pop();
      throw Exception('Failed to load post');
    }
  }
}
