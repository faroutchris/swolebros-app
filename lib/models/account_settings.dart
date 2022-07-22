import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSettings {
  final bool? isOnboarded;
  final DocumentReference<Map<String, dynamic>>? team;

  AccountSettings({required this.isOnboarded, this.team});

  factory AccountSettings.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AccountSettings(
        isOnboarded: data?["isOnboarded"], team: data?["team"]);
  }

  Map<String, dynamic> toJson() {
    return {
      if (isOnboarded != null) "isOnboarded": isOnboarded,
      if (team != null) "team": team,
    };
  }

  AccountSettings copyWith({
    bool? isOnboarded,
    DocumentReference<Map<String, dynamic>>? team,
  }) {
    return AccountSettings(
      isOnboarded: isOnboarded ?? this.isOnboarded,
      team: team ?? this.team,
    );
  }
}
