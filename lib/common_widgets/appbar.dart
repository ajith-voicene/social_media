 import 'package:flutter/material.dart';

import 'customAppBarClipper.dart';

class CustomAppBar extends PreferredSize {
  final String title;

  CustomAppBar({this.title});
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 50);
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomAppBarClipper(),
      child: Container(
        color: Colors.cyan,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(
              builder: (context) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: ListTile(
                        onTap: () {
                          Scaffold.of(context).openDrawer();
                        },
                        leading: new Image.asset(
                          'images/menu.png',
                          height: 25.0,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          title ?? 'Justice Tracker',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        trailing: Text(" "),
                      ),
                    )
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
