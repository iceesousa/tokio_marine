
import 'package:dartz/dartz.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/no_params.dart';
import 'package:tokio_marine/core/usecase/usecase.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase implements UseCase<UserEntity, NoParams> {
  final IAuthRepository authRepository;

  GetCurrentUserUsecase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return authRepository.getCurrentUser();
  }
}
