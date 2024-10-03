import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';

abstract class BookRepository {
  Future<Either<Failure, String>> addBooks(BookEntity bookEntity);
  Future<Either<Failure, List<BookEntity>>> getBooks();
  Future<Either<Failure, BookEntity>> getSingleBook(String id);
  Future<Either<Failure, String>> deleteBook(String id);
  Future<Either<Failure, List<BookEntity>>> getBookByCategory(String id);
}
