import 'package:firebase_auth/firebase_auth.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.name,
    super.photoUrl,
  });

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      uid: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      photoUrl: user.photoURL,
    );
  }
}
