part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class LoginLoading extends AuthState {}

class Unauthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel user;
  final bool isFirstTime;
  const Authenticated({required this.user, this.isFirstTime = false});

  @override
  List<Object> get props => [user];
}

class RegisterLoading extends AuthState {}

class ResetPasswordLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object> get props => [message];
}
