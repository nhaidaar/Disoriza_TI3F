part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckSession extends AuthEvent {}

class AuthRegister extends AuthEvent {
  final String name;
  final String email;
  final String password;
  const AuthRegister({
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  List<Object?> get props => [name, email, password];
}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  final bool isFirstTime;
  const AuthLogin({
    required this.email,
    required this.password,
    this.isFirstTime = false,
  });

  @override
  List<Object?> get props => [email, password, isFirstTime];
}

class AuthLogout extends AuthEvent {}

class AuthResetPassword extends AuthEvent {
  final String email;
  const AuthResetPassword({required this.email});

  @override
  List<Object?> get props => [email];
}
