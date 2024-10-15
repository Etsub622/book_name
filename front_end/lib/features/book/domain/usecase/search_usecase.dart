import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class SearchUsecase implements UseCase<List<BookEntity>, SearchParams> {
  final BookRepository repository;
  SearchUsecase(this.repository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(SearchParams params) async {
    return await repository.search(params.title);
  }
}

class SearchParams {
  final String title;
  SearchParams(this.title);
}
