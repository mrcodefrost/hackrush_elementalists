import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:userapp/authentication/login_screen.dart';
import 'package:userapp/global/constants.dart';
import 'package:userapp/global/global.dart';
import 'package:userapp/splashScreen/splash_screen.dart';
import 'package:userapp/widgets/progress_dialog.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (nameTextEditingController.text.length < 3) {
      Fluttertoast.showToast(
          msg: "The Name must be at least 3 characters long");
    } else if (!emailTextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid");
    } else if (phoneTextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone number required");
    } else if (passwordTextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be at least 6 characters");
    } else {
      saveUserInfoNow();
    }
  }

  saveUserInfoNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Loading, Please wait",
          );
        });
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text.trim(),
                password: passwordTextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error: " + msg.toString());
    }))
        .user;
    if (firebaseUser != null) {
      // To store the data on firebase based on UID
      Map usersMap = {
        "id": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };

      DatabaseReference driversRef =
          FirebaseDatabase.instance.ref().child("users");
      driversRef.child(firebaseUser.uid).set(usersMap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account is created");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account was not created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
                "Register as a User",
                style: TextStyle(
                  fontSize: 26,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: nameTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Name",
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
                controller: phoneTextEditingController,
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Phone",
                  hintText: "Phone",
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
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (c) => CarInfoScreen()));
                },
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                ),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                    color: kBackgroundColor,
                    fontSize: 18,
                  ),
                ),
              ),
              TextButton(
                child: const Text(
                  "Already have an Account ? Login here",
                  style: TextStyle(color: kHeadingColor),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => LoginScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
