import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class GetAllBooksUsecase extends UseCase<List<BookEntity>, NoParams> {
  final BookRepository bookRepository;
  GetAllBooksUsecase(this.bookRepository);

  @override
  Future<Either<Failure, List<BookEntity>>> call(NoParams param) async {
    return bookRepository.getBooks();
  }
}


