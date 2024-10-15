import 'package:front_end/core/injection/injection.dart';
import 'package:front_end/features/book/data/datasource/local_datasource/get_books_local_datasource.dart';
import 'package:front_end/features/book/data/datasource/remote_datasource/book_remote_source.dart';
import 'package:front_end/features/book/data/repository/book_repo_impl.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';
import 'package:front_end/features/book/domain/usecase/book_list_usecase.dart';
import 'package:front_end/features/book/domain/usecase/book_usecase.dart';
import 'package:front_end/features/book/domain/usecase/delete_book_usecase.dart';
import 'package:front_end/features/book/domain/usecase/get_single_book_usecase.dart';
import 'package:front_end/features/book/domain/usecase/search_usecase.dart';
import 'package:front_end/features/book/domain/usecase/update_usecase.dart';
import 'package:front_end/features/book/presentation/bloc/bloc/book_bloc.dart';

class BookInjection {
  init() {
    // Bloc
    sl.registerFactory<BookBloc>(() => BookBloc(sl(), sl(), sl(), sl(),sl(),sl(),sl()));

    // UseCase
    sl.registerLazySingleton<GetAllBooksUsecase>(
        () => GetAllBooksUsecase(sl()));
     sl.registerLazySingleton<UpdateBookUsecase>(
        () => UpdateBookUsecase(sl()));    
    sl.registerLazySingleton<GetBookByCategoryUsecase>(
        () => GetBookByCategoryUsecase(sl()));
        
    sl.registerLazySingleton<BookUseCase>(() => BookUseCase(sl()));
    sl.registerLazySingleton<SearchUsecase>(() => SearchUsecase(sl()));
    sl.registerLazySingleton<GetSingleBookUsecase>(
        () => GetSingleBookUsecase(sl()));
    sl.registerLazySingleton<DeleteBookUsecase>(() => DeleteBookUsecase(sl()));

    // Repository
    sl.registerLazySingleton<BookRepository>(
        () => BookRepoImpl(sl(), sl(), sl(),));

    // Data Source

    sl.registerLazySingleton<GetBooksLocalDataSource>(
        () => GetBooksLocalDataSourceImpl(sl()));
    sl.registerLazySingleton<BookRemoteDataSource>(() => BookRemoteImpl(sl()));
  }
}
