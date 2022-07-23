import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:swole_app/models/team.dart';
import 'package:swole_app/services/account_service.dart';
import 'package:swole_app/services/auth_service.dart';

class TeamsService {
  final CollectionReference<Team> _collection;

  final AccountService _accountService;

  final AuthService _authService;

  final FirebaseCrashlytics _crashlytics;

  TeamsService(this._collection, this._accountService, this._authService,
      this._crashlytics);

  Future<DocumentSnapshot<Team>> getById(String id) {
    try {
      return _collection.doc(id).get();
    } catch (e, stack) {
      _crashlytics.recordError(e, stack);
      rethrow;
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
}
