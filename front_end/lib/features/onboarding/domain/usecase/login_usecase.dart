import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/onboarding/domain/entity/log_in_entity.dart';
import 'package:front_end/features/onboarding/domain/repository/auth_repo.dart';

class LogInUseCase implements UseCase<String, LogInParams> {
  final AuthRepository authRepository;
  LogInUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(LogInParams params) async {
    return await authRepository.login(params.login);
  }
}

class LogInParams {
  final LogInEntity login;
  LogInParams(this.login);
}
