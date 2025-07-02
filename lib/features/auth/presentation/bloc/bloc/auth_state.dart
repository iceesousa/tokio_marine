part of 'auth_bloc.dart';

///Tambem poderia usar a enums para controle de status e estados, juntando todos status em um unico lugar
@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoadingState extends AuthState {}

final class AuthRegisterSuccessState extends AuthState {}

final class AuthLoginSuccessState extends AuthState {
  final UserEntity user;

  AuthLoginSuccessState({required this.user});
}

final class AuthSignOutSuccessState extends AuthState {}

final class AuthNoCurrentUserState extends AuthState {
  final String message;

  AuthNoCurrentUserState(this.message);
}

final class AuthErrorState extends AuthState {
  final String message;

  AuthErrorState(this.message);
}
