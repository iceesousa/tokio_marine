import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tokio_marine/core/usecase/no_params.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/register_user_usecase.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_out_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUserParams registerUserParams;
  final RegisterUserUsecase registerUserUsecase;
  final SignInUsecase signInUsecase;
  final SignOutUseCase signOutUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final SignInParams signInParams;
  AuthBloc(
      {required this.registerUserParams,
      required this.registerUserUsecase,
      required this.signInParams,
      required this.signInUsecase,
      required this.signOutUsecase,
      required this.getCurrentUserUsecase})
      : super(AuthInitial()) {
    on<AuthSignUpEvent>((event, emit) async {
      final params = RegisterUserParams(
        email: event.email,
        password: event.password,
        cpf: event.cpf,
        name: event.name,
      );
      final result = await registerUserUsecase.call(params);
      emit(result.fold(
        (failure) => AuthErrorState(failure.message),
        (_) => AuthRegisterSuccessState(),
      ));
    });

    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await signInUsecase
          .call(SignInParams(cpf: event.cpf, password: event.password));
      emit(result.fold(
        (failure) => AuthErrorState(failure.message),
        (user) => AuthLoginSuccessState(user: user),
      ));
    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await signOutUsecase.call(NoParams());
      emit(result.fold(
        (failure) => AuthErrorState(failure.message),
        (_) => AuthSignOutSuccessState(),
      ));
    });

    on<AuthGetCurrentUserEvent>((event, emit) async {
      emit(AuthLoadingState());
      final result = await getCurrentUserUsecase.call(NoParams());
      emit(result.fold(
        (failure) => AuthNoCurrentUserState(failure.message),
        (user) => AuthLoginSuccessState(user: user),
      ));
    });
  }
}
