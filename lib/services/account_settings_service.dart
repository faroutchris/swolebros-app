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
      await collection
          .doc(authService.user?.uid)
          .set(AccountSettings(isOnboarded: false));
    }
  }

  void toggleOnboarding() async {
    var doc = collection.doc(authService.user?.uid);
    doc.get().then((value) {
      var data = value.data();
      if (data != null) {
        doc.set(AccountSettings(isOnboarded: !data.isOnboarded));
      }
    });
  }
}
