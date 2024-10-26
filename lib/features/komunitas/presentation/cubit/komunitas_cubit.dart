import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'komunitas_state.dart';

class KomunitasCubit extends Cubit<KomunitasState> {
  KomunitasCubit() : super(KomunitasInitial());
}
