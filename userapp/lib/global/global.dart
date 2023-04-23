import 'package:firebase_auth/firebase_auth.dart';
import 'package:userapp/models/direction_details_info.dart';
import 'package:userapp/models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List dList = []; //driverkeys info list
DirectionDetailsInfo? tripDirectionDetailsInfo;
String? chosenDriverId = "";
String cloudMessagingServerToken =
    "key=AAAAKX8O9Wg:APA91bGvbGhKZhevimM3rALdLOYXXQexYUTZg3iM4V5ODjTJWEW0xVQmbGhT7xarf7IW4N8ztRU9wcyunO0UrNPEKJkzxGUykDvcKYGX4opn5OL-S6KDAo2QQbIfhkbIKFwhwvDKhu4d";
String userDropOffAddress = "";
String driverCarDetails = "";
String driverName = "";
String driverPhone = "";
