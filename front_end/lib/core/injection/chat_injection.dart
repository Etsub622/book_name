import 'package:front_end/core/injection/injection.dart';
import 'package:front_end/features/chat/data/datasource/remote_datasource/chat_remote_datasource.dart';
import 'package:front_end/features/chat/data/repo_impl/chat_repo_impl.dart';
import 'package:front_end/features/chat/domain/repository/chat_repo.dart';
import 'package:front_end/features/chat/domain/usecase/chat_usecase.dart';
import 'package:front_end/features/chat/presentation/bloc/bloc/chat_bloc.dart';


class ChatInjection {
  init() {
    // Bloc
    sl.registerFactory<ChatBloc>(() => ChatBloc(sl()));

    // UseCase
    sl.registerLazySingleton<ChatInitiateUsecase>(() => ChatInitiateUsecase(sl()));

    // Repository
    sl.registerLazySingleton<ChatInitiateRepo>(() => ChatInitiateRepoImpl(sl(), sl()));

    // Data Source
    sl.registerLazySingleton<ChatRemoteDataSource>(() => ChatRemoteDataSourceImpl(sl()));
  }
}
