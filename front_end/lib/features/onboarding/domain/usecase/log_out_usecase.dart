
import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/onboarding/domain/repository/auth_repo.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  LogoutUsecase({required this.repository});

  @override
  Future<Either<Failure, void>> call(NoParams param) async {
    return await repository.logOut();
  }
}

