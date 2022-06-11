import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/constants/routes.dart';
import 'package:swole_app/screens/add_workout/add_workout.dart';
import 'package:swole_app/screens/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
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
