import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);

  Stream<User?> get userStream => _firebaseAuth.authStateChanges();

  User? get user => _firebaseAuth.currentUser;

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<UserCredential> signIn() async {
    return await _firebaseAuth.signInAnonymously();
  }
}
