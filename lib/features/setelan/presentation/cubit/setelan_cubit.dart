import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../auth/domain/usecases/auth_usecase.dart';

part 'setelan_state.dart';

class SetelanCubit extends Cubit<SetelanState> {
  final AuthUsecase _authUsecase;
  SetelanCubit(this._authUsecase) : super(SetelanInitial());


  Future<void> editUser({
    required String uid,
    String? name,
    String? email,
  }) async {
    emit(SetelanLoading());
    final result = await _authUsecase.edit(uid: uid, name: name, email: email);
    result.fold(
      (error) => emit(SetelanError(message: error.toString())),
      (success) => emit(SetelanSuccess(userModel: success)),
    );
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
}
