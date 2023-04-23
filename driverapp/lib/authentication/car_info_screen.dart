import 'package:driverapp/global/constants.dart';
import 'package:driverapp/global/global.dart';
import 'package:driverapp/splashScreen/splash_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({Key? key}) : super(key: key);

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  TextEditingController carModelTextEditingController = TextEditingController();
  TextEditingController carNumberTextEditingController =
      TextEditingController();
  TextEditingController carColorTextEditingController = TextEditingController();

  List<String> carTypesList = [
    "Basic Life Support",
    "Critical Care",
    "Govt Ambulance",
    "MVA Ambulance"
  ];
  String? selectedCarType;

  saveCarInfo() {
    Map driverCarInfoMap = {
      "car_color": carColorTextEditingController.text.trim(),
      "car_number": carNumberTextEditingController.text.trim(),
      "car_model": carModelTextEditingController.text.trim(),
      "type": selectedCarType,
    };

    DatabaseReference driversRef =
        FirebaseDatabase.instance.ref().child("drivers");
    driversRef
        .child(currentFirebaseUser!.uid)
        .child("car_details")
        .set(driverCarInfoMap);

    Fluttertoast.showToast(msg: "Vehicle Details Saved");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Image.asset("images/logo1.png"),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Please Provide Ambulance Details",
                style: TextStyle(
                  fontSize: 26,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextField(
                controller: carModelTextEditingController,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Model",
                  hintText: "Vehicle Model",
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
                controller: carNumberTextEditingController,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Number",
                  hintText: "Vehicle Number",
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
                controller: carColorTextEditingController,
                style: const TextStyle(
                  color: kTextColor,
                ),
                decoration: const InputDecoration(
                  labelText: "Vehicle Color",
                  hintText: "Vehicle Color",
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
              DropdownButton(
                iconSize: 30,
                hint: const Text(
                  "Please Select Ambulance Type",
                  style: TextStyle(
                    fontSize: 14,
                    color: kTextColor,
                  ),
                ),
                value: selectedCarType,
                onChanged: (newValue) {
                  setState(() {
                    selectedCarType = newValue.toString();
                  });
                },
                items: carTypesList.map((car) {
                  return DropdownMenuItem(
                    child: Text(
                      car,
                      style: const TextStyle(
                        color: kHeadingColor,
                      ),
                    ),
                    value: car,
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (carColorTextEditingController.text.isNotEmpty &&
                        carNumberTextEditingController.text.isNotEmpty &&
                        carModelTextEditingController.text.isNotEmpty &&
                        selectedCarType != null) {
                      saveCarInfo();
                    } else {
                      Fluttertoast.showToast(msg: "Oops ! Something wrong");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                  ),
                  child: const Text(
                    "Save Now",
                    style: TextStyle(
                      color: kBackgroundColor,
                      fontSize: 18,
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
