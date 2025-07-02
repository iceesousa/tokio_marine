import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tokio_marine/core/failures/failures.dart';
import 'package:tokio_marine/core/usecase/no_params.dart';
import 'package:tokio_marine/features/auth/domain/entities/user_entity.dart';
import 'package:tokio_marine/features/auth/domain/repositories/auth_repository.dart';
import 'package:tokio_marine/features/auth/domain/usecases/get_current_user_usecase.dart';

class MockAuthRepository extends Mock implements IAuthRepository {}

void main() {
  late MockAuthRepository repository;
  late GetCurrentUserUsecase useCase;

  final tUserEntity = UserEntity(
      name: 'Erysson Sousa',
      email: 'erysson.sousa@email.com',
      id: '1',
      cpf: '12345678901');
  final tFailure = Failure('Erro no servidor ao buscar usuário.');

  setUp(() {
    repository = MockAuthRepository();
    useCase = GetCurrentUserUsecase(repository);
  });

  test('deve chamar o método getCurrentUser do repositório', () async {
    when(() => repository.getCurrentUser())
        .thenAnswer((_) async => Right(tUserEntity));

    await useCase(NoParams());

    verify(() => repository.getCurrentUser()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('deve retornar um Right(UserEntity) quando a chamada for bem-sucedida',
      () async {
    when(() => repository.getCurrentUser())
        .thenAnswer((_) async => Right(tUserEntity));

    final result = await useCase(NoParams());

    expect(result, Right(tUserEntity));
  });

  test('deve retornar um Left(Failure) quando a chamada ao repositório falhar',
      () async {
    when(() => repository.getCurrentUser())
        .thenAnswer((_) async => Left(tFailure));

    final result = await useCase(NoParams());

    expect(result, Left(tFailure));
  });
}
