part of 'book_bloc.dart';

sealed class BookState {}

final class BookInitial extends BookState {}

class BookLoading extends BookState {}

class BookLoaded extends BookState {
  final List<BookEntity> books;
  BookLoaded({required this.books});
}

class SingleBookLoaded extends BookState {
  final BookEntity book;
  SingleBookLoaded(this.book);
}

class BookError extends BookState {
  final String message;
  BookError({required this.message});
}

class BookAdded extends BookState {
  final String message;
  BookAdded({required this.message});
}

class BookDeleted extends BookState {
  final String message;
  BookDeleted(this.message);
}

class BookUpdated extends BookState {
  final String message;
  BookUpdated({required this.message});
}

class SearchLoad extends BookState {
  final List<BookEntity> books;
  SearchLoad(this.books);
}
