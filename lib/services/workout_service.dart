import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/services/auth_service.dart';

class WorkoutService {
  final AuthService authService;

  final CollectionReference<Workout> workoutCollection;

  WorkoutService(this.workoutCollection, this.authService);

  Future<List<Workout>?> getAll() async {
    if (authService.user?.uid != null) {
      try {
        var ref = await workoutCollection
            .where("user", isEqualTo: authService.user?.uid)
            .get();

        return ref.docs.map((e) => e.data()).toList();
      } catch (e) {
        // No handling
      }
    }
    return null;
  }
}
