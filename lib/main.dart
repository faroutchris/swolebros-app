import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/constants/routes.dart';
import 'package:swole_app/screens/add_workout/add_workout.dart';
import 'package:swole_app/screens/home/home.dart';

Future<void> _connectToFirebaseEmulator() async {
  final localhost = Platform.isAndroid ? '10.0.2.2' : 'localhost';

  FirebaseFirestore.instance.useFirestoreEmulator(localhost, 8080);
  await FirebaseAuth.instance.useAuthEmulator(localhost, 9099);
}

void main() async {
  // https://docs.flutter.dev/testing/errors
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Change to flavour based setup
    // await _connectToFirebaseEmulator();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    if (kReleaseMode) {
      ErrorWidget.builder = (FlutterErrorDetails details) =>
          const Center(child: Text("Something went terribly wrong"));
    }

    return runApp(const ProviderScope(child: MyApp()));
  }, (Object error, StackTrace stack) {
    if (kDebugMode) {
      print("Send error to backend");
      print(error);
      print(stack);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      initialRoute: AppRoute.root.value,
      routes: {
        AppRoute.root.value: (context) => const HomeScreen(),
        AppRoute.addWorkout.value: (context) => const AddWorkoutScreen(),
      },
    );
  }
}
