import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String? name;
  final Object? memberships;

  Team({this.memberships, this.name});

  factory Team.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Team(
        name: data?["name"],
        memberships: Memberships(snapshot.reference.collection("memberships")));
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (memberships != null) "memberships": memberships,
    };
  }

  Team copyWith({
    String? name,
    String? memberships,
  }) {
    return Team(
      name: name ?? this.name,
      memberships: memberships ?? this.memberships,
    );
  }
}

class Memberships {
  late Iterable<Map<String, dynamic>> members;

  Memberships(CollectionReference<Map<String, dynamic>> cursor) {
    cursor.get().then((value) {
      members = value.docs.map((element) {
        return element.data();
      });
    });
  }

  @override
  String toString() {
    // TODO: implement toString
    return members.toString();
  }
}
