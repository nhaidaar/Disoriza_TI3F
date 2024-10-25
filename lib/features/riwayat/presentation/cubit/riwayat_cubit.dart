import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'riwayat_state.dart';

class RiwayatCubit extends Cubit<RiwayatState> {
  RiwayatCubit() : super(RiwayatInitial());
}
