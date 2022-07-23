import 'package:cloud_firestore/cloud_firestore.dart';

class Account {
  final bool? isOnboarded;
  final DocumentReference<Map<String, dynamic>>? team;

  Account({required this.isOnboarded, this.team});

  factory Account.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Account(isOnboarded: data?["isOnboarded"], team: data?["team"]);
  }

  Map<String, dynamic> toJson() {
    return {
      if (isOnboarded != null) "isOnboarded": isOnboarded,
      if (team != null) "team": team,
    };
  }

  Account copyWith({
    bool? isOnboarded,
    DocumentReference<Map<String, dynamic>>? team,
  }) {
    return Account(
      isOnboarded: isOnboarded ?? this.isOnboarded,
      team: team ?? this.team,
    );
  }
}
