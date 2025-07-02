part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthGetCurrentUserEvent extends AuthEvent {}


class AuthSignInEvent extends AuthEvent {
  final String cpf;
  final String password;

  AuthSignInEvent({required this.cpf, required this.password});
}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  final String cpf;
  final String name;

  AuthSignUpEvent({
    required this.email,
    required this.password,
    required this.cpf,
    required this.name,
  });
}

class AuthSignOutEvent extends AuthEvent {
  AuthSignOutEvent();
}
