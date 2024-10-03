import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class DeleteBookUsecase extends UseCase<String, DeleteParams> {
  final BookRepository bookRepository;
  DeleteBookUsecase(this.bookRepository);
  @override
  Future<Either<Failure, String>> call(DeleteParams param) async {
    return bookRepository.deleteBook(param.id);
  }
}

class DeleteParams {
  final String id;
  DeleteParams(this.id);
}
