import 'package:flutter/material.dart';
import 'package:userapp/global/constants.dart';
import 'package:userapp/global/global.dart';
import 'package:userapp/splashScreen/splash_screen.dart';

class MyDrawer extends StatefulWidget {
  String? name;
  String? email;

  MyDrawer({this.name, this.email});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          //drawer header
          Container(
            height: 165,
            color: kHeadingColor,
            child: DrawerHeader(
              decoration: const BoxDecoration(color: kBackgroundColor),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    size: 80,
                    color: kHeadingColor,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.name.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: kTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.email.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: kTextColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(
            height: 12.0,
          ),

          //drawer body
          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.history,
                color: kPrimaryColor,
              ),
              title: Text(
                "History",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              title: Text(
                "Visit Profile",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {},
            child: const ListTile(
              leading: Icon(
                Icons.info,
                color: kPrimaryColor,
              ),
              title: Text(
                "About",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ),

          GestureDetector(
            onTap: () {
              fAuth.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const MySplashScreen()));
            },
            child: const ListTile(
              leading: Icon(
                Icons.logout,
                color: kPrimaryColor,
              ),
              title: Text(
                "Sign Out",
                style: TextStyle(color: kTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
