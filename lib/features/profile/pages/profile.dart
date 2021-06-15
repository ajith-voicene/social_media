import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:social_media/features/profile/blocs/cubit/editprofile_cubit.dart';
import 'package:social_media/utils/alerts.dart';
import 'package:social_media/utils/constants.dart';

import '../../../common_widgets/common_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  File _image;
  String name, email, base64Image, profilePhotoUrl;
  TextEditingController _namecntrl = TextEditingController();
  TextEditingController _usercntrl = TextEditingController();

  @override
  void initState() {
    getnames();
    super.initState();
  }

  Future getnames() async {
    name = Constant.name;
    email = Constant.username;
    profilePhotoUrl = Constant.photoUrl;
  }

  @override
  Widget build(BuildContext context) {
    if (name == null) {
      name = " ";
    } else {
      _namecntrl.value = TextEditingValue(
        text: name,
        selection: TextSelection.collapsed(offset: name.length),
      );
    }
    if (email == null) {
      email = " ";
    } else {
      _usercntrl.value = TextEditingValue(
          text: email,
          selection: TextSelection.collapsed(offset: email.length));
    }
    if (profilePhotoUrl == null) {
      profilePhotoUrl = "https://picsum.photos/250?image=9";
    } else {}
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider<EditprofileCubit>(
        create: (context) => EditprofileCubit(),
        child: Builder(
          builder: (context) =>
              BlocConsumer<EditprofileCubit, EditprofileState>(
            listener: (context, state) {
              if (state is EditprofileError)
                Alerts.showErrorToast("Update Failed, Try again");
              if (state is EditprofileSuccess) {
                Alerts.showToast(state.msg);
              }
            },
            builder: (context, state) => SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (state is EditprofileLoading) LinearProgressIndicator(),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        _showPicker(context);
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
                                    image: NetworkImage(profilePhotoUrl),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                width: 100,
                                height: 100,
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  new Form(
                    key: _formKey,
                    child: formUI(context),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget formUI(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            enabled: false,
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
          SizedBox(
            height: 15.0,
          ),
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
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CommonButton(
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      context
                          .read<EditprofileCubit>()
                          .editProfile(_image, _usercntrl.text);
                    }
                  },
                  label: "Submit",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  ListTile(
                    title: new Text('Update Profile Picture'),
                  ),
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
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);

    _image = File(image.path);
    if (await _image.exists()) {
      setState(() {});
    }
  }

  _imgFromGallery() async {
    final image = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    _image = File(image.path);
    if (await _image.exists()) {
      setState(() {});
    }
  }
}
