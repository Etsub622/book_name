import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class GetSingleBookUsecase extends UseCase<BookEntity, GetbookParms> {
  final BookRepository bookRepository;
  GetSingleBookUsecase(this.bookRepository);

  @override
  Future<Either<Failure, BookEntity>> call(param) async {
    return bookRepository.getSingleBook(param.id);
  }
}

class GetbookParms {
  final String id;
  GetbookParms(this.id);
}


class GetBookByCategoryUsecase extends UseCase<List<BookEntity>,BookCategoryParmas>{
  final BookRepository bookRepository;
  GetBookByCategoryUsecase(this.bookRepository);
  
  @override
  Future<Either<Failure,List<BookEntity> >> call(param) {
    return bookRepository.getBookByCategory(param.category);
}

}

class BookCategoryParmas{
  final String category;
  BookCategoryParmas(this.category);

}