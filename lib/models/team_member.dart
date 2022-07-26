import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/account.dart';

class TeamMember {
  final DocumentReference? account;
  final DocumentReference? role;

  TeamMember({this.account, this.role});

  factory TeamMember.fromJson(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();

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
    DocumentReference? account,
    DocumentReference? role,
  }) {
    return TeamMember(
      role: role ?? this.role,
      account: account ?? this.account,
    );
  }
}
