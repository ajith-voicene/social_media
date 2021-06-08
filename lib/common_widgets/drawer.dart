import 'package:flutter/material.dart';

BuildContext context;

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
//                      height: 250,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/logo.png"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 30.0,
                      left: 16.0,
                      child: Text(
                        " ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(padding: EdgeInsets.only(top: 0), children: [
              DrawerItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Home",
                onClick: () {
                  Navigator.pushNamed(
                    context,
                    '/homePage',
                  );
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Profile",
                onClick: () {
                  Navigator.of(context).pushNamed('/profile');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.call,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Call",
                onClick: () {
                  Navigator.of(context).pushNamed('/call');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.history,
                  color: Colors.black,
                  size: 30,
                ),
                title: "History",
                onClick: () {
                  Navigator.of(context).pushNamed('/history');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.campaign,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Create Cmpaign",
                onClick: () {
                  Navigator.of(context).pushNamed('/createCampaign');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.question_answer,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Questionnaire",
                onClick: () {
                  Navigator.of(context).pushNamed('/questionnaire');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.error_outline,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Complaint",
                onClick: () {
                  Navigator.of(context).pushNamed('/complaint');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.logout,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Logout",
                onClick: () {
                  return showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text("Are you sure to Logout?"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pushNamed('/logout');
                          },
                          child: Text("Yes"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(ctx).pop(),
                          child: Text("No"),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class OutsideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.85,
//                      height: 250,
              child: DrawerHeader(
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("images/logo.png"),
                        fit: BoxFit.cover)),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      bottom: 30.0,
                      left: 16.0,
                      child: Text(
                        " ",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView(padding: EdgeInsets.only(top: 0), children: [
              DrawerItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                  size: 30,
                ),
                title: "New User",
                onClick: () {
                  Navigator.of(context).pushNamed('/signup');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.store_mall_directory,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Directory",
                onClick: () {
                  Navigator.of(context).pushNamed('/directoryList');
                },
              ),
              DrawerItem(
                icon: Icon(
                  Icons.error,
                  color: Colors.black,
                  size: 30,
                ),
                title: "Emergency",
                onClick: () {
                  Navigator.of(context).pushNamed('/emergency');
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onClick;
  final Icon icon;

  const DrawerItem({Key key, this.title, this.onClick, this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: icon,
      title: Align(
        child: new Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
        alignment: Alignment(-1.2, 0),
      ),
      onTap: () {
        Navigator.pop(context);
        onClick();
      },
    );
  }
}
