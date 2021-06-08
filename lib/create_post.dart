
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class CreatePost extends StatefulWidget {
  const CreatePost({ Key key }) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textcntrl = TextEditingController();
  String savedImage;
  File galleryFile;
  File file;
  File _video;
  File _image;
  String base64Image;
  String myActivity;
  String fileName;
  File _imageFile;
  File _storedImage;
  final picker = ImagePicker();
  String profilePhotoUrl;
   @override
  void initState() {
    super.initState();

  }
  _imgFromCamera() async {
    // File image = picker.getImage(
    //     source: ImageSource.camera, imageQuality: 50
    // );

    // setState(() {
    //   base64Image = base64Encode(image.readAsBytesSync());
    //   _image = image;
    // });
  }
  _pickVideo() async {
    // File video = await ImagePicker.pickVideo(source: ImageSource.gallery);
    // _video = video;
    // _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
    //   setState(() { });
    //   _videoPlayerController.play();
    // });
  }
  _imgFromGallery() async {
    // File image = await  ImagePicker.pickImage(
    //     source: ImageSource.gallery, imageQuality: 50
    // );

    // setState(() {
    //   base64Image = base64Encode(image.readAsBytesSync());
    //   _image = image;
    // });

  }
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                  new ListTile(
                    leading: new Icon(Icons.album),
                    title: new Text('Video'),
                    onTap: () {
                      _pickVideo();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    // if(profile_photo_url==null){
    //   profile_photo_url="https://picsum.photos/250?image=9";
    // }else{
    //   profile_photo_url=profile_photo_url;
    // }
    final screenWidth = MediaQuery.of(context).size.width/1;
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.keyboard_backspace,
                  color: Colors.white,
                  size: 25,
                ),
              ),
                title:Text("Create Post"),
              actions: [
                InkWell(
                    onTap:(){
                      fetchPost();
                    },child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("POST",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                    )),
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Column(

                children: [
                  SizedBox(height: 40,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
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
                                    image: NetworkImage(
                                        profilePhotoUrl),
                                    fit: BoxFit.cover,
                                  )),
                              // width: 60,

                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){
                      _showPicker(context);
                      },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                          child: Icon(Icons.photo_camera,color: Colors.grey,size: 30,),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Expanded(
                            child: Form(
                              key: _formKey,
                              child: new TextFormField(
                                controller: _textcntrl,
                                keyboardType: TextInputType.text,
                                maxLines: 10,
                                minLines: 5,
                                cursorColor: Colors.black,
                                enableInteractiveSelection: false,
                                autocorrect: true,
                                decoration: new InputDecoration(

                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey[800], width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(0.0),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey[800], width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(0.0),

                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.grey[800], width: 1.0),
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(0.0),

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
                  ),
                  SizedBox(height: 5,),
                  _image != null
                      ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          _image  ,
                          // width: 300,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      )
                      : Container(
                    width: 0,
                    height: 0,

                  ),
                  // if(_video != null)
                  //   _videoPlayerController.value.isInitialized
                  //       ? AspectRatio(
                  //     aspectRatio: 3 / 2,
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: VideoPlayer(_videoPlayerController),
                  //     ),
                  //   )
                  //       : Container()
                ],
              ),
            )
        )
    );
  }
  Future<void> fetchPost() async {
    print("_storedImage");
    print(_image);
    // print(_image.path);
    print(_textcntrl.text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("Token");
    print(token);
    // var request =  http.MultipartRequest(
    //     'POST', Uri.parse(Create_Post),
    // );
    // request.headers["Authorization"]='Bearer $token';
    // request.fields['content'] = _textcntrl.text;
    // if(_image==null) {
print("no_image");
    // }else{

    //   request.files.add(
    //       await http.MultipartFile.fromPath('attachment[0]', _image.path));
    // }
    // if(_video==null) {
    //   print("no_video");
    // }else{

    //   request.files.add(
    //       await http.MultipartFile.fromPath('attachment[0]', _video.path));
    // }
    Fluttertoast.showToast(
        msg: "Uploading....",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
       
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0
    );
   
    // request.send().then((response) async {
    //   if (response.statusCode == 200) {
    //     var res = await http.Response.fromStream(response);
    //     print(res.body);
    //     var responseDecode = json.decode(res.body);
    //     String msg=responseDecode['message'];
    //     print("msg===");
    //     print(msg);
    //     Fluttertoast.showToast(
    //         msg: msg,
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIos: 1,
    //         backgroundColor: Colors.black,
    //         textColor: Colors.white,
    //         fontSize: 14.0
    //     );
    //     Navigator.of(context).push(
    //       MaterialPageRoute(
    //         builder: (context) {
    //           return Timeline();
    //         },
    //       ),
    //     );
    //   } else {
    //     var res = await http.Response.fromStream(response);
    //     print(res.body);
    //     var responseDecode = json.decode(res.body);
    //     String msg=responseDecode['message'];
    //     print("msg===error");
    //     print(msg);
    //     Fluttertoast.showToast(
    //         msg: msg,
    //         toastLength: Toast.LENGTH_LONG,
    //         gravity: ToastGravity.BOTTOM,
    //         timeInSecForIos: 1,
    //         backgroundColor: Colors.black,
    //         textColor: Colors.white,
    //         fontSize: 14.0
    //     );
    //   }
    // }
    // );
  }
}

