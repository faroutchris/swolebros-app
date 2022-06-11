import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:swole_app/services/auth_service.dart';

final firebaseAuthProvider = Provider((ref) => FirebaseAuth.instance);

final authServiceProvider =
    Provider((ref) => AuthService(ref.read(firebaseAuthProvider)));
