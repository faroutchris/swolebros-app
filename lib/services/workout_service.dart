import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/services/auth_service.dart';

class WorkoutService {
  final AuthService authService;

  final CollectionReference<Workout> workoutCollection;

  WorkoutService(this.workoutCollection, this.authService);

  Future<List<Workout>?> getAll() async {
    if (authService.user?.uid != null) {
      var ref2 = await workoutCollection
          .where("user", isEqualTo: authService.user?.uid)
          .get();

      return ref2.docs.map((e) => e.data()).toList();
    }
    return null;
  }
}
