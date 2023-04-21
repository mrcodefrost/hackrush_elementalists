import 'package:flutter/material.dart';
import 'package:userapp/authentication/login_screen.dart';
import 'package:userapp/global/global.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          fAuth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => LoginScreen()));
        },
        child: const Text(' Sign Out'),
      ),
    );
  }
}
