part of 'setelan_cubit.dart';

abstract class SetelanState extends Equatable {
  const SetelanState();

  @override
  List<Object> get props => [];
}

class SetelanInitial extends SetelanState {}

class SetelanLoading extends SetelanState {}

class SetelanSuccess extends SetelanState {}

class SetelanError extends SetelanState {
  final String message;
  const SetelanError({required this.message});

  @override
  List<Object> get props => [message];
}
