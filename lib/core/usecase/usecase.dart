// A classe base abstrata para os UseCases
import 'package:dartz/dartz.dart';
import 'package:tokio_marine/core/failures/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}