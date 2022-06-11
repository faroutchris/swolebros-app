import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/models/account_settings.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/providers/auth_service_provider.dart';
import 'package:swole_app/services/account_settings_service.dart';
import 'package:swole_app/services/workout_service.dart';

final firebaseFirestoreProvider =
    Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final accountSettingsServiceProvider = Provider<AccountSettingsService>((ref) =>
    AccountSettingsService(
        FirebaseFirestore.instance.collection('accountsettings').withConverter(
            fromFirestore: AccountSettings.fromJson,
            toFirestore: (AccountSettings _acc, _) => _acc.toJson()),
        ref.read(authServiceProvider)));

final workoutServiceProvider = Provider<WorkoutService>((ref) => WorkoutService(
    FirebaseFirestore.instance.collection('workouts').withConverter(
        fromFirestore: Workout.fromJson,
        toFirestore: (Workout _w, _) => _w.toJson()),
    ref.read(authServiceProvider)));
