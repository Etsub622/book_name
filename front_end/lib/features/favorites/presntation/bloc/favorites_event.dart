part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesEvent {}

class AddFavoriteEvent extends FavoritesEvent {
  final BookEntity book;
  AddFavoriteEvent(this.book);
}

class RemoveFavoriteEvent extends FavoritesEvent {
  final BookEntity book;
  RemoveFavoriteEvent(this.book);
}

class LoadFavoritesEvent extends FavoritesEvent{}