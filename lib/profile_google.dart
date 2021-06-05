import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() { runApp(Profile_google()); }


class Profile_google extends StatefulWidget {
  @override
  prof_State createState() {
    return new prof_State();
  }
}

class prof_State extends State<Profile_google> {
  String name,email,firstname,PhoneNumber,id;

  Future getnames() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    name = prefs.getString('G-Name');
    PhoneNumber = prefs.getString('G-PhoneNumber');
    email = prefs.getString('G-Email');
    id=prefs.getString('G-Id');
    print(name);
    setState(() {
      name=name;
      PhoneNumber=PhoneNumber;
      email=email;
      id=id;

    });
  } @override
  void initState() {
    getnames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(name==null){
      name=" ";
    }else{
      name=name;
    }
    if(email==null){
      email=" ";
    }else{
      email=email;
    }
    if(PhoneNumber==null){
      PhoneNumber="phone number=null";
    }else{
      PhoneNumber=PhoneNumber;
    }
    if(id==null){
      id=" ";
    }else{
      id=id;
    }
    return Scaffold(
      appBar: AppBar(
          title:Text("Home Page")
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(name),
            Text(email),
            Text(PhoneNumber),
            Text(id),
          ],
        ),
      ),
    );
  }
}