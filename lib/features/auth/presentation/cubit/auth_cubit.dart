import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:disoriza/features/auth/domain/usecases/auth_usecase.dart';

import '../../data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase _authUsecase;
  AuthCubit(this._authUsecase) : super(AuthInitial());

  Future<void> checkSession() async {
    try {
      final sessionExists = await _authUsecase.checkSession();
      sessionExists.fold(
        (error) => emit(Unauthenticated()),
        (success) => emit(Authenticated(user: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      emit(RegisterLoading());

      final account = await _authUsecase.register(
        name: name,
        email: email,
        password: password,
      );
      account.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Authenticated(user: success, isFirstTime: true)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
    bool isFirstTime = false,
  }) async {
    try {
      emit(LoginLoading());

      final session = await _authUsecase.login(email: email, password: password);
      session.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Authenticated(user: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      emit(LogoutLoading());

      final logout = await _authUsecase.logout();
      logout.fold(
        (error) => emit(AuthError(message: error.toString())),
        (success) => emit(Unauthenticated()),
      );
    } catch (_) {
      rethrow;
    }
  }
}
