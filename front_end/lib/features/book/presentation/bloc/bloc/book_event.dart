part of 'book_bloc.dart';

sealed class BookEvent {
  const BookEvent();
}

class AddBookEvent extends BookEvent {
  final BookEntity bookEntity;
  const AddBookEvent({required this.bookEntity});
}

class GetAllBooksEvent extends BookEvent {
  const GetAllBooksEvent();
}

class GetSingleBookEvent extends BookEvent {
  final String id;
  GetSingleBookEvent(this.id);
}

class DeleteBookEvent extends BookEvent {
  final String id;
  DeleteBookEvent(this.id);
}

class GetBooksByCategory extends BookEvent {
  final String category;
  GetBooksByCategory(this.category);
}

class ResetBookStateEvent extends BookEvent {
  const ResetBookStateEvent();
}
