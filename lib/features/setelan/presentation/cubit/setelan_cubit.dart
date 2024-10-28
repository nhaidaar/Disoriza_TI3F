import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'setelan_state.dart';

class SetelanCubit extends Cubit<SetelanState> {
  SetelanCubit() : super(SetelanInitial());
}
