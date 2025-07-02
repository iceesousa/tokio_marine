import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/usecase.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase implements UseCase<UserEntity, SignInParams> {
  final IAuthRepository authRepository;

  SignInUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(SignInParams params) {
    return authRepository.signInWithCpfAndPassword(
      params.cpf,
      params.password,
    );
  }
}

class SignInParams extends Equatable {
  final String cpf;
  final String password;

  const SignInParams({
    required this.cpf,
    required this.password,
  });

  @override
  List<Object?> get props => [cpf, password];
}
