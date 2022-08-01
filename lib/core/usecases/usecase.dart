import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_ecommerce/core/error/failure.dart';

// This will be used by the code calling the use case whenever the use case
// doesn't accept any parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}

class Params extends Equatable {
  const Params() : super();

  @override
  List<Object?> get props => [];
}

// Parameters have to be put into a container object so that they can be
// included in this abstract base class method definition.
abstract class UseCase<Type, T> {
  Future<Either<Failure, Type>> call(T params);
}
