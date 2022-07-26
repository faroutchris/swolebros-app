import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:swole_app/models/account.dart';
import 'package:swole_app/services/auth_service.dart';

class AccountService {
  final CollectionReference<Account> _collection;

  final AuthService _authService;

  AccountService(this._collection, this._authService);

  CollectionReference<Account> get collection {
    return _collection;
  }

  Stream<Account?> get $account {
    if (_authService.user?.uid != null) {
      return _collection
          .doc(_authService.user?.uid)
          .snapshots()
          .map((doc) => doc.data());
    } else {
      return const Stream.empty();
    }
  }

  Future<DocumentSnapshot<Account?>> getById(id) async {
    try {
      return _collection.doc(id).get();
    } catch (e, stack) {
      // todo, use provider
      FirebaseCrashlytics.instance.recordError(e, stack);
      rethrow;
    }
  }

  Future<void> initializeAccount() async {
    if (_authService.user?.uid != null) {
      var doc = _collection.doc(_authService.user?.uid);
      try {
        var ref = await doc.get();
        // Always returns an AccountSetting model even when the document does not exist
        // if (ref.data()?.isOnboarded == null) {
        //   doc.set(Account(isOnboarded: false, team: null));
        // }
      } catch (e, stack) {
        // todo, use provider
        FirebaseCrashlytics.instance.recordError(e, stack);
        rethrow;
      }
    }
  }

  void toggleOnboarding() async {
    try {
      var doc = _collection.doc(_authService.user?.uid);
      var ref = await doc.get();
      var data = ref.data();
      if (data != null) {
        if (data.isOnboarded == false || data.isOnboarded == null) {
          doc.set(data.copyWith(isOnboarded: true));
        } else {
          doc.set(data.copyWith(isOnboarded: false));
        }
      }
    } catch (e, stack) {
      // todo, use provider
      FirebaseCrashlytics.instance.recordError(e, stack);
      rethrow;
    }
  }

  void setTeam(DocumentReference<Map<String, dynamic>> team) async {
    try {
      var doc = _collection.doc(_authService.user?.uid);
      var ref = await doc.get();
      var data = ref.data();
      if (data != null) {
        // doc.set(data.copyWith(team: team));
      }
    } catch (e, stack) {
      // todo, use provider
      FirebaseCrashlytics.instance.recordError(e, stack);
      rethrow;
    }
  }
}
