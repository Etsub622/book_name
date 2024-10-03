import 'package:bloc/bloc.dart';
import 'package:front_end/core/usecase/usecase.dart';
import 'package:front_end/features/book/domain/entity/book_entity.dart';
import 'package:front_end/features/book/domain/usecase/book_list_usecase.dart';
import 'package:front_end/features/book/domain/usecase/book_usecase.dart';
import 'package:front_end/features/book/domain/usecase/delete_book_usecase.dart';
import 'package:front_end/features/book/domain/usecase/get_single_book_usecase.dart';
part 'book_event.dart';
part 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  final BookUseCase bookUseCase;
  final GetAllBooksUsecase getAllBooksUsecase;
  final GetSingleBookUsecase singleBookUsecase;
  final DeleteBookUsecase deleteBookUsecase;
  final GetBookByCategoryUsecase getBooksByCategory;
  BookBloc(this.bookUseCase, this.getAllBooksUsecase, this.deleteBookUsecase,
      this.singleBookUsecase, this.getBooksByCategory)
      : super(BookInitial()) {
    on<AddBookEvent>((event, emit) async {
      emit(BookLoading());

      final book = await bookUseCase(BookParams(event.bookEntity));

      book.fold((l) {
        emit(BookError(message: l.message));
      }, (r) {
        emit(BookAdded(message: r));
      });
    });

    on<GetAllBooksEvent>((event, emit) async {
      emit(BookLoading());

      final book = await getAllBooksUsecase(NoParams());

      book.fold((l) {
        emit(BookError(message: l.message));
      }, (books) {
        emit(BookLoaded(books: books));
      });
    });

    on<GetSingleBookEvent>((event, emit) async {
      emit(BookLoading());

      final book = await singleBookUsecase(GetbookParms(event.id));

      book.fold((l) {
        emit(BookError(message: l.message));
      }, (book) {
        emit(SingleBookLoaded(book));
      });
    });

    on<GetBooksByCategory>((event, emit) async {
      emit(BookLoading());

      final book = await getBooksByCategory(BookCategoryParmas(event.category));

      book.fold((l) {
        emit(BookError(message: l.message));
      }, (books) {
        emit(BookLoaded(books: books));
      });
    });

    on<DeleteBookEvent>((event, emit) async {
      emit(BookLoading());

      final book = await deleteBookUsecase(DeleteParams(event.id));

      book.fold((l) {
        emit(BookError(message: l.message));
      }, (book) {
        emit(BookDeleted('Book deleted'));
      });
    });

    on<ResetBookStateEvent>((event, emit) async {
      emit(BookInitial());
    });
  }
}
