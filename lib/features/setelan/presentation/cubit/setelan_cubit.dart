import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/domain/usecases/auth_usecase.dart';

part 'setelan_state.dart';

class SetelanCubit extends Cubit<SetelanState> {
  final AuthUsecase _authUsecase;
  SetelanCubit(this._authUsecase) : super(SetelanInitial());
}
