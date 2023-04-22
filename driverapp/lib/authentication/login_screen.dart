import 'package:driverapp/authentication/signup_screen.dart';
import 'package:driverapp/global/constants.dart';
import 'package:driverapp/global/global.dart';
import 'package:driverapp/splashScreen/splash_screen.dart';
import 'package:driverapp/widgets/progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid");
    } else if (passwordTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password Required");
    } else {
      loginDriverNow();
    }
  }

  loginDriverNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Loading, Please wait",
          );
        });
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      // to check if driver exists
      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("drivers");
      driversRef.child(firebaseUser.uid).once().then((driverKey) {
        final snap = driverKey.snapshot;
        if (snap.value != null) {
          // To store the data on firebase based on UID
          currentFirebaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful");
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(context,
              MaterialPageRoute(builder: (c) => const MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occurred during login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset("images/logo1.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Login as a Driver",
                style: TextStyle(
                  fontSize: 26,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: emailTextEditingController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Email",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kHeadingColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  hintStyle: TextStyle(
                    color: kHeadingColor,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: kHeadingColor,
                    fontSize: 14,
                  ),
                ),
              ),
              TextField(
                controller: passwordTextEditingController,
                keyboardType: TextInputType.text,
                obscureText: true,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Password",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kHeadingColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: kPrimaryColor)),
                  hintStyle: TextStyle(
                    color: kHeadingColor,
                    fontSize: 10,
                  ),
                  labelStyle: TextStyle(
                    color: kHeadingColor,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  validateForm();
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text(
                  "Log In",
                  style: TextStyle(
                    color: kBackgroundColor,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  "Don't have an Account ? Sign Up here",
                  style: TextStyle(color: kHeadingColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
