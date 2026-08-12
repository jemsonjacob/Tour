// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:tourexplorer/core/failures/failures.dart';
import 'package:tourexplorer/core/usecase/usecase.dart';
import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';

class SignUpUseCase extends UseCase<UserEntity, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(SignUpParams params) {
    return repository.signUpWithEmail(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

class SignUpParams {
  final String email;
  final String password;
  final String name;

  const SignUpParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
