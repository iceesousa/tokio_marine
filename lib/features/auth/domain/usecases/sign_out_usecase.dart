import 'package:dartz/dartz.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/no_params.dart';
import 'package:tokio_marine/core/usecase/usecase.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase implements UseCase<Unit, NoParams> {
  final IAuthRepository authRepository;

  SignOutUseCase(this.authRepository);

  @override
  Future<Either<Failure, Unit>> call(params) {
    return authRepository.signOut();
  }
}
