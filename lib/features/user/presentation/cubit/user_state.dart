part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;
  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserSuccess extends UserState {}

class UserFetched extends UserState {
  final UserModel userModel;
  const UserFetched({required this.userModel});

  @override
  List<Object> get props => [userModel];
}

// class EmailExists extends UserState {
//   final bool isEmailExists;
//   const EmailExists({required this.isEmailExists});

//   @override
//   List<Object> get props => [isEmailExists];
// }