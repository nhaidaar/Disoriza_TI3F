import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/auth_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecase _authUsecase;
  AuthBloc(this._authUsecase) : super(AuthInitial()) {
    on<AuthCheckSession>((event, emit) async {
      try {
        final sessionExists = await _authUsecase.checkSession();
        sessionExists.fold(
          (error) => emit(Unauthenticated()),
          (success) => emit(Authenticated(user: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<AuthRegister>((event, emit) async {
      try {
        emit(AuthLoading());

        final account = await _authUsecase.register(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        account.fold(
          (error) => emit(AuthError(
            message: error.toString().replaceFirst(RegExp(r'^[A-Za-z]+Exception: '), '').trim(),
          )),
          (success) => emit(Authenticated(user: success, isFirstTime: true)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<AuthLogin>((event, emit) async {
      try {
        emit(AuthLoading());

        final session = await _authUsecase.login(
          email: event.email,
          password: event.password,
        );
        session.fold(
          (error) => emit(AuthError(
            message: error.toString().replaceFirst(RegExp(r'^[A-Za-z]+Exception: '), '').trim(),
          )),
          (success) => emit(Authenticated(user: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<AuthLogout>((event, emit) async {
      try {
        final logout = await _authUsecase.logout();
        logout.fold(
          (error) => emit(AuthError(
            message: error.toString().replaceFirst(RegExp(r'^[A-Za-z]+Exception: '), '').trim(),
          )),
          (success) => emit(Unauthenticated()),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<AuthResetPassword>((event, emit) async {
      try {
        emit(AuthLoading());

        final resetPassword = await _authUsecase.resetPassword(email: event.email);
        resetPassword.fold(
          (error) => emit(AuthError(
            message: error.toString().replaceFirst(RegExp(r'^[A-Za-z]+Exception: '), '').trim(),
          )),
          (success) => emit(AuthPasswordReseted()),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
