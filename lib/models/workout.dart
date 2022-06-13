import 'package:cloud_firestore/cloud_firestore.dart';

class Workout {
  final String? user;
  final String? type;
  final int? time;
  final Timestamp? dateCreated;

  Workout(
      {required this.user,
      required this.type,
      required this.time,
      required this.dateCreated});

  factory Workout.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Workout(
      user: data?["user"],
      type: data?["type"],
      time: data?["time"],
      dateCreated: data?["date_created"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (user != null) "user": user,
      if (type != null) "type": type,
      if (time != null) "time": time,
      if (dateCreated != null) "date_created": dateCreated?.toDate(),
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
  dance,
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
    WorkoutIcons.dance: "💃",
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
      case "Walking":
        return WorkoutIcons.walking.value;
      case "Team sports":
        return WorkoutIcons.teamsports.value;
      case "Cycling":
        return WorkoutIcons.cycling.value;
      case "Swimming":
        return WorkoutIcons.cycling.value;
      case "Fighting":
        return WorkoutIcons.fighting.value;
      case "Yoga":
        return WorkoutIcons.yoga.value;
      case "Dance":
        return WorkoutIcons.dance.value;
      case "Other":
        return WorkoutIcons.other.value;
      default:
        return WorkoutIcons.unknown.value;
    }
  }
}

void main() {
  WorkoutIcons.cycling.value;
}
