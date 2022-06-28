import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:swole_app/flavor_config.dart';
import 'package:flutter/material.dart';
import 'package:swole_app/constants/routes.dart';
import 'package:swole_app/screens/add_workout/add_workout.dart';
import 'package:swole_app/screens/home/home.dart';

Future<void> _connectToFirebaseEmulator() async {
  final localhost = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
  await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    if (Flavor.current == Environment.dev) {
      _connectToFirebaseEmulator();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Flavor.name,
      theme: ThemeData(),
      initialRoute: AppRoute.root.value,
      routes: {
        AppRoute.root.value: (context) => const HomeScreen(),
        AppRoute.addWorkout.value: (context) => const AddWorkoutScreen(),
      },
    );
  }
}
