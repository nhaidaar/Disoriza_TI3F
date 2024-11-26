part of 'setelan_bloc.dart';

abstract class SetelanState extends Equatable {
  const SetelanState();

  @override
  List<Object> get props => [];
}

class SetelanInitial extends SetelanState {}

class SetelanLoading extends SetelanState {}

class SetelanError extends SetelanState {
  final String message;
  const SetelanError({required this.message});

  @override
  List<Object> get props => [message];
}

class SetelanPasswordChanged extends SetelanState {}

class SetelanEmailChanged extends SetelanState {}

class SetelanProfileChanged extends SetelanState {
  final UserModel userModel;
  const SetelanProfileChanged({required this.userModel});

  @override
  List<Object> get props => [userModel];
}
