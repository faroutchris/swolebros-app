import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:swole_app/custom_exception.dart';
import 'package:swole_app/models/team.dart';
import 'package:swole_app/models/team_member.dart';
import 'package:swole_app/services/account_service.dart';
import 'package:swole_app/services/auth_service.dart';

class TeamsService {
  final CollectionReference<Team> _collection;

  final AccountService _accountService;

  final AuthService _authService;

  final FirebaseCrashlytics _crashlytics;

  TeamsService(this._collection, this._accountService, this._authService,
      this._crashlytics);

  CollectionReference<TeamMember> _makeTeamMemberCollectionRef(String docId) {
    return _collection.doc(docId).collection("members").withConverter(
        fromFirestore: TeamMember.fromJson,
        toFirestore: (TeamMember _teamMember, _) => _teamMember.toJson());
  }

  Future<DocumentSnapshot<Team>> getById(String id) {
    try {
      return _collection.doc(id).get();
    } catch (e, stack) {
      _crashlytics.recordError(e, stack);
      rethrow;
    }
  }

  dummy() async {
    var id = "12sTAxSXupa9vjkvMbkN";
    if (id != null) {
      var teamRef = _collection.doc(id);
      var memberRef = _makeTeamMemberCollectionRef(id);
      var accountRef = _accountService.collection.doc(_authService.user?.uid);
      var roleRef = _collection.firestore.collection("roles").doc("member");

      var account = await accountRef.get();
      var accountData = account.data();
      // new team
      if (accountData != null) {
        // delete from old team
        var oldteamRef = _makeTeamMemberCollectionRef(accountData.team!.id);
        oldteamRef
            .where("account", isEqualTo: accountRef)
            .get()
            .then((value) => value.docs.first.reference.delete());

        // add new team to account
        accountRef.set(accountData.copyWith(team: teamRef));
      }
      // add account to team
      memberRef.add(TeamMember(account: accountRef, role: roleRef));
    }
  }

  Future<List<Team>> getAll() async {
    try {
      var ref = await _collection.get();
      return ref.docs.map((e) => e.data()).toList();
    } catch (e, stack) {
      _crashlytics.recordError(e, stack);
      rethrow;
    }
  }

  Future<Team?>? getCurrentTeam() async {
    try {
      if (_authService.user?.uid != null) {
        var accountRef = await _accountService.getById(_authService.user?.uid);
        var teamId = accountRef.data()?.team?.id;
        if (teamId != null) {
          var teamRef = await getById(teamId);
          return teamRef.data();
        }
      }
      return null;
    } catch (e, stack) {
      _crashlytics.recordError(e, stack);
      rethrow;
    }
  }

  join(Team team) async {
    try {
      if (_authService.user?.uid != null && team.id != null) {
        var doc = _collection.doc(team.id);
      } else {
        throw const CustomException(
          message: "Unable to join group",
        );
      }
    } catch (e, stack) {
      _crashlytics.recordError(e, stack);
      rethrow;
    }
  }
}
