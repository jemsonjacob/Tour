// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourexplorer/core/exceptions/exceptions.dart';

abstract class AuthRemoteDataSource {
  Future<User> loginWithEmail({
    required String email,
    required String password,
  });

  Future<User> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  });

  Future<void> logout();

  User? getCurrentUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  AuthRemoteDatasourceImpl({required this.firebaseAuth});

  @override
  Future<User> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return credential.user!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(handleAuthException(e));
    }
  }

  @override
  Future<User> signUpWithEmail({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user!;

      await user.updateDisplayName(name);
      await user.reload();

      return firebaseAuth.currentUser!;
    } on FirebaseAuthException catch (e) {
      throw ServerException(handleAuthException(e));
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw ServerException(handleAuthException(e));
    }
  }

  @override
  User? getCurrentUser() {
    return firebaseAuth.currentUser;
  }
}
