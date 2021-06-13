import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media/common_widgets/videoPlaterCard.dart';
import 'package:social_media/model/home_models.dart';

class SingleView extends StatefulWidget {
  final Data data;
  const SingleView(this.data, {Key key}) : super(key: key);

  @override
  _SingleViewState createState() => _SingleViewState();
}

class _SingleViewState extends State<SingleView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
            child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                    child: (widget.data.firstAttachmentType == "image/jpeg")
                        ? InteractiveViewer(
                            minScale: .4,
                            child: Image.network(widget.data.firstAttachmentUrl,
                                // width: 300,
                                // height: 300,
                                fit: BoxFit.contain),
                          )
                        : (widget.data.firstAttachmentType == "video/mp4")
                            ? Container(
                                child: VideoPlayCard(
                                    widget.data.firstAttachmentUrl))
                            : Container(
                                height: 0,
                              )))));
  }

  Future<String> reaction() async {
    // <------ CHANGED THIS LINE

    final SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("Token");
    String post_id = pref.getString("Post_Id");

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
    //   Fluttertoast.showToast(
    //       msg: message,
    //       toastLength: Toast.LENGTH_LONG,
    //       gravity: ToastGravity.BOTTOM,
    //       timeInSecForIos: 1,
    //       backgroundColor: Colors.black,
    //       textColor: Colors.white,
    //       fontSize: 14.0
    //   );

    // } else {
    //   Fluttertoast.showToast(
    //       msg: message,
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
}
