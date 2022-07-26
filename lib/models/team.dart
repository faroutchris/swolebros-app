import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String? id;
  final String? name;

  Team({this.id, this.name});

  factory Team.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Team(
      id: snapshot.id,
      name: data?["name"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      if (name != null) "name": name,
    };
  }

  Team copyWith({
    String? name,
  }) {
    return Team(
      id: id,
      name: name ?? this.name,
    );
  }
}
