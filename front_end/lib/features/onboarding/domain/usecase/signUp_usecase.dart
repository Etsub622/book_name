import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/onboarding/domain/entity/sign_up_entity.dart';
import 'package:front_end/features/onboarding/domain/repository/auth_repo.dart';

class SignUpUseCase implements UseCase<String, UseCaseParams> {
  final AuthRepository authRepository;
  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UseCaseParams params) async {
    return await authRepository.signUP(params.signUpEntity);
  }
}

class UseCaseParams {
  final SignUpEntity signUpEntity;
  UseCaseParams(this.signUpEntity);
}
