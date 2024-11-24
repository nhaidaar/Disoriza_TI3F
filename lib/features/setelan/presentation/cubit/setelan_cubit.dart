import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/auth_usecase.dart';

part 'setelan_state.dart';

class SetelanCubit extends Cubit<SetelanState> {
  final AuthUsecase _authUsecase;
  SetelanCubit(this._authUsecase) : super(SetelanInitial());

  Future<void> editProfile({
    required String uid,
    String? name,
    Uint8List? image,
  }) async {
    try {
      emit(SetelanLoading());

      final result = await _authUsecase.editProfile(
        uid: uid,
        name: name,
        image: image,
      );
      result.fold(
        (error) => emit(SetelanError(message: error.toString())),
        (success) => emit(SetelanSuccess(userModel: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      emit(SetelanLoading());

      final resetPassword = await _authUsecase.resetPassword(email: email);
      resetPassword.fold(
        (error) => emit(SetelanError(message: error.toString())),
        (success) => emit(ResetPasswordSuccess()),
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<void> changeEmail({required String email}) async {
    try {
      emit(SetelanLoading());

      final changeEmail = await _authUsecase.changeEmail(email: email);
      changeEmail.fold(
        (error) => emit(SetelanError(message: error.toString())),
        (success) => emit(ChangeEmailSuccess()),
      );
    } catch (_) {
      rethrow;
    }
  }
}
