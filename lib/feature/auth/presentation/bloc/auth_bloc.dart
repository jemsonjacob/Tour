import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tourexplorer/feature/auth/domain/entities/user.dart';
import 'package:tourexplorer/feature/auth/domain/repository/auth_repository.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/login_usecase.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/logout_usecase.dart';
import 'package:tourexplorer/feature/auth/domain/usecase/signup_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUseCase _signUpUseCase;
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final AuthRepository _authRepository;

  AuthBloc({
    required this._signUpUseCase,
    required this._loginUseCase,
    required this._logoutUseCase,
    required this._authRepository,
  }) : super(AuthInitial()) {
    //singup event
    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());

      final response = await _signUpUseCase(
        SignUpParams(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );

      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    //loginn event
    on<AuthLoginEvent>((event, emit) async {
      emit(AuthLoading());

      final response = await _loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );

      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (user) => emit(AuthSuccess(user: user)),
      );
    });

    //auth check
    on<AuthCheckEvent>((event, emit) {
      final user = _authRepository.getCurrentUser();

      if (user != null) {
        emit(AuthSuccess(user: user));
      } else {
        emit(AuthLoggedOut());
      }
    });
    //logout event
    on<AuthLogoutEvent>((event, emit) async {
      emit(AuthLoading());

      final response = await _logoutUseCase(const NoParams());

      response.fold(
        (failure) => emit(AuthFailure(message: failure.message)),
        (_) => emit(AuthLoggedOut()),
      );
    });
  }
}
