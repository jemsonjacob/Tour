// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/exceptions/exceptions.dart';

import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:tourexplorer/feature/auth/data/model/user_model.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  UserEntity? getCurrentUser() {
    final user = remoteDataSource.getCurrentUser();

    if (user == null) {
      return null;
    }

    return UserModel.fromFirebaseUser(user);
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.loginWithEmail(
        email: email,
        password: password,
      );

      return right(UserModel.fromFirebaseUser(user));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final user = await remoteDataSource.signUpWithEmail(
        name: name,
        email: email,
        password: password,
      );

      return right(UserModel.fromFirebaseUser(user));
    } on ServerException catch (e) {
      return left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();

      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
