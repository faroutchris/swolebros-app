import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:swole_app/models/account.dart';
import 'package:swole_app/services/auth_service.dart';

class AccountService {
  final CollectionReference<Account> collection;

  final AuthService authService;

  AccountService(this.collection, this.authService);

  Stream<Account?> get $account {
    if (authService.user?.uid != null) {
      return collection
          .doc(authService.user?.uid)
          .snapshots()
          .map((doc) => doc.data());
    } else {
      return const Stream.empty();
    }
  }

  Future<void> initializeAccount() async {
    if (authService.user?.uid != null) {
      var doc = collection.doc(authService.user?.uid);
      try {
        var ref = await doc.get();
        // Always returns an AccountSetting model even when the document does not exist
        if (ref.data()?.isOnboarded == null) {
          doc.set(Account(isOnboarded: false, team: null));
        }
      } catch (e, stack) {
        FirebaseCrashlytics.instance.recordError(e, stack);
      }
    }
  }

  void toggleOnboarding() async {
    var doc = collection.doc(authService.user?.uid);
    try {
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
      FirebaseCrashlytics.instance.recordError(e, stack);
    }
  }
}
