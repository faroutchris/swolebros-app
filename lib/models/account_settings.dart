import 'package:cloud_firestore/cloud_firestore.dart';

class AccountSettings {
  final bool isOnboarded;

  AccountSettings({required this.isOnboarded});

  factory AccountSettings.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return AccountSettings(isOnboarded: data?["isOnboarded"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "isOnboarded": isOnboarded,
    };
  }
}
