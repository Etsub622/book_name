import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call( Params param);
}

class NoParams {
  NoParams();
}
