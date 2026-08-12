import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  UserEntity? call() {
    return repository.getCurrentUser();
  }
}
