import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/common_widgets/videoPlaterCard.dart';
import 'package:social_media/features/Timeline/bloc/createPost/createPost_cubit.dart';
import 'package:social_media/utils/alerts.dart';
import '../../../common_widgets/common_button.dart';
import '../../../utils/constants.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({Key key}) : super(key: key);

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _textcntrl = TextEditingController();
  File file;
  File _video;
  File _image;
  String profilePhotoUrl = Constant.photoUrl;

  @override
  void initState() {
    super.initState();
  }

  _imgFromCamera() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    _image = File(image.path);
    if (await _image.exists()) {
      _video = null;
      file = _image;
    }
    setState(() {});
  }

  _pickVideo() async {
    final video = await ImagePicker().getVideo(source: ImageSource.gallery);
    _video = File(video.path);
    if (await _video.exists()) {
      _image = null;
      file = _video;
      Future.delayed(Duration(seconds: 1), () {
        setState(() {});
      });
      setState(() {});
    }
  }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    _image = File(image.path);
    if (await _image.exists()) {
      _video = null;
      file = _image;
    }
    setState(() {});
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
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text("Create Post"),
            ),
            resizeToAvoidBottomInset: false,
            body: BlocProvider<CreatePostCubit>(
                create: (context) => CreatePostCubit(),
                child: BlocConsumer<CreatePostCubit, CreatePostState>(
                    listener: (cont, state) {
                  if (state is CreatePostError)
                    Alerts.showErrorToast("Post upload Failed, Try again");
                  if (state is CreatePostSuccess) {
                    Navigator.pop(context);
                    if (state.success) Alerts.showToast("Post uploded");
                  }
                }, builder: (ctx, state) {
                  // print(state);
                  if (state is CreatePostLoading)
                    return CommonFullProgressIndicator(
                      message: "Uploading...",
                    );
                  return child(ctx);
                }))));
  }

  Widget child(BuildContext ctx) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(profilePhotoUrl),
                  backgroundColor: Colors.blue,
                ),
              ),
              InkWell(
                onTap: () {
                  _showPicker(context);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                  child: Icon(
                    Icons.photo_camera,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Expanded(
                child: Form(
                  key: _formKey,
                  child: new TextFormField(
                    controller: _textcntrl,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    minLines: 5,
                    cursorColor: Colors.black,
                    validator: (valu) {
                      if (valu == null || valu == "") return "Required";
                      return null;
                    },
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
          SizedBox(
            height: 5,
          ),
          _image != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.file(
                    _image,
                    // width: 300,
                    height: 200,
                    fit: BoxFit.fill,
                  ),
                )
              : Container(),
          if (_video != null)
            VideoPlayCard(
              _video.path,
              autoPlay: false,
              isAsset: true,
            ),

          SizedBox(
            height: 10,
          ),
          // if (_textcntrl.value != null)
          CommonButton(
            label: "Post",
            onPressed: () {
              if (_formKey.currentState.validate())
                ctx.read<CreatePostCubit>()
                  ..createPost(file, _video != null, _textcntrl.text);
            },
          )
        ],
      ),
    );
  }
}
