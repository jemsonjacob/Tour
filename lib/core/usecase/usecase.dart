import 'package:dartz/dartz.dart';
import 'package:tourexplorer/core/failures/failures.dart';

// ignore: avoid_types_as_parameter_names
abstract class UseCase<Type, Params> {
  //type is generic
  //It takes some Params.It returns a Future<Either<Failure, Type>>
  Future<Either<Failure, Type>> call(Params params);
}
