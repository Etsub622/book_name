import 'package:dartz/dartz.dart';
import 'package:front_end/core/error/failures.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/repository/book_repo.dart';

class UpdateBookUsecase implements UseCase<String, UpdateParams> {
  final BookRepository repository;
  UpdateBookUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateParams params) async {
    return repository.update(params.book, params.id);
  }
}

class UpdateParams {
  final String id;
  final BookEntity book;
  UpdateParams(this.id, this.book);
}
