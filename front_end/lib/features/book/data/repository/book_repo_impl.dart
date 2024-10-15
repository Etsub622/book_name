import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/exceptions.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/network/network.dart';
import 'package:front_end/features/book/data/datasource/local_datasource/get_books_local_datasource.dart';
import 'package:front_end/features/book/data/datasource/remote_datasource/book_remote_source.dart';
import 'package:front_end/features/book/data/model/book_model.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class BookRepoImpl implements BookRepository {
  final BookRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final GetBooksLocalDataSource localDataSource;
  BookRepoImpl(this.remoteDataSource, this.networkInfo, this.localDataSource);

  @override
  Future<Either<Failure, String>> addBooks(BookEntity bookEntity) async {
    if (await networkInfo.isConnected) {
      try {
        final book = BookModel(
            id: bookEntity.id,
            title: bookEntity.title,
            author: bookEntity.author,
            description: bookEntity.description,
            imageUrl: bookEntity.imageUrl,
            category: bookEntity.category,
            price: bookEntity.price);
        final res = await remoteDataSource.addBooks(book);
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
  Future<Either<Failure, List<BookEntity>>> getBooks() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBooks = await remoteDataSource.getBooks();
        localDataSource.cacheBooks(remoteBooks);
        final bookEntities =
            remoteBooks.map((book) => book.toEntity()).toList();
        return Right(bookEntities);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      try {
        final localBooks = await localDataSource.getLastBooks();
        final bookEntities = localBooks.map((book) => book.toEntity()).toList();
        return Right(bookEntities);
      } on CacheException {
        return Left(CacheFailure(message: 'Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, BookEntity>> getSingleBook(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBook = await remoteDataSource.getSingleBook(id);

        final bookEntity = remoteBook.toEntity();
        return Right(bookEntity);
      } on ServerException {
        throw ServerFailure(message: 'Server Failure');
      }
    } else {
      return Left(
          NetworkFailure(message: 'You are not connected to the internet'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteBook(String id) async {
    try {
      final res = await remoteDataSource.deleteBook(id);
      print(Right(res));

      return Right('Book deleted successfully');
    } on ServerException {
      return Left(ServerFailure(message: 'server failure'));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> getBookByCategory(
      String category) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteBooks = await remoteDataSource.getBookByCategory(category);
        localDataSource.cacheBooks(remoteBooks);
        final bookEntities =
            remoteBooks.map((book) => book.toEntity()).toList();
        return Right(bookEntities);
      } on ServerException {
        return Left(ServerFailure(message: 'Server Failure'));
      }
    } else {
      try {
        final localBooks = await localDataSource.getLastBooks();
        final bookEntities = localBooks.map((book) => book.toEntity()).toList();
        return Right(bookEntities);
      } on CacheException {
        return Left(CacheFailure(message: 'Cache Failure'));
      }
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> search(String title) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.search(title);
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
  Future<Either<Failure, String>> update(
      BookEntity bookEntity, String id) async {
    if (await networkInfo.isConnected) {
      try {
        final book = BookModel(
            id: bookEntity.id,
            title: bookEntity.title,
            author: bookEntity.author,
            description: bookEntity.description,
            imageUrl: bookEntity.imageUrl,
            category: bookEntity.category,
            price: bookEntity.price);
        final res = await remoteDataSource.update(id, book);
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
}
