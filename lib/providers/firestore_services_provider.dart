import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/account.dart';
import 'package:swole_app/models/team.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/providers/auth_service_provider.dart';
import 'package:swole_app/services/account_service.dart';
import 'package:swole_app/services/teams_service.dart';
import 'package:swole_app/services/workout_service.dart';

final firestoreProvider =
    Provider<FirebaseFirestore>((_ref) => FirebaseFirestore.instance);

final crashlyticsProvider =
    Provider<FirebaseCrashlytics>((_ref) => FirebaseCrashlytics.instance);

final accountServiceProvider = Provider<AccountService>((ref) {
  var firestore = ref.read(firestoreProvider);

  return AccountService(
    firestore.collection('account').withConverter(
        fromFirestore: Account.fromJson,
        toFirestore: (Account _acc, _) => _acc.toJson()),
    ref.read(authServiceProvider),
  );
});

final workoutServiceProvider = Provider<WorkoutService>((ref) {
  var firestore = ref.read(firestoreProvider);

  return WorkoutService(
    firestore.collection('workouts').withConverter(
        fromFirestore: Workout.fromJson,
        toFirestore: (Workout _w, _) => _w.toJson()),
    ref.read(authServiceProvider),
  );
});

final teamsServiceProvider = Provider<TeamsService>((ref) {
  var firestore = ref.read(firestoreProvider);
  var accountService = ref.read(accountServiceProvider);
  var authService = ref.read(authServiceProvider);
  var crashlytics = ref.read(crashlyticsProvider);

  return TeamsService(
    firestore.collection('teams').withConverter(
          fromFirestore: Team.fromJson,
          toFirestore: (Team _t, _) => _t.toJson(),
        ),
    accountService,
    authService,
    crashlytics,
  );
});
