part of 'setelan_bloc.dart';

abstract class SetelanEvent extends Equatable {
  const SetelanEvent();

  @override
  List<Object?> get props => [];
}

class SetelanChangePassword extends SetelanEvent {
  final String email;
  const SetelanChangePassword({required this.email});

  @override
  List<Object?> get props => [email];
}

class SetelanChangeEmail extends SetelanEvent {
  final String email;
  const SetelanChangeEmail({required this.email});

  @override
  List<Object?> get props => [email];
}

class SetelanChangeProfile extends SetelanEvent {
  final String uid;
  final String? name;
  final Uint8List? image;
  const SetelanChangeProfile({
    required this.uid,
    this.name,
    this.image,
  });

  @override
  List<Object?> get props => [uid, name, image];
}
