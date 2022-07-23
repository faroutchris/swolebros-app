import 'package:cloud_firestore/cloud_firestore.dart';

class Team {
  final String? name;
  final List<TeamMember>? members;

  Team({this.members, this.name});

  factory Team.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

    return Team(
      name: data?["name"],
      members: data != null && data.containsKey("members")
          ? (data["members"] as List<dynamic>)
              .map((member) => TeamMember.fromJson(member, options))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "name": name,
      if (members != null) "members": members?.map((member) => member.toJson()),
    };
  }

  Team copyWith({
    String? name,
    List<TeamMember>? members,
  }) {
    return Team(
      name: name ?? this.name,
      members: members ?? this.members,
    );
  }
}

class TeamMember {
  final DocumentReference<Map<String, dynamic>>? account;
  final DocumentReference<Map<String, dynamic>>? role;

  TeamMember({this.account, this.role});

  factory TeamMember.fromJson(
    data,
    SnapshotOptions? options,
  ) {
    return TeamMember(
      role: data?["role"],
      account: data?["account"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (role != null) "role": role,
      if (account != null) "account": account,
    };
  }

  TeamMember copyWith({
    DocumentReference<Map<String, dynamic>>? account,
    DocumentReference<Map<String, dynamic>>? role,
  }) {
    return TeamMember(
      role: role ?? this.role,
      account: account ?? this.account,
    );
  }
}
