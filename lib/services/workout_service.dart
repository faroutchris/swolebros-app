import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/workout.dart';
import 'package:swole_app/services/auth_service.dart';

class WorkoutService {
  final AuthService _authService;

  final CollectionReference<Workout> _collection;

  WorkoutService(this._collection, this._authService);

  // TODO: limit by date
  Future<List<Workout>?> getAll() async {
    if (_authService.user?.uid != null) {
      var ref = await _collection
          .where("user", isEqualTo: _authService.user?.uid)
          .orderBy("date_created", descending: true)
          .get();

      var list = ref.docs.map((e) => e.data()).toList();
      return list;
    }
    return null;
  }

  Future<void> create() async {
    if (_authService.user?.uid != null) {
      var workout = Workout(
          user: _authService.user?.uid,
          type: "Fighting",
          time: 20,
          dateCreated: Timestamp.fromDate(DateTime.now()));

      await _collection.doc().set(workout);
    }
  }
}
