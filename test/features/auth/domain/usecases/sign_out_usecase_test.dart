import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/no_params.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';
import 'package:tokio_marine/features/auth/domain/usecases/sign_out_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late SignOutUseCase useCase;

  setUp(() {
    repository = MockAuthRepository();
    useCase = SignOutUseCase(repository);
  });

  test('deve chamar o método signOut do repositório', () async {
    when(() => repository.signOut()).thenAnswer((_) async => const Right(unit));
    await useCase(NoParams());

    verify(() => repository.signOut()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('deve retornar um Right(unit) quando o logout for bem-sucedido',
      () async {
    when(() => repository.signOut()).thenAnswer((_) async => const Right(unit));
    final result = await useCase(NoParams());

    expect(result, const Right(unit));
  });

  test('deve retonar um Left(Failure) quando o logout falhar', () async {
    final tfailure = Failure('Erro ao fazer logout');
    when(() => repository.signOut()).thenAnswer((_) async => Left(tfailure));
    final result = await useCase(NoParams());

    expect(result, Left(tfailure));
  });
}
