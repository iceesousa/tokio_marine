import 'package:dartz/dartz.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/usecase.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';

class RegisterUserUsecase implements UseCase<Unit, RegisterUserParams> {
  final IAuthRepository authRepository;

  RegisterUserUsecase(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(RegisterUserParams params) async {
    return await authRepository.signUpWithEmailAndPassword(
      email: params.email,
      password: params.password,
      cpf: params.cpf,
      name: params.name,
    );
  }
}

class RegisterUserParams {
  final String email;
  final String password;
  final String cpf;
  final String name;

  const RegisterUserParams({
    required this.email,
    required this.password,
    required this.cpf,
    required this.name,
  });
}
