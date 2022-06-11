import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String? type;
  final int? time;

  Workout({required this.type, required this.time});

  factory Workout.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Workout(type: data?["type"], time: data?["time"]);
  }

  Map<String, dynamic> toJson() {
    return {
      if (type != null) "type": type,
      if (time != null) "time": time,
    };
  }
}

enum WorkoutIcons {
  running,
  gym,
  walking,
  teamsports,
  cycling,
  swimming,
  fighting,
  yoga,
  other,
  unknown
}

extension WorkoutIconsExtension on WorkoutIcons {
  static const Map<WorkoutIcons, String> values = {
    WorkoutIcons.running: "🏃‍♂️",
    WorkoutIcons.gym: "💪",
    WorkoutIcons.walking: "👟",
    WorkoutIcons.teamsports: "🏀",
    WorkoutIcons.cycling: "🚴‍♀️",
    WorkoutIcons.swimming: "🏊‍♀️",
    WorkoutIcons.fighting: "🥊",
    WorkoutIcons.yoga: "🧘‍♀️",
    WorkoutIcons.other: "🛹",
    WorkoutIcons.unknown: "🫃🏻",
  };

  String get value => values[this]!;
}

class WorkoutIconHelper {
  static String mapFrom(String workoutType) {
    switch (workoutType) {
      case "Running":
        return WorkoutIcons.running.value;
      case "Gym":
        return WorkoutIcons.gym.value;
      default:
        return WorkoutIcons.unknown.value;
    }
  }
}

void main() {
  WorkoutIcons.cycling.value;
}
