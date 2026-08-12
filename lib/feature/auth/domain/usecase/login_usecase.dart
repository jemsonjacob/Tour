// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';

class LoginUseCase extends UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) {
    return repository.loginWithEmail(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});
}
