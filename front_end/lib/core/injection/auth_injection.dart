import 'package:front_end/core/injection/injection.dart';
import 'package:front_end/features/onboarding/data/datasource/auth_local_datasource/login_local_datasource.dart';
import 'package:front_end/features/onboarding/data/datasource/remote_datasource/auth_remote_datasource.dart';
import 'package:front_end/features/onboarding/data/repository_impl/auth_repo_impl.dart';
import 'package:front_end/features/onboarding/domain/repository/auth_repo.dart';
import 'package:front_end/features/onboarding/domain/usecase/log_out_usecase.dart';
import 'package:front_end/features/onboarding/domain/usecase/login_usecase.dart';
import 'package:front_end/features/onboarding/domain/usecase/signUp_usecase.dart';
import 'package:front_end/features/onboarding/presentation/bloc/bloc/auth_bloc.dart';

class AuthInjection {
  init() {
    // Bloc
    sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(),sl()));

    // UseCase
    sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase(sl()));
    sl.registerLazySingleton(() => LogInUseCase(sl()));
    sl.registerLazySingleton(() => LogoutUsecase(repository: sl()));

    // Repository
    sl.registerLazySingleton<AuthRepository>(
        () => AuthRepoImpl(sl(), sl(), sl()));

    // Data Source
    sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(client: sl()));
    sl.registerLazySingleton<UserLogInLocalDataSource>(
        () => UserLogInLocalDataSourceImpl(sharedPreferences: sl()));
  }
}
