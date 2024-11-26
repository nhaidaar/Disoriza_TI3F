import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/auth_usecase.dart';

part 'setelan_event.dart';
part 'setelan_state.dart';

class SetelanBloc extends Bloc<SetelanEvent, SetelanState> {
  final AuthUsecase _authUsecase;

  SetelanBloc(this._authUsecase) : super(SetelanInitial()) {
    on<SetelanChangePassword>((event, emit) async {
      try {
        emit(SetelanLoading());

        final resetPassword = await _authUsecase.resetPassword(email: event.email);
        resetPassword.fold(
          (error) => emit(SetelanError(message: error.toString())),
          (success) => emit(SetelanPasswordChanged()),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<SetelanChangeEmail>((event, emit) async {
      try {
        emit(SetelanLoading());

        final changeEmail = await _authUsecase.changeEmail(email: event.email);
        changeEmail.fold(
          (error) => emit(SetelanError(message: error.toString())),
          (success) => emit(SetelanEmailChanged()),
        );
      } catch (_) {
        rethrow;
      }
    });
    on<SetelanChangeProfile>((event, emit) async {
      try {
        emit(SetelanLoading());

        final result = await _authUsecase.editProfile(
          uid: event.uid,
          name: event.name,
          image: event.image,
        );
        result.fold(
          (error) => emit(SetelanError(message: error.toString())),
          (success) => emit(SetelanProfileChanged(userModel: success)),
        );
      } catch (_) {
        rethrow;
      }
    });
  }
}
