import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tokio_marine/core/exceptions/exceptions.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final IAuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } catch (e) {
      return Left(ServerFailure('Erro ao pegar usuário: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> resetPassword(String email) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(unit);
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } catch (e) {
      return Left(ServerFailure('Erro ao fazer logout: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> signUpWithEmailAndPassword(
      {required String email,
      required String password,
      required String cpf,
      required String name}) async {
    try {
      await remoteDataSource.registerUser(
        email: email,
        password: password,
        cpf: cpf,
        name: name,
      );

      return const Right(unit);
    } on FirebaseAuthException catch (e) {
      return Left(CreateUserWithEmailAndPasswordFailure.fromCode(e.code));
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } catch (e) {
      return Left(ServerFailure('Erro ao cadastrar usuário: $e'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInWithCpfAndPassword(
      String cpf, String password) async {
    try {
      final user = await remoteDataSource.signInWithCpfAndPassword(
        cpf: cpf,
        password: password,
      );
      return Right(user);
    } on FirebaseAuthException catch (e) {
      return Left(SignInWithEmailAndPasswordFailure.fromCode(e.code));
    } on NoInternetConnectionException {
      return Left(NoInternetConnectionFailure());
    } on UserNotFoundException {
      return Left(UserNotFoundFailure());
    } catch (e) {
      return Left(ServerFailure('Erro ao fazer login: $e'));
    }
  }
}
