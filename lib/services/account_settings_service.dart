import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:swole_app/models/account_settings.dart';
import 'package:swole_app/services/auth_service.dart';

class AccountSettingsService {
  final CollectionReference<AccountSettings> collection;

  final AuthService authService;

  AccountSettingsService(this.collection, this.authService);

  Stream<AccountSettings?> get stream {
    if (authService.user?.uid != null) {
      return collection
          .doc(authService.user?.uid)
          .snapshots()
          .map((doc) => doc.data());
    } else {
      return const Stream.empty();
    }
  }

  Future<void> initializeAccountSettings() async {
    if (authService.user?.uid != null) {
      var doc = collection.doc(authService.user?.uid);
      try {
        var ref = await doc.get();
        // Always returns an AccountSetting model even when the document does not exist
        if (ref.data()?.isOnboarded == null) {
          doc.set(AccountSettings(isOnboarded: false));
        }
      } catch (e) {
        // no handling
      }
    }
  }

  void toggleOnboarding() async {
    var doc = collection.doc(authService.user?.uid);
    try {
      var ref = await doc.get();
      var data = ref.data();
      if (data?.isOnboarded == false || data?.isOnboarded == null) {
        doc.set(AccountSettings(isOnboarded: true));
      } else {
        doc.set(AccountSettings(isOnboarded: false));
      }
    } catch (e) {
      // no handling
    }
  }
}
