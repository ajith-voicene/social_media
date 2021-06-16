import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_media/common_widgets/commonLoading.dart';
import 'package:social_media/utils/alerts.dart';

import 'features/auth/bloc/logout/logout_cubit.dart';
import 'features/auth/pages/login_page.dart';

class Drawers extends StatefulWidget {
  const Drawers({Key key}) : super(key: key);

  @override
  _DrawersState createState() => _DrawersState();
}

class _DrawersState extends State<Drawers> {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width / 1;
    return MaterialApp(
        home: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                new Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 1.0,
                      mainAxisSpacing: 1.0,
                      childAspectRatio: screenWidth / 180.0,
                      children: List.generate(choices.length, (index) {
                        return SelectCard(choice: choices[index]);
                      })),
                ),
                InkWell(
                  onTap: () {
                    showAlertDialog(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Log Out",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                )
              ],
            )));
  }

  showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return BlocProvider<LogoutCubit>(
            create: (context) => LogoutCubit(),
            child: Builder(
              builder: (context) => BlocConsumer<LogoutCubit, LogoutState>(
                listener: (context, state) {
                  if (state is LogoutSuccess) {
                    Alerts.showToast("Logout completed");
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        (r) => false);
                  }
                  if (state is LogoutError) Alerts.showErrorToast(null);
                },
                builder: (cont, state) {
                  if (state is LogoutLoading)
                    return CommonFullProgressIndicator(
                      color: Colors.white,
                      message: "logout processing...",
                    );
                  return AlertDialog(
                    title: Center(
                        child: Text(
                      "Logout Application",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                    content: Text(
                        "Are you sure, Do you want to Logout the application?",
                        style: TextStyle(color: Colors.black, fontSize: 16)),
                    actions: <Widget>[
                      new GestureDetector(
                        child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Text(
                              "Close",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 16,
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          cont.read<LogoutCubit>().logout();
                        },
                        child: new GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 18, color: Colors.blue[800]),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        });

    // show the dialog
  }
}

class Choice {
  const Choice({this.title, this.icon});
  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Find Friends', icon: Icons.search),
  const Choice(title: 'Marketplace', icon: Icons.place),
  const Choice(title: 'Groups', icon: Icons.group),
  const Choice(title: 'Videos on Watch', icon: Icons.video_collection),
  const Choice(title: 'Saved', icon: Icons.save),
  const Choice(title: 'Pages', icon: Icons.pages),
  const Choice(title: 'Events', icon: Icons.event_sharp),
  const Choice(title: 'Jobs', icon: Icons.work),
  const Choice(title: 'Naerby Friends', icon: Icons.near_me),
  const Choice(title: 'Update Friends', icon: Icons.update),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        color: Colors.white,
        child: Center(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                  child: Center(
                      child: Icon(choice.icon, size: 30.0, color: Colors.blue)),
                )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                  child: Center(
                      child: Text(choice.title,
                          style: TextStyle(color: Colors.black, fontSize: 15))),
                ),
              ]),
        ));
  }
}
