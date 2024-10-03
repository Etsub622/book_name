import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/features/onboarding/data/models/auth_model.dart';
import 'package:front_end/features/onboarding/domain/entity/log_in_entity.dart';
import 'package:front_end/features/onboarding/domain/entity/sign_up_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUP(SignUpEntity signup);
  Future<Either<Failure, String>> login(LogInEntity logIn);
  Future<Either<Failure, SignUPModel>> getUser();
  Future<Either<Failure,String>> logOut();
  
}
