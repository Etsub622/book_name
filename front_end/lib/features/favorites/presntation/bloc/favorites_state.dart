part of 'favorites_bloc.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoriteLoad extends FavoritesState {
  final List<BookEntity> favoritebooks;
  FavoriteLoad(this.favoritebooks);
}

final class FavoriteError extends FavoritesState {
  final String message;

  FavoriteError(this.message);
}
