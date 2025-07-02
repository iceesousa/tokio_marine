import 'package:dartz/dartz.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<Failure, UserEntity>> signInWithCpfAndPassword(
    String cpf,
    String password,
  );
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String cpf,
      required String name});
  Future<Either<Failure, Unit>> signOut();
  Future<Either<Failure, UserEntity>> getCurrentUser();
  Future<Either<Failure, Unit>> resetPassword(String email);
}
