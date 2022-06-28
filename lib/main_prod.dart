import 'dart:async';
import 'firebase_options.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/app.dart';
import 'package:swole_app/flavor_config.dart';

void main() async {
  Flavor.setEnvironment(Environment.prod);

  // https://docs.flutter.dev/testing/errors
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

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
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
  });
}
