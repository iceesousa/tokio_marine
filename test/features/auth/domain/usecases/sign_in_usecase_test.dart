import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_in_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late SignInUsecase usecase;

  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = SignInUsecase(mockAuthRepository);
  });

  const tCpf = '12345678901';
  const tPassword = 'password123';
  const tParams = SignInParams(cpf: tCpf, password: tPassword);

  test(
      'deve chamar signInWithCpfAndPassword no repositório com os parâmetros corretos',
      () async {
    when(() => mockAuthRepository.signInWithCpfAndPassword(
              tCpf,
              tPassword,
            ))
        .thenAnswer((_) async => Right(UserEntity(
            id: '1',
            name: 'Test User',
            email: 'erysson@sousa.com',
            cpf: tCpf)));

    await usecase(tParams);

    verify(() => mockAuthRepository.signInWithCpfAndPassword(
          tCpf,
          tPassword,
        )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('deve retornar um UserEntity quando o login for bem-sucedido', () async {
    when(() => mockAuthRepository.signInWithCpfAndPassword(
              tCpf,
              tPassword,
            ))
        .thenAnswer((_) async => Right(UserEntity(
            id: '1',
            name: 'Test User',
            email: 'erysson@sousa.com',
            cpf: tCpf)));

    final result = await usecase(tParams);

    expect(result, isA<Right<Failure, UserEntity>>());
    expect(result.getOrElse(() => throw Exception('Erro inesperado')),
        isA<UserEntity>());
  });

  test('deve retornar um Failure quando o login falhar', () async {
    // Arrange
    when(() => mockAuthRepository.signInWithCpfAndPassword(tCpf, tPassword))
        .thenAnswer((_) async => Left(ServerFailure('Erro ao fazer login')));

    // Act
    final result = await usecase(tParams);

    // Assert
    result.fold(
      (failure) => expect(failure, isA<ServerFailure>()), 
      (success) => fail(
          'O caso de uso deveria ter retornado um Failure'), 
    );
  });
}
