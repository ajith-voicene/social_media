import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/features/Timeline/bloc/timelineFeed/timelineFeed_cubit.dart';
import 'package:social_media/features/Timeline/widget/postCard.dart';

import 'create_post.dart';
import '../../../utils/constants.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _textcntrl = TextEditingController();
  String profilePhotoUrl = Constant.photoUrl, type = "0", myId;
  MaterialColor color;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) => RefreshIndicator(
          onRefresh: () async {
            context.read<TimelineFeedCubit>().getPosts();
          },
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: BlocConsumer<TimelineFeedCubit, TimelineFeedState>(
                  listener: (context, state) {
                // if (state is TimelineFeedSuccess)
              }, builder: (context, state) {
                if (state is TimelineFeedSuccess ||
                    state is TimelineFeedLoading)
                  return SingleChildScrollView(child: child(state));
                return CommonFullProgressIndicator(
                  message: "Loading posts...",
                );
              }))),
    );
  }

  Widget child(state) => Column(children: [
        if (state is TimelineFeedLoading) LinearProgressIndicator(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage(profilePhotoUrl),
            ),
          ),
          Container(
            child: Expanded(
              child: new TextFormField(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return CreatePost();
                      },
                    ),
                  );
                },
                controller: _textcntrl,
                keyboardType: null,
                maxLines: 5,
                minLines: 1,
                cursorColor: Colors.black,
                enableInteractiveSelection: false,
                autocorrect: true,
                decoration: new InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800], width: 1.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800], width: 1.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[800], width: 1.0),
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(30.0),
                    ),
                  ),
                  hintText: 'Write something here..... ',
                  labelStyle: TextStyle(color: Colors.grey[800]),
                ),
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ),
          ),
        ]),
        SizedBox(
          height: 5,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: state.list.length,
            cacheExtent: 8,
            itemBuilder: (context, index) {
              return PostCard(
                state.list[index],
                onLiked: (v) {},
              );
            })
      ]);

  Future<String> user_profilesss() async {
    // <------ CHANGED THIS LINE

    // final response = await http.get(
    //   single_user+userId,
    //   headers: {
    //     'Content-Type': 'application/json',
    //     'Accept': 'application/json',
    //     'Authorization': 'Bearer $token'
    //   },
    // );
    // Map<String, dynamic> responseJson = json.decode(response.body);
    // print(responseJson);
    // var message,success;
    // message = responseJson["message"];
    // success = responseJson["success"];
    // if (success == true) {
    //   print('RETURNING: ' + response.body);
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('User_Name', responseJson['data']['name']);
    //   prefs.setString('User_EmailId', responseJson['data']['email']);
    //   prefs.setString('User_profile_photo_url', responseJson['data']['profile_photo_url']);
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) {
    //         return user_profile();
    //       },
    //     ),
    //   );
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

    // } else {
    //   Fluttertoast.showToast(
    //       msg:message,
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 14.0
    //   );
    //   throw Exception('Failed to load post');

    // }
  }

  // Future<List<Datass>> my_image() async {
  //
  //   //replace your restFull API here.
  //   final SharedPreferences pref = await SharedPreferences.getInstance();
  //   String token = pref.getString("Token");
  //
  //   print('Bearer $token');
  //   final response = await http.get(Timeline_url,
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );
  //   Map<String, dynamic> responseData = json.decode(response.body);
  //   var data = json.decode(response.body);
  //   // for (var record in recordsList) {
  //   //   var familyMembers = record["post_attachment"];
  //   //   print(familyMembers);
  //   //   for (var familyMember in familyMembers) { //prints the name of each family member
  //   //     var familyMemberName = familyMember["post_attachment_url"];
  //   //     print("familyMemberName");
  //   //     print(familyMemberName);
  //   //   }
  //   // }
  //
  //
  //   // for (var record in recordsList) {
  //   //   var familyMembers = record["post_attachment"];
  //   //   print(familyMembers);
  //   //   for (var familyMember in familyMembers) { //prints the name of each family member
  //   //     var familyMemberName = familyMember["post_attachment_url"];
  //   //     print("familyMemberName");
  //   //     print(familyMemberName);
  //   //   }
  //   var familyMembers = data["data"][0]["post_attachment"];
  //   print("familyMembers111");
  //   print(familyMembers);
  //   for (var familyMember in familyMembers) { //prints the name of each family member
  //     var familyMemberName = familyMember["post_attachment_url"];
  //     print("familyMembers222");
  //
  //     print(familyMemberName);
  //   }
  //   // try {
  //   // var list;
  //   //  list= data['data'].forEach((item){
  //   //     // mapping your family_members array
  //   //     item['post_attachment'].forEach((nestedItem){
  //   //       // list=nestedItem['post_attachment_url'];
  //   //      print(nestedItem['post_attachment_url']);
  //   //
  //   //     });
  //   //   });
  //    print("lisst");
  //    print(familyMembers["post_attachment_url"].toString());
  //   // List<Datass> imagesList = list.map((i) => Datass.fromJson(i)).toList();
  //   // return imagesList;
  //   }
  Future<String> reaction() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    // String post_id = pref.getString("Post_Id");
    // print("post_id==");
    // print(post_id);
    // print(type);
    // final response = await http.post(react_postss,
    //     headers: {
    //       'Content-Type': 'application/json',
    //       'Accept': 'application/json',
    //       'Authorization': 'Bearer $token'
    //     },
    //     body: jsonEncode({
    //       "post_id": post_id,
    //       "type":type,

    //     }));

    // Map<String, dynamic> responseJson = json.decode(response.body);
    // var message, success, user_type, name;
    // message = responseJson["message"];
    // success = responseJson["success"];

    // if (success == true) {
    //   print('RETURNING: ' + response.body);
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIos: 1,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 14.0
    // );

    // } else {
    // Fluttertoast.showToast(
    //     msg: message,
    //     toastLength: Toast.LENGTH_LONG,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIos: 1,
    //     backgroundColor: Colors.black,
    //     textColor: Colors.white,
    //     fontSize: 14.0
    // );

    throw Exception('Failed to load post');
    // }
  }
}
