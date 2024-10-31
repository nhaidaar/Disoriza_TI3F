import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/user_usecase.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserUsecase _userUsecase;
  UserCubit(this._userUsecase) : super(UserInitial());

  Future<void> fetchUserModel({required String uid}) async {
    if (isClosed) return;
    try {
      emit(UserLoading());
      final exists = await _userUsecase.fetchUserModel(uid: uid);
      exists.fold(
        (error) => emit(UserError(message: error.toString())),
        (success) => emit(UserFetched(userModel: success)),
      );
    } catch (_) {
      rethrow;
    }
  }

  // Future<void> checkEmailExists({required String email}) async {
  //   try {
  //     emit(UserLoading());
  //     final exists = await _userUsecase.checkEmailExists(email: email);
  //     exists.fold(
  //       (error) => emit(UserError(message: error.toString())),
  //       (success) => emit(EmailExists(isEmailExists: success)),
  //     );
  //   } catch (_) {
  //     rethrow;
  //   }
  // }
}
