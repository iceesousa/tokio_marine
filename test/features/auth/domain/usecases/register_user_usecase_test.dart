import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';
import 'package:tokio_marine/features/auth/domain/usecases/register_user_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late RegisterUserUsecase usecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    usecase = RegisterUserUsecase(mockAuthRepository);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  const tCpf = '12345678901';
  const tName = 'Erysson Sousa';
  const tParams = RegisterUserParams(
    email: tEmail,
    password: tPassword,
    cpf: tCpf,
    name: tName,
  );

  test(
      'deve chamar signUpWithEmailAndPassword no repositório com os parâmetros corretos',
      () async {
    when(() => mockAuthRepository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        cpf: tCpf,
        name: tName)).thenAnswer((_) async => const Right(unit));

    await usecase(tParams);

    verify(() => mockAuthRepository.signUpWithEmailAndPassword(
          email: tEmail,
          password: tPassword,
          cpf: tCpf,
          name: tName,
        )).called(1);
    verifyNoMoreInteractions(mockAuthRepository);
  });

  test('deve retornar Right(unit) quando o registro for bem-sucedido',
      () async {
    when(() => mockAuthRepository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        cpf: tCpf,
        name: tName)).thenAnswer((_) async => const Right(unit));

    final result = await usecase(tParams);

    expect(result, const Right(unit));
  });

  test('deve retornar um Left(Failure) quando o registro falhar', () async {
    final tFailure = ServerFailure('Erro ao registrar usuário');
    when(() => mockAuthRepository.signUpWithEmailAndPassword(
        email: tEmail,
        password: tPassword,
        cpf: tCpf,
        name: tName)).thenAnswer((_) async => Left(tFailure));

    final result = await usecase(tParams);

    expect(result, Left(tFailure));
  });
}
