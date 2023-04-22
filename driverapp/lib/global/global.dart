import 'dart:async';

import 'package:driverapp/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
StreamSubscription<Position>? streamSubscriptionPosition;
