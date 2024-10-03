import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/network/network.dart';
import 'package:front_end/features/onboarding/data/datasource/auth_local_datasource/login_local_datasource.dart';
import 'package:front_end/features/onboarding/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:front_end/features/onboarding/data/models/auth_model.dart';
import 'package:front_end/features/onboarding/domain/entity/log_in_entity.dart';
import 'package:front_end/features/onboarding/domain/entity/sign_up_entity.dart';
import 'package:front_end/features/onboarding/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  final UserLogInLocalDataSource localDataSource;
  AuthRepoImpl(
      this.authRemoteDataSource, this.networkInfo, this.localDataSource);

  @override
  Future<Either<Failure, String>> signUP(SignUpEntity signup) async {
    if (await networkInfo.isConnected) {
      try {
        final user = SignUPModel(
            id: signup.id,
            name: signup.name,
            email: signup.email,
            password: signup.password);

        final res = await authRemoteDataSource.signUp(user);
        print(res);
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'You are not connected to the internet'));
    }
  }

  @override
  Future<Either<Failure, String>> login(LogInEntity logIn) async {
    if (await networkInfo.isConnected) {
      try {
        final user = LogInModel(
            id: logIn.id, email: logIn.email, password: logIn.password);
        final token = await authRemoteDataSource.logIn(user);
        await localDataSource.cacheToken(token);
      
        return Right(token);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'You are not connected to the internet'));
    }
  }

  @override
  Future<Either<Failure, SignUPModel>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final userDataModel = await localDataSource.getUser();
        return Right(userDataModel!);
      } on ServerException {
        return Left(ServerFailure(message: 'Server failure'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'you are not connected to the internet'));
    }
  }

  @override
  Future<Either<Failure, String>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        await localDataSource.deleteUser();

        return const Right('Successfully logged out');
      } on ServerException {
        return Left(ServerFailure(message: 'Server failure'));
      } on CacheFailure {
        return Left(CacheFailure(message: 'Cache failure'));
      }
    } else {
      return Left(
          NetworkFailure(message: 'You are not connected to the internet.'));
    }
  }
}
