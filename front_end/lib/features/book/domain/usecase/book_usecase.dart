import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class BookUseCase extends UseCase<String, BookParams> {
  final BookRepository bookRepository;
  BookUseCase(this.bookRepository);

  @override
  Future<Either<Failure, String>> call(BookParams param) async {
    return await bookRepository.addBooks(param.books);
  }
}

class BookParams {
  final BookEntity books;
  BookParams(this.books);
}
