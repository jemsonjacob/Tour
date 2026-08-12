import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logout();

  UserEntity? getCurrentUser();
}
